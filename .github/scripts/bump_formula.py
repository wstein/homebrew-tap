#!/usr/bin/env python3
"""Bump url/sha256 in a formula to a new upstream version.

Usage: bump_formula.py <formula> <version>

The tap owns the formula structure; this only rewrites release URLs and
their checksums. Checksums are computed from the downloaded assets.
"""
import hashlib
import re
import sys
import urllib.request
from pathlib import Path

SEMVER = re.compile(r"^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$")
URL_LINE = re.compile(r'^(?P<indent>\s*)url "(?P<url>[^"]+)"\n(?P=indent)sha256 "[0-9a-f]{64}"$', re.M)

# formula -> (regex matching the version inside a url, template for the new url)
FORMULAE = {
    "cx-cli": (
        re.compile(r"cx-cli-(\d[^/]*)\.tgz$"),
        lambda url, v: re.sub(r"cx-cli-\d[^/]*\.tgz$", f"cx-cli-{v}.tgz", url),
    ),
    "histlog": (
        re.compile(r"/v(\d[^/]*)/histlog-"),
        lambda url, v: re.sub(r"/v\d[^/]*/", f"/v{v}/", re.sub(r"-v\d[^/]*\.tar\.gz$", f"-v{v}.tar.gz", url)),
    ),
}


def sha256_of(url: str) -> str:
    h = hashlib.sha256()
    with urllib.request.urlopen(url, timeout=120) as r:
        while chunk := r.read(1 << 20):
            h.update(chunk)
    return h.hexdigest()


def main() -> int:
    if len(sys.argv) != 3:
        print(__doc__, file=sys.stderr)
        return 2
    formula, version = sys.argv[1], sys.argv[2].removeprefix("v")
    if formula not in FORMULAE:
        print(f"unknown formula: {formula}", file=sys.stderr)
        return 2
    if not SEMVER.match(version):
        print(f"invalid version: {version}", file=sys.stderr)
        return 2

    path = Path("Formula") / f"{formula}.rb"
    text = path.read_text()
    _, build_url = FORMULAE[formula]

    def repl(m: re.Match) -> str:
        new_url = build_url(m["url"], version)
        digest = sha256_of(new_url)
        print(f"{new_url} {digest}")
        return f'{m["indent"]}url "{new_url}"\n{m["indent"]}sha256 "{digest}"'

    new_text, n = URL_LINE.subn(repl, text)
    if n == 0:
        print("no url/sha256 pair found", file=sys.stderr)
        return 1
    path.write_text(new_text)
    return 0


if __name__ == "__main__":
    sys.exit(main())
