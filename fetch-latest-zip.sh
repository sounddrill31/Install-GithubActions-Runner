#!/bin/bash

#Zip download
if [[ -d "$HOME/actions-runner" ]]; then # Run if github actions runner is installed
  echo "Runner is already installed!"
else
  echo "Installing Runner!" #Installing runner if the folder is not there
  version=$(curl -sI -o /dev/null https://github.com/actions/runner/releases/latest | grep -o 'location: .*' | head -n 1 | awk -F / '{print $NF}' | cut -d '?' -f 1)
  
  if [[ -z "${version}" ]]; then
    echo "Failed to retrieve the version number"
    exit 1
  fi
  
  url=https://github.com/actions/runner/releases/download/v${version}/actions-runner-linux-x64-${version}.tar.gz
  
  if ! wget -O actions-runner-linux-x64.tar.gz "${url}"; then
    echo "Failed to download the runner package"
  exit 1
  fi
fi
