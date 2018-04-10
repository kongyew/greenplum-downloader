#!/bin/bash
set -e
set -u
# Debugging
#set -x

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "Running on ${machine}"

if [ "${machine}"  ==  "Mac" ];
then
  brew install jq
  brew install pivotal/tap/pivnet-cli
else
  echo "Error"
  exit 1
fi
