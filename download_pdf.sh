#!/bin/bash

URLS=$(curl -s oti2019.ro | grep ".pdf" | sed 's/.*href="\(.*\.pdf\)".*/\1/')

while read -r url; do
    echo "Downloading $url..."
    curl -s -O $url
done <<< $URLS
