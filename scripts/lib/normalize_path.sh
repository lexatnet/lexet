#!/usr/bin/env bash

normalize_path() {
    local path=${1}

    echo $(readlink -m $path)
}
