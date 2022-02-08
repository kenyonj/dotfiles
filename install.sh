#!/bin/bash

if [[ -n "$CODESPACES" ]]
then
  scripts/codespaces-install.sh
else
  scripts/macos-install.sh
fi
