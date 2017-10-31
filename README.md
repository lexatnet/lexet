# emacs-ide

Emacs build with useful utils configured for speed and confortable writing code from console.

# Dependences

- docker

# Build

execute:
```
build-docker.sh
```

# Run

execute:
```
run-ide.sh <path-to-project>
```


# Shortcuts

| Action title                 | Shortcut |
| ---------------------------- |:--------:|
| close emacs                  | C-x C-c  |
| Search in buffer             | C-s      |
| Seach backward               | C-r      |
| Replace in buffer            | M-%      |
| Replace by regexp            | C-M-%    |
| Toggle case sensivity search | M-c      |
| Toggle regexp search         | M-r      |
| Edit search string           | M-e      |


# highlighted symbols
| Action title                 | Shortcut   |
| ---------------------------- |:----------:|
| next highlighted symbol      | M-<rigth>  |
| previous highlighted symbol  | M-<left>   |


# highlight
| Action title                      | Shortcut   |
| --------------------------------- |:----------:|
| highlight regions match selected  | C-x C-h    |
| unhighlight all                   | C-x C-a    |


## File

| Action title      | Shortcut |
| ----------------- |:--------:|
| open file         | C-x C-f  |
| save              | C-x C-s  |
| save as           | C-x C-w  |
| save all          | C-x s    |


## Copy-Paste operations

| Action title      | Shortcut |
| ----------------- |:--------:|
| copy              | M-w      |
| cut               | C-w      |
| paste             | C-y      |
| paste next        | M-y      |


## Work with windows

| Action title             | Shortcut |
| ------------------------ |:--------:|
| close window             | C-x 0    |
| split window horizotally | C-x 2    |
| split window vertically  | C-x 3    |
| focus next window        | C-x o    |


## Working with buffers

| Action title      | Shortcut |
| ----------------- |:--------:|
| show buffers list | C-x C-b  |


## working with history

| Action title       | Shortcut |
| ------------------ |:--------:|
| undo               | C-<      |
| redo               | C->      |
| show history tree  | C-x u    |


### Working with history tree

| Action title       | Shortcut |
| ------------------ |:--------:|
| close history tree | q        |
| prewious change    | up       |
| next change        | down     |


## Working with selection

| Action title       | Shortcut |
| ------------------ |:--------:|
| set selection mark | C-Space  |
| select word        | C-s C-w  |


##

| Action title       | Shortcut |
| ------------------ |:--------:|
| move selected up   | M-up     |
| move selected down | M-down   |


## Dired Mod

| Action title       | Shortcut |
| ------------------ |:--------:|
| open dired browser | C-x d    |
| help               | ?        |
| move up            | up       |
| move down          | down     |
| open file/dir      | return   |
| refresh            | g        |
| create dir         | +        |
| copy               | C        |
| rename             | R        |
| delete             | d        |

## Work with file browsing

| Action title        | Shortcut |
| ------------------- |:--------:|
| toggle file tree    | F8       |
| open file browser   | C-x d    |


### Work with file tree
| Action title        | Shortcut |
| ------------------- |:--------:|
| open file from tree | ret      |
| toggle hidden       | S        |

### Work with file browser

| Action title      | Shortcut |
| ----------------- |:--------:|


## Work with git gutter

| Action title      | Shortcut |
| ----------------- |:--------:|


## Checking

| Action title      | Shortcut |
| ----------------- |:--------:|


## Work with Magit
| Action title      | Shortcut |
| ----------------- |:--------:|
| open status       | C-x g    |


## Formatting
| Action title              | Shortcut |
| ------------------------- |:--------:|
| uppercase word            | M-u      |
| lowercase word            | M-l      |
| capitalize word           | M-c      |
| uppercase selection       | C-x C-u  |
| lowercase selection       | C-x C-l  |
| join string with previous | M-^      |
