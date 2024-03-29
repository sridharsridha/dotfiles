#!/bin/bash

# Recursively delete files that match a certain pattern
# (by default delete all `.DS_Store` files)
nuke() {
    local q="${1:-*.DS_Store}"
    find . -type f -name "$q" -ls -delete
}
