#!/bin/bash

apt-get update && apt-get install -y software-properties-common

apt-add-repository ppa:ubuntu-elisp/ppa

apt-get update && apt-get install -y \
        emacs-snapshot \
        mc

