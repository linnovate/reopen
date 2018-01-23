#!/bin/bash -xe
./extract-images.sh | tee images

for extracted_image in `cat images`; do 
	docker pull $extracted_image;
done
