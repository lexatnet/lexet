#!/bin/bash

ssh -v -X -p 2222 -i ~/.ide/projects/.home.aromanov.git.lex.emacs-ide/.ssh/key -o 'IdentitiesOnly yes' root@localhost
