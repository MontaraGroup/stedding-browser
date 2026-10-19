<#
The Ed25519 key that signs Stedding's Windows updates (docs/decisions/0026-a-windows-update-key.md,
docs/features/updates.md Up14-Up21). The key lives on the Windows release PC, outside this
repository and outside AppData (an agent's packaged app sees a virtualised AppData, trap 40):

  %USERPROFILE%\.stedding\update-key\ed25519.pem         the private key, PKCS#8, AES-256 encrypted
  %USERPROFILE%\.stedding\update-key\passphrase.dpapi    its passphrase, DPAPI-protected for this
                                                          Windows account on this machine
  %USERPROFILE%\.stedding\update-key\public.txt          the raw 32-byte public key, base64

Usage (PowerShell):
  update-key.ps1 -Create                 make the key; refuses when one exists
  update-key.ps1 -PublicKey              prints the public key (base64), the one builds carry
  update-key.ps1 -Sign <file>            prints the file's Ed25519 signature (base64)
  update-key.ps1 -Verify <file> -Signature <base64> [-Key <base64>]
                                         exit 0 when the signature verifies
  update-key.ps1 -Backup <folder>        writes the encrypted key there and its passphrase to the
                                         sibling folder <folder>-passphrase, for the operator to
                                         keep in two separate safe places and then delete

The passphrase never leaves DPAPI except into OpenSSL's environment for one call, and into
-Backup's passphrase folder on the operator's word. OpenSSL is Git for Windows' (3.0 or later:
pkeyutl -rawin, which the signing and the check here use, came with 3.0).
#>
param(
  [switch]$Create,
  [switch]$PublicKey,
  [string]$Sign = '',
  [string]$Verify = '',
  [string]$Signature = '',
  [string]$Key = '',
  [string]$Backup = ''
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Security
$dir = Join-Path $env:USERPROFILE '.stedding\update-key'
$pem = Join-Path $dir 'ed25519.pem'
$secret = Join-Path $dir 'passphrase.dpapi'
$pub = Join-Path $dir 'public.txt'

function OpenSsl {
  foreach ($candidate in @('C:\Program Files\Git\mingw64\bin\openssl.exe', 'C:\Program Files\Git\usr\bin\openssl.exe')) {
    if (Test-Path $candidate) { return $candidate }
  }
  $found = Get-Command openssl -ErrorAction SilentlyContinue
  if ($found) { return $found.Source }
  throw 'no openssl.exe: install Git for Windows'
}

function Passphrase {
  $bytes = [IO.File]::ReadAllBytes($secret)
  $plain = [Security.Cryptography.ProtectedData]::Unprotect($bytes, $null, 'CurrentUser')
  return [Text.Encoding]::ASCII.GetString($plain)
}

# Runs OpenSSL with the passphrase in its environment for this call only.
function WithKey([scriptblock]$Body) {
  $env:STEDDING_UPDATE_KEY_PASS = Passphrase
  try { & $Body } finally { Remove-Item Env:\STEDDING_UPDATE_KEY_PASS -ErrorAction SilentlyContinue }
}

$openssl = OpenSsl

if ($Create) {
  if ((Test-Path $pem) -or (Test-Path $secret)) { throw "a key exists at $dir; it is never replaced here" }
  New-Item -ItemType Directory -Force $dir | Out-Null
  $random = New-Object byte[] 32
  [Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($random)
  $pass = [Convert]::ToBase64String($random)
  [IO.File]::WriteAllBytes($secret, [Security.Cryptography.ProtectedData]::Protect([Text.Encoding]::ASCII.GetBytes($pass), $null, 'CurrentUser'))
  $env:STEDDING_UPDATE_KEY_PASS = $pass
  try {
    & $openssl genpkey -algorithm ED25519 -aes-256-cbc -pass env:STEDDING_UPDATE_KEY_PASS -out $pem
    if ($LASTEXITCODE -ne 0) { throw 'openssl genpkey failed' }
    $der = Join-Path $dir 'public.der'
    & $openssl pkey -in $pem -passin env:STEDDING_UPDATE_KEY_PASS -pubout -outform DER -out $der
    if ($LASTEXITCODE -ne 0) { throw 'openssl pkey failed' }
  } finally { Remove-Item Env:\STEDDING_UPDATE_KEY_PASS -ErrorAction SilentlyContinue }
  $bytes = [IO.File]::ReadAllBytes($der)
  # An Ed25519 SubjectPublicKeyInfo ends with the raw 32-byte key.
  $raw = $bytes[($bytes.Length - 32)..($bytes.Length - 1)]
  [IO.File]::WriteAllText($pub, [Convert]::ToBase64String([byte[]]$raw))
  Remove-Item $der
  "created: $dir"
  "public key: $([IO.File]::ReadAllText($pub))"
  exit 0
}

if ($PublicKey) {
  if (-not (Test-Path $pub)) { throw "no key at $dir (run -Create)" }
  [IO.File]::ReadAllText($pub).Trim()
  exit 0
}

if ($Sign) {
  if (-not (Test-Path $pem)) { throw "no key at $dir (run -Create)" }
  $file = (Resolve-Path $Sign).Path
  $out = [IO.Path]::GetTempFileName()
  try {
    WithKey { & $openssl pkeyutl -sign -rawin -inkey $pem -passin env:STEDDING_UPDATE_KEY_PASS -in $file -out $out }
    if ($LASTEXITCODE -ne 0) { throw 'openssl pkeyutl -sign failed' }
    [Convert]::ToBase64String([IO.File]::ReadAllBytes($out))
  } finally { Remove-Item $out -ErrorAction SilentlyContinue }
  exit 0
}

if ($Verify) {
  $file = (Resolve-Path $Verify).Path
  $keyText = if ($Key) { $Key } else { [IO.File]::ReadAllText($pub).Trim() }
  # A SubjectPublicKeyInfo for Ed25519: the fixed 12-byte prefix, then the raw key.
  $prefix = [byte[]](0x30, 0x2a, 0x30, 0x05, 0x06, 0x03, 0x2b, 0x65, 0x70, 0x03, 0x21, 0x00)
  $spki = $prefix + [Convert]::FromBase64String($keyText)
  $keyFile = [IO.Path]::GetTempFileName(); $sigFile = [IO.Path]::GetTempFileName()
  try {
    [IO.File]::WriteAllBytes($keyFile, [byte[]]$spki)
    [IO.File]::WriteAllBytes($sigFile, [Convert]::FromBase64String($Signature))
    & $openssl pkeyutl -verify -rawin -pubin -keyform DER -inkey $keyFile -in $file -sigfile $sigFile | Out-Null
    exit $LASTEXITCODE
  } finally { Remove-Item $keyFile, $sigFile -ErrorAction SilentlyContinue }
}

if ($Backup) {
  if (-not (Test-Path $pem)) { throw "no key at $dir (run -Create)" }
  # The passphrase goes to a folder of its own beside the key's, never next to the key it opens.
  $keyFolder = $Backup.TrimEnd('\', '/')
  if (-not $keyFolder -or $keyFolder.EndsWith(':')) { throw "-Backup needs a folder (E:\stedding-key), not a drive's root: the passphrase goes to a folder beside it" }
  $passFolder = $keyFolder + '-passphrase'
  New-Item -ItemType Directory -Force $keyFolder, $passFolder | Out-Null
  Copy-Item $pem (Join-Path $keyFolder 'ed25519.pem')
  Copy-Item $pub (Join-Path $keyFolder 'public.txt')
  [IO.File]::WriteAllText((Join-Path (Resolve-Path -LiteralPath $passFolder).ProviderPath 'passphrase.txt'), (Passphrase))
  "written: the encrypted key and its public key to $keyFolder, its passphrase to $passFolder. Keep the two folders apart, each somewhere safe, then delete both here."
  exit 0
}

Get-Help $MyInvocation.MyCommand.Path
