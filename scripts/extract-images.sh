#!/bin/bash -xe
# make a list of every image that is used anywhere in this folder
find .. -name "*y*ml" -exec grep -e 'image:' {} \; | grep -v 'Values' |
sed "s/.*image: \?//g" | 
sort | uniq
