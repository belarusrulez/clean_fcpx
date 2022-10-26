#!/bin/bash
if [ $# -lt 1 ]; then
    echo "need library directory path"
    exit 1
fi
cd "$1"
dir_name=$(basename $(pwd))
echo "$(pwd)"
array=( $(find . -type f -name 'CurrentVersion.fcpevent'  -maxdepth 2 -mindepth 2 | sed -r 's|/[^/]+$||' |sort |uniq) )
echo "$array"
# loop over it
# shellcheck disable=SC2068
for i in ${array[@]}
do
    echo "rm -rf $1/$i/Render\ Files"
    rm -rf $1/$i/Render\ Files
    echo "rm -rf $1/$i/Shared\ Items"
    rm -rf $1/$i/Shared\ Items
    echo "rm -rf $1/$i/Transcoded\ Media"
    rm -rf $1/$i/Transcoded\ Media
    rm -rf $1/.fcpcache
done
cd ..
rm -rf "$dir_name".zip
echo "zip  --symlinks -r "$dir_name".zip "$dir_name""
zip --symlinks -r "$dir_name".zip "$dir_name"