#!/bin/bash -xe

registry=localhost:5000

docker login $registry

for new_image in `cat images`; do
	full_image_name=$registry/$new_image 
	docker tag $new_image $full_image_name
	docker push $full_image_name
done
