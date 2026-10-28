# branding/

Assets that replace Chromium's. `tooling/apply-branding` copies them over the checkout before `gn gen`. The copy is what a rebase sees, so these files never conflict as a patch. Upstream chooses `chromium/` or `google_chrome/` and has no third directory. Grit names `chromium/` in its includes, so the files overwrite that tree in place. The rest of the design is the Branding section of [docs/ARCHITECTURE.md](../docs/ARCHITECTURE.md#branding).

The script runs on macOS (Apple silicon) and on Windows. `--check` reports what would change and writes nothing. A run leaves the Chromium checkout dirty, which is what `git status` shows.

## What replaces what

| Path here | Replaces in the Chromium checkout |
|---|---|
| `BRANDING` | `chrome/app/theme/chromium/BRANDING` |
| `mac/app.icns` | `chrome/app/theme/chromium/mac/app.icns` |
| `mac/AppIcon.icon` | `chrome/app/theme/chromium/mac/AppIcon.icon` |
| `mac/Assets.car` | `chrome/app/theme/chromium/mac/Assets.car` |
| `product_logo/product_logo.svg`, `product_logo_{16,24,48,64,128,256}.png`, `product_logo_22_mono.png` | the same names under `chrome/app/theme/chromium/` |
| `product_logo/scaled_100/`, `scaled_200/` | `chrome/app/theme/default_{100,200}_percent/chromium/` (`product_logo_16.png`, `product_logo_32.png`, `product_logo_name_22.png`, `product_logo_name_22_white.png`) |
| `vector_icons/chrome_product.icon` | `components/omnibox/browser/vector_icons/chrome_product.icon` |
| `vector_icons/product_refresh.icon` | `components/vector_icons/chromium/product_refresh.icon` |
| `webui_images/chrome_logo_dark.svg` | `ui/webui/resources/images/chrome_logo_dark.svg` |
| `favicon/scaled_100/`, `scaled_200/` | `ui/resources/default_{100,200}_percent/common/default_favicon*.png` |
| `win/app.ico`, `win/doc.ico`, `win/pdf.ico` | `chrome/app/theme/chromium/win/chromium.ico`, `chromium_doc.ico`, `chromium_pdf.ico` |
| `win/Logo.png`, `win/SmallLogo.png` | `chrome/app/theme/chromium/win/tiles/Logo.png` and `SmallLogo.png` |

`BRANDING` holds the product name, the company line, the copyright and the macOS bundle id. Its format is below.

`product_logo.svg` is the profile picker's logo. The PNGs beside it are the product icon at those sizes, including the shortcut icons. `product_logo_22_mono.png` is the macOS status item. `generate.py` also writes `product_logo_22.png` and `product_logo_32.png` at the top of `product_logo/`. The copy does not install them. The 32 px logo the build uses is the scaled `product_logo_32.png`.

That scaled file is what `chrome://theme/current-channel-logo` serves. A WebUI toolbar (settings, history, downloads) uses it in light mode and `chrome_logo_dark.svg`, the white mark, in dark mode. The About page uses the channel logo in either mode. `product_logo_name_22.png` and `product_logo_name_22_white.png` are the payment request dialog's logo, light and dark.

`chrome_product.icon` replaces `omnibox::kChromeProductIcon`: the chip on a chrome:// page, and rows that draw the same icon, including the default-browser item in the app menu. `product_refresh.icon` replaces `vector_icons::kProductRefreshIcon`. The rounded icons are on in every Stedding build (patch 0042). An infobar that speaks for the browser then uses the refresh icon in light mode and the product icon in dark mode. "Continue where you left off" and the default-browser prompt are two of those infobars.

The favicons are the icon of a page with none of its own: a tab's row, a bookmark, a history entry. The `_dark` files are for a dark ground.

The Windows `.ico` files are the application, HTML document and PDF document icons: the taskbar, the title bar, Explorer, the Start menu and Alt-Tab. `Logo.png` and `SmallLogo.png` are the Start menu tiles (`Square150x150Logo`, and `Square70x70Logo` with `Square44x44Logo`).

## The BRANDING file

`BRANDING` is a data file in a format Chromium defines. `build/util/version.py` reads every line with `split('=', 1)`, so each line is `KEY=VALUE`. A comment or a blank line raises. The failure comes later, inside `gn gen`, as `branding.gni: Script returned non-zero exit code` and a Python traceback. `tooling/apply-branding` checks the file the same way before it installs it. Explanations belong in this README.

## Generated, not authored

`logo/`, `public/`, `mac/` and the top level of `product_logo/` come from:

```bash
python3 tooling/brand/generate.py
```

The geometry is `tooling/brand/mark.py`. Change the mark and re-run. Do not hand-edit the SVGs, PNGs, `app.icns`, `Assets.car` or `AppIcon.icon`.

`win/` comes from `python3 tooling/brand/win_icons.py`, using the 256 px logo that `generate.py` wrote.

`favicon/` comes from `python3 tooling/brand/favicon.py`, which renders `favicon/world-www.svg`. That drawing is Tabler's `world-www` icon (https://github.com/tabler/tabler-icons, MIT; the licence is `favicon/LICENSE-tabler-icons`), in the colours of the Chromium globe it replaces.

`generate.py` does not write `BRANDING`, `product_logo/scaled_100/`, `product_logo/scaled_200/`, `vector_icons/chrome_product.icon`, `vector_icons/product_refresh.icon` or `webui_images/chrome_logo_dark.svg`. Those are kept by hand and follow the mark when it changes.

`public/` is a drop-in web brand folder: favicons, the social card, and the icon and logo variants in SVG and PNG. The palette is at the top of `tooling/brand/mark.py`. [docs/VISION.md](../docs/VISION.md#brand-and-voice) gives the reasoning.

## The macOS icon

The app bundle ships `app.icns` and `Assets.car`. Replacing `app.icns` alone leaves the previous icon on macOS 11 and later. `Assets.car` is compiled from `mac/Assets.xcassets` with `actool`, for macOS 11 and later. `AppIcon.icon` is macOS 26's layered format, normally authored in Icon Composer. `generate.py` writes it as a JSON manifest over two SVG layers, the arch and the hearth, and leaves the material, the shadow and the glass to macOS.

## The product name

The name is not one of these assets. `apply-branding` runs `tooling/brand/product_name.py`, which rewrites the word Chromium to Stedding in four branded string tables and in every locale's translations of them:

- `chrome/app/chromium_strings.grd`
- `chrome/app/settings_chromium_strings.grdp`
- `components/components_chromium_strings.grd`
- `extensions/strings/extensions_chromium_strings.grdp`

ChromiumOS and ChromiumUpdater stay as they are. So does the Chromium project name in the About page's license line (`IDS_VERSION_UI_LICENSE`): "Stedding is made possible by the Chromium open source project and other open source software."

## Reverting

`tooling/apply-branding --revert` checks the overwritten files back out, and the rewritten string tables and translations with them.
