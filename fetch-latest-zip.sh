#!/bin/bash

#Zip download
if [[ -d "$HOME/actions-runner" ]]; then # Run if github actions runner is installed
  echo "Runner is already installed!"
else
  mkdir ~/actions-runner
  cd ~/actions-runner
  echo "Installing Runner!" #Create folder and download zip
  echo "Downloading Zip"
  version=$(curl -sI https://github.com/actions/runner/releases/latest | grep -o 'location: .*' | head -n 1 | awk -F / '{print $NF}' | cut -d '?' -f 1)
  
  if [[ -z "${version}" ]]; then
    echo "Failed to retrieve the version number"
    exit 1
  fi # Fetch version
  
  url=https://github.com/actions/runner/releases/download/v${version}/actions-runner-linux-x64-${version}.tar.gz # Fetch URL
  
  if ! wget -O actions-runner-linux-x64.tar.gz "${url}"; then
    echo "Failed to download the runner package"
  exit 1
  fi
  
  echo "Extracting Zip"
  tar -xvf actions-runner-linux-x64.tar.gz
  echo "Removing Leftovers"
  rm -rf actions-runner-linux-x64.tar.gz # Extract package and remove leftovers
fi
