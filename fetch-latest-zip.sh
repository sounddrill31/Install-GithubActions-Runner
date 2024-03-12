#!/bin/bash

#Zip download
rm -rf y17ltebuilds ~/actions-runner || true
if [[ -d "$HOME/actions-runner" ]]; then # Run if github actions runner is installed
  echo "Runner is already installed!"
else
  mkdir ~/actions-runner
  echo "Installing Runner!" #Create folder and download zip
  echo "Downloading Zip"
  version=$(curl -s "https://api.github.com/repos/actions/runner/releases/latest" | grep -oP '"tag_name": "\K[^"]*' | sed 's/^v//')
  url=$(echo "$response" | grep -oP '"browser_download_url": "\K[^"]*' | grep 'linux-x64.tar.gz')
  
  if [[ -z "${version}" ]]; then
    echo "Failed to retrieve the version number"
    exit 1
  fi # Fetch version
  
  url=https://github.com/actions/runner/releases/download/v${version}/actions-runner-linux-x64-${version}.tar.gz # Fetch URL
  url=$(echo "$url" | xargs) # Remove leading/trailing whitespace
  if ! wget -O ~/actions-runner/actions-runner-linux-x64.tar.gz "${url}"; then
    echo "Failed to download the runner package"
  exit 1
  fi
  
  echo "Extracting Zip"
  tar -xvfC ~/actions-runner ~/actions-runner/actions-runner-linux-x64.tar.gz
  echo "Removing Leftovers"
  rm -rf ~/actions-runner/actions-runner-linux-x64.tar.gz # Extract package and remove leftovers
fi
mv ~/actions-runner y17ltebuilds
