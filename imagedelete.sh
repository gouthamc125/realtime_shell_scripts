#!/bin/bash

# Define your private container registry
#PRIVATE_REGISTRY="your-private-registry-url"

# Get a list of all images currently in use (associated with running containers)
used_images=$(docker ps --format '{{.Image}}' | sort | uniq)

# Get a list of all local Docker images
all_images=$(docker images --format '{{.Repository}}:{{.Tag}}')

# Loop through all local images
for image in $all_images; do
    # Check if the image is not in use
    if [[ ! "$used_images" =~ $(basename "$image") ]]; then
        echo "Processing image: $image"
        
        # Extract the repository and tag
        repository=$(echo "$image" | cut -d: -f1)
        tag=$(echo "$image" | cut -d: -f2)

        # Backup the image to the private container registry
        #backup_image="$PRIVATE_REGISTRY/$repository:$tag"
        #echo "Tagging image for backup: $backup_image"
        #docker tag "$image" "$backup_image"
        
        #echo "Pushing image to private registry: $backup_image"
        #docker push "$backup_image"
        
        # Remove the local image after backup
        echo "Removing local image: $image"
        docker rmi "$image"
    else
        echo "Skipping in-use image: $image"
    fi
done

echo "Old image cleanup complete."

