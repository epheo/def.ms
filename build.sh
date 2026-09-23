#!/bin/sh
# Renders site/ plus every spec/v*.md into build/.
# gfm input keeps GitHub-style heading ids so in-document links survive.
set -eu

cd "$(dirname "$0")"

rm -rf build
cp -r site build
mkdir -p build/spec

versions=$(ls spec/v*.md 2>/dev/null | sed 's|spec/||; s|\.md$||' | sort -V)
if [ -z "$versions" ]; then
    echo "build.sh: no spec/v*.md found" >&2
    exit 1
fi

render() {
    ver=$1
    out=$2
    mkdir -p "$(dirname "$out")"
    pandoc -f gfm -t html5 --standalone \
        --template spec/template.html \
        --toc --toc-depth=2 \
        --lua-filter spec/table-wrap.lua \
        --metadata title="DEFMS Specification $ver" \
        -o "$out" "spec/$ver.md"
}

for ver in $versions; do
    render "$ver" "build/spec/$ver/index.html"
done

latest=$(echo "$versions" | tail -n 1)
render "$latest" build/spec/index.html
echo "build.sh: rendered $(echo "$versions" | tr '\n' ' ')(latest: $latest)"
