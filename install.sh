#!/bin/bash

if [[ -n "$CODESPACES" ]]
then
  NVIM_VERSION=v0.7.2 scripts/codespaces-install.sh
else
  scripts/macos-install.sh
fi
