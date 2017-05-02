#!/bin/bash

mkdir xmldatadumps
mkdir xmldatadumps/public

declare -a arr=("de" "en" "es" "fr" "ja" "pt" "zh")

for i in "${arr[@]}"; do
   mkdir xmldatadumps/public/"$i"wiki/
   mkdir xmldatadumps/public/"$i"wiki/20170101 
done

find xmldatadumps

for i in "${arr[@]}"; do
    wget -nc -O /data/wikipedia/xmldatadumps/public/"$i"wiki/20170101/"$i"wiki-20170101-stub-meta-history.xml.gz http://dumps.wikimedia.your.org/"$i"wiki/20170101/"$i"wiki-20170101-stub-meta-history.xml.gz --show-progress
    sleep 5s
done
