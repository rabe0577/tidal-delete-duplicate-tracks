#!/bin/bash

if [[ $1 != "" ]] && [ -d $1 ]; then
    cd $1
else
    echo "Error: A valid source folder must be specified!"
    echo "Example: bash $(basename "$0") ~/Music/MyLibrary/"
    exit 1
fi

echo "Creating filestructure list ..."

rm -f /tmp/names.lst /tmp/numbers.out
find -type f > /tmp/names.lst
touch /tmp/numbers.out

while read file
do
    number="$( basename "$file" | cut -d" " -f1-2 )"
    dir="$( dirname "$file" )"
    count="$( grep "$dir/$number" /tmp/names.lst | wc -l )"

    if [ $count -gt "1" ]; then
        if !(grep -q "^${dir}/${number}" /tmp/numbers.out); then
            echo "$dir/$number" >> /tmp/numbers.out
        fi
    fi
done < /tmp/names.lst

echo "Creating list done."

while read duplicate_number; do
    for track in `ls -t "$duplicate_number"* | tail -n +2 | sed 's/ /_/g'`; do
        track_name=$(echo $track | sed 's/_/ /g')
        echo "Delete: $track_name"
        rm "$track_name"
    done
done < <(cat /tmp/numbers.out)

echo "All done."