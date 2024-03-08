#!/bin/bash

# Check if a filename argument was provided
if [ -z "$1" ]
then
   echo "No filename provided. Please provide a shellrc like ~/.bashrc as an argument."
    exit 1
fi

# Set the filename variable
filename=$1

# Check if the alias already exists in the file
if grep -Fxq "alias gh-runner-install='bash ~/actions-runner/scripts/fetch-latest-zip.sh'" $filename
then
    echo "Alias for gh-runner-install already exists in file. Skipping..."
else
    # Add the alias for gh-runner-install to the file
    echo "alias gh-runner-install='bash ~/actions-runner/scripts/fetch-latest-zip.sh'" >> $filename
    echo "Alias for gh-runner-install added to file."
fi

# Check if the alias already exists in the file
if grep -Fxq "alias gh-runner-configure='bash ~/actions-runner/config.sh'" $filename
then
    echo "Alias for gh-runner-configure already exists in file. Skipping..."
else
    # Add the alias for gh-runner-configure to the file
    echo "alias gh-runner-configure='bash ~/actions-runner/config.sh'" >> $filename
    echo "Alias for gh-runner-configure added to file."
fi # Login interactively 

# Check if the alias already exists in the file
if grep -Fxq "alias gh-runner-start='bash ~/actions-runner/scripts/start-tmux.sh'" $filename
then
    echo "Alias for gh-runner-start already exists in file. Skipping..."
else
    # Add the alias for gh-runner-start to the file
    echo "alias gh-runner-start='bash ~/actions-runner/scripts/start-tmux.sh'" >> $filename
    echo "Alias for gh-runner-start added to file."
fi
source $filename
# Succeed
exit 0