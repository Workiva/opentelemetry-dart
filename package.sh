#!/bin/bash
set -e

mkdir pub_temp

# Make a copy of the directories we want to publish, with symlinks expanded
[ -d lib ] && cp -R -L lib pub_temp/lib

# Make a copy of the files we want to publish
[ -f CHANGELOG.md ] && cp CHANGELOG.md pub_temp/
[ -f LICENSE ] && cp LICENSE pub_temp/
[ -f NOTICE ] && cp NOTICE pub_temp/
[ -f README.md ] && cp README.md pub_temp/
[ -f analysis_options.yaml ] && cp analysis_options.yaml pub_temp/
[ -f pubspec.yaml ] && cp pubspec.yaml pub_temp/

# Generate the final publishable artifact
cd pub_temp
tar czf ../pub_package.pub.tgz $(ls -d CHANGELOG.md LICENSE NOTICE README.md analysis_options.yaml build.yaml pubspec.yaml lib/ 2>/dev/null)
cd ../

# Clean up
rm -rf pub_temp
