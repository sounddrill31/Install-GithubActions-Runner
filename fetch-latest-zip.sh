#!/bin/bash

#Zip download
if [[ -d "$HOME/actions-runner" ]]; then # Run if github actions runner is installed
  echo "Runner is already installed!"
else
  mkdir ~/actions-runner
  cd ~/actions-runner
  echo "Installing Runner!" #Create folder and download zip
  echo "Downloading Zip"
  response=$(curl -s "https://api.github.com/repos/actions/runner/releases/latest")
  version=$(echo "$response" | grep -oP '"tag_name": v"\K[^"]*'| sed 's/^v//')
  url=$(echo "$response" | grep -oP '"browser_download_url": "\K[^"]*' | grep 'linux-x64.tar.gz')
  
  if [[ -z "${version}" ]]; then
    echo "Failed to retrieve the version number"
    exit 1
  fi # Fetch version
  
  url=https://github.com/actions/runner/releases/download/v${version}/actions-runner-linux-x64-${version}.tar.gz # Fetch URL
  url=$(echo "$url" | xargs) # Remove leading/trailing whitespace
  if ! wget -O actions-runner-linux-x64.tar.gz "${url}"; then
    echo "Failed to download the runner package"
  exit 1
  fi
  
  echo "Extracting Zip"
  tar -xvf actions-runner-linux-x64.tar.gz
  echo "Removing Leftovers"
  rm -rf actions-runner-linux-x64.tar.gz # Extract package and remove leftovers
fi
