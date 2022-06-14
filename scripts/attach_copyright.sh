#!/bin/bash

HERE="$(dirname "$0")"
# Locate and array filenames of all Dart files in this repository which do not contain "Copyright YYYY-YYYY Workiva".
IFS=$'\n' read -r -d '' -a FILES <<<"$(find . -type f -name '*.dart' -print0 | xargs -0 grep -E -L 'Copyright \d+-\d+ Workiva')"

echo "Scanning files and attaching copyright..."

for FILE in "${FILES[@]}"; do
    mv "$FILE" "$FILE".old
    cat "$HERE"/copyright_notice.txt "$FILE".old > "$FILE"
    rm "$FILE".old
    printf 'Updated: %s\n' "$FILE"
done

echo "...done."
