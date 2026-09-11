#!/bin/sh

# Copyright 2020 Traceable, Inc.
#
# Licensed under the Apache License, Version 2.0 (the “License”);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an “AS IS” BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -x
set -e
cd "$(dirname $0)"
scripts=$(find ../../../services/ -name 'build-image*' -print0 | xargs -0 -I{} echo {})
for script in ${scripts}
do
    echo "Executing $script"
    bash -x -- "$script"
done

if [ -z "${DOCKER_REGISTRY}" ]; then 
  DOCKER_REGISTRY=crapi
fi
export DOCKER_REGISTRY

# Deploy to local repository
docker images | grep crapi | grep -v '/' | awk '{print $1}' | while read -r image; do
    sanitized_image=$(printf '%q' "$image")
    docker tag "$sanitized_image" "${DOCKER_REGISTRY}/$sanitized_image:v1"
done
docker images | grep crapi | grep "${DOCKER_REGISTRY}/" | grep v1 | awk '{print $1":"$2}' | while read -r image_tag; do
    sanitized_image_tag=$(printf '%q' "$image_tag")
    docker push "$sanitized_image_tag"
done
