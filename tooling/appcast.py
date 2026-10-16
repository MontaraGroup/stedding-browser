#!/usr/bin/env python3
"""Writes Stedding's update feed, updates/appcast.xml (ADR 0022).

Sparkle reads the feed from the repository's main branch. tooling/publish-appcast
calls this with the release it adds; the newest item comes first and the older
ones follow, up to a few, so a Mac whose system the newest no longer supports
still finds the last one that runs there. The feed's own signature is added
afterwards by Sparkle's sign_update, over exactly the text written here.

Usage:
  appcast.py write --feed updates/appcast.xml --repo owner/name --version 0.2.0-beta.16 \
      --bundle-version 10020.16 --minimum-system 12.0 --length 185000000 \
      --signature <base64> --date "Fri, 16 Oct 2026 12:00:00 +0000"
      [--url http://127.0.0.1:8765/Stedding.dmg]   # the n-1 check's own server
  appcast.py check --feed updates/appcast.xml   # parses it and lists the items
  appcast.py selftest
"""

import argparse
import re
import sys
import xml.etree.ElementTree as ET
from xml.sax.saxutils import escape, quoteattr

SPARKLE = 'http://www.andymatuschak.org/xml-namespaces/sparkle'
KEEP = 5
VERSION_RE = re.compile(r'^\d+\.\d+\.\d+(-beta\.\d+)?$')


def _text(item, tag):
    node = item.find(tag)
    return node.text.strip() if node is not None and node.text else ''


def read_items(text):
    """The feed's items as dictionaries, newest first, as written."""
    root = ET.fromstring(text)
    channel = root.find('channel')
    items = []
    for item in channel.findall('item') if channel is not None else []:
        enclosure = item.find('enclosure')
        if enclosure is None:
            continue
        items.append({
            'title': _text(item, 'title'),
            'link': _text(item, 'link'),
            'date': _text(item, 'pubDate'),
            'version': _text(item, '{%s}shortVersionString' % SPARKLE),
            'bundle_version': _text(item, '{%s}version' % SPARKLE),
            'minimum_system': _text(item, '{%s}minimumSystemVersion' % SPARKLE),
            'url': enclosure.get('url', ''),
            'length': enclosure.get('length', ''),
            'signature': enclosure.get('{%s}edSignature' % SPARKLE, ''),
        })
    return items


def title_of(version):
    return 'Stedding ' + version.replace('-beta.', ' beta ')


def item_xml(item):
    return '\n'.join([
        '    <item>',
        '      <title>%s</title>' % escape(item['title']),
        '      <link>%s</link>' % escape(item['link']),
        '      <pubDate>%s</pubDate>' % escape(item['date']),
        '      <sparkle:version>%s</sparkle:version>' % escape(item['bundle_version']),
        '      <sparkle:shortVersionString>%s</sparkle:shortVersionString>'
        % escape(item['version']),
        '      <sparkle:minimumSystemVersion>%s</sparkle:minimumSystemVersion>'
        % escape(item['minimum_system']),
        '      <sparkle:hardwareRequirements>arm64</sparkle:hardwareRequirements>',
        '      <enclosure url=%s length=%s type="application/octet-stream" '
        'sparkle:edSignature=%s/>' % (quoteattr(item['url']),
                                      quoteattr(item['length']),
                                      quoteattr(item['signature'])),
        '    </item>',
    ])


def feed_xml(repo, items):
    releases = 'https://github.com/%s/releases' % repo
    head = [
        '<?xml version="1.0" encoding="utf-8"?>',
        '<rss version="2.0" xmlns:sparkle="%s">' % SPARKLE,
        '  <channel>',
        '    <title>Stedding</title>',
        '    <link>%s</link>' % escape(releases),
        '    <description>New versions of Stedding for the Mac, from the '
        'project’s GitHub releases.</description>',
        '    <language>en</language>',
    ]
    body = [item_xml(item) for item in items]
    return '\n'.join(head + body + ['  </channel>', '</rss>']) + '\n'


def new_item(args):
    if not VERSION_RE.match(args.version):
        raise SystemExit('not a Stedding version: %s' % args.version)
    if not re.match(r'^\d+\.\d+$', args.bundle_version):
        raise SystemExit('not a bundle version: %s' % args.bundle_version)
    if not re.match(r'^\d+$', args.length):
        raise SystemExit('not a length: %s' % args.length)
    if not re.match(r'^[A-Za-z0-9+/]+={0,2}$', args.signature):
        raise SystemExit('not an EdDSA signature: %s' % args.signature)
    tag = 'v' + args.version
    return {
        'title': title_of(args.version),
        'link': 'https://github.com/%s/releases/tag/%s' % (args.repo, tag),
        'date': args.date,
        'version': args.version,
        'bundle_version': args.bundle_version,
        'minimum_system': args.minimum_system,
        'url': getattr(args, 'url', None) or
        'https://github.com/%s/releases/download/%s/Stedding-%s-arm64.dmg'
        % (args.repo, tag, args.version),
        'length': args.length,
        'signature': args.signature,
    }


def write(args):
    try:
        with open(args.feed, encoding='utf-8') as f:
            old = read_items(f.read())
    except FileNotFoundError:
        old = []
    item = new_item(args)
    kept = [o for o in old if o['version'] != item['version']]
    with open(args.feed, 'w', encoding='utf-8') as f:
        f.write(feed_xml(args.repo, [item] + kept[:KEEP - 1]))


def check(args):
    with open(args.feed, encoding='utf-8') as f:
        items = read_items(f.read())
    for item in items:
        print('%s  %s  %s bytes' % (item['version'], item['bundle_version'],
                                    item['length']))
    return 0 if items else 1


def selftest():
    class A:
        pass
    a = A()
    a.repo, a.version, a.bundle_version = 'o/r', '0.2.0-beta.16', '10020.16'
    a.minimum_system, a.length, a.signature = '12.0', '123', 'abc+/='
    a.date = 'Fri, 16 Oct 2026 12:00:00 +0000'
    first = new_item(a)
    text = feed_xml('o/r', [first])
    items = read_items(text)
    assert items == [first], items
    a.version, a.bundle_version = '0.2.0-beta.17', '10020.17'
    second = new_item(a)
    items = read_items(feed_xml('o/r', [second] + items))
    assert [i['version'] for i in items] == ['0.2.0-beta.17', '0.2.0-beta.16']
    assert items[0]['url'].endswith('/v0.2.0-beta.17/Stedding-0.2.0-beta.17-arm64.dmg')
    assert title_of('0.2.0-beta.17') == 'Stedding 0.2.0 beta 17'
    for bad in ('0.2.0-rc.1', 'v0.2.0', '0.2'):
        a.version = bad
        try:
            new_item(a)
        except SystemExit:
            continue
        raise AssertionError('accepted ' + bad)
    print('appcast.py: ok')
    return 0


def main(argv):
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest='command', required=True)
    w = sub.add_parser('write')
    for name in ('feed', 'repo', 'version', 'bundle-version', 'minimum-system',
                 'length', 'signature', 'date'):
        w.add_argument('--' + name, required=True)
    # The n-1 check's local feed serves the image itself (docs/HANDOFF.md,
    # "The updater"); a release's comes from the release.
    w.add_argument('--url')
    c = sub.add_parser('check')
    c.add_argument('--feed', required=True)
    sub.add_parser('selftest')
    args = parser.parse_args(argv)
    if args.command == 'write':
        write(args)
        return 0
    if args.command == 'check':
        return check(args)
    return selftest()


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
