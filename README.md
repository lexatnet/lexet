# Lexet
Emacs build with useful utils configured for speed and comfortable writing code from console or UI versions of emacs.



# Download
You can download latest AppImage version from [releases](releases) page.



# Run Lexet

``` bash
<path-to-AppImage> <options>
```
Use -h to get available options



# Tips
If you want run Lexet as

``` bash
lexet <options>
```
For comfortable starting from console recommended I've recommend to chose one of the way you preferred:

## Create symlink
root necessary
``` bash
[sudo] ln -s <path-to-AppImage> /usr/local/bin/lexet
```

## Patch PATH
move AppImage to `~/bin`
``` bash
mkdir ~/bin
mv <path-to-AppImage> ~/bin/lexet
```
update your `~/.bashrc` by following lines
``` bash
export PATH="$HOME/bin:$PATH"
```



# Update
Download new AppImage and override old one by it.



# Uninstall
- Remove Lexet AppImage
- Remove Lexet Home folder : `~/.lexet`(default)
- Remove links on AppImage(if you created links somewhere)


# CLI arguments

`<path-to-AppImage>` [-h] [-H HOME] [-c CONFIG] [-a {install,build,run}]
                [-m {text,ui}] [-p PROJECT]

optional arguments:

-h, --help  Shows help message

-H `<HOME>`, --home `<HOME>` Path to lexet local files. Default: `~/.lexet`

-c `<CONFIG>`, --config `<CONFIG>` Path to config. Default: `~/.lexet/config`

-a {run}, --action {run} For future extensions of functionality. Default: `run`

-m {text,ui}, --mode {text,ui} Allows to run application in console mode. Default: `ui`

-p `<PROJECT>`, --project `<PROJECT>` Path to working directory which you want to open. Default: `current working directory`.



# Usage

## Shortcuts

### Control
| Action title                       | Shortcut   |
| ---------------------------------- | :--------: |
| close emacs                        | C-x C-c    |
| Prefix command to pass argument    | C-u        |
| Toggle case sensivity search       | M-c        |
| Toggle regexp search               | M-r        |
| Edit search string                 | M-e        |
| repeat last command                | C-x z      |
| erject, close, abort               | C-g        |
| zoom in                            | C-x C-+    |
| zoom out                           | C-x C--    |
| zoom reset                         | C-x C-+    |



### Search
| Action title                                            | Shortcut   |
| ------------------------------------------------------- | :--------: |
| Search in buffer                                        | C-s        |
| Seach backward                                          | C-r        |
| Exit and place cursor at original position              | C-g        |
| exit and place cursor at current position               | return     |
| select more strings to the right of cursor              | C-w        |
| Search the “symbol” under cursor, with boundary check   | M-s .      |
| search the word under cursor, with boundary check       | M-s w      |
| Same as isearch but with boundary check                 | M-s _      |
| list matching lines                                     | M-s o      |



### Replace
| Action title                       | Shortcut             |
| ---------------------------------- | :------------------: |
| Replace in buffer                  | M-%                  |
| Replace by regexp                  | C-M-%                |
| Replace occurrence                 | y, space             |
| Skip replace occurrence            | n, delete, backspace |
| Exit replace                       | q, return            |
| replace this occurrence and exit   | .                    |
| go to previous occurrence          | ^                    |
| undo                               | u                    |
| undo all                           | U                    |
| edit replacement                   | e                    |
| replace all                        | Y                    |
| help                               | C-h                  |



### Movements
| Action title                                                      | Shortcuts      |
| ----------------------------------------------------------------- | -------------- |
| Move forward one character                                        | C-f, right     |
| Move backward one character                                       | C-b, left      |
| Move down one screen line                                         | C-n, down      |
| Move up one screen line                                           | C-p, up        |
| Move to the beginning of the line                                 | C-a, home      |
| Move to the end of the line                                       | C-e, end       |
| Move forward one word                                             | M-f            |
| Move backward one word                                            | M-b            |
| Move to first->middle->last line of screen                        | M-r            |
| Move to the top of the buffer                                     | M-<            |
| Move to the end of the buffer                                     | M->            |
| Scroll the display one screen forward                             | C-v, pagedown  |
| Scroll one screen backward                                        | M-v, pageup    |
| Read a number n and move point to buffer position n               | M-g c          |
| Read a number n and move point to the beginning of line number n  | M-g M-g, M-g g |
| Read a number n and move to column n in the current line          | M-g tab        |



### Comments
| Action title                              | Shortcut   |
| ----------------------------------------- | :--------: |
| insert comment or toggle comment region   | M-;        |
| toggle comment                            | C-x C-;    |
| kill comment on current line              | C-u M-;    |
| set comment column                        | C-x ;      |
| insert new line and align comment         | C-M-j, M-j |
| comment all lines in region               | C-c C-c    |



### Highlighted symbols
| Action title                 | Shortcut     |
| ---------------------------- | :----------: |
| next highlighted symbol      | M-rigth      |
| previous highlighted symbol  | M-left       |



### Highlight
| Action title                      | Shortcut     |
| --------------------------------- | :----------: |
| highlight menu                    | C-c h        |
| highlight regions match selected  | C-c h s      |
| next highligted region            | C-c h n      |
| previous highlighted region       | C-c h p      |
| unhighlight all                   | C-c h a      |



### File
| Action title      | Shortcut   |
| ----------------- | :--------: |
| open file         | C-x C-f    |
| save              | C-x C-s    |
| save as           | C-x C-w    |
| save all          | C-x s      |



### Copy-Paste operations
| Action title      | Shortcut   |
| ----------------- | :--------: |
| copy              | M-w        |
| cut               | C-w        |
| paste             | C-y        |
| select paste      | M-y        |



### Work with windows
| Action title             | Shortcut   |
| ------------------------ | :--------: |
| close window             | C-x 0      |
| close other windows      | C-x 1      |
| split window horizotally | C-x 2      |
| split window vertically  | C-x 3      |
| focus next window        | C-x o      |
| toggle split orientation | `C-x |`    |



### Working with buffers
| Action title      | Shortcut   |
| ----------------- | :--------: |
| show buffers list | C-x C-b    |



### Working with history
| Action title       | Shortcut   |
| ------------------ | :--------: |
| undo               | C-/        |
| show history tree  | C-x u      |



#### Working with history tree
| Action title       | Shortcut   |
| ------------------ | :--------: |
| close history tree | q          |
| prewious change    | up         |
| next change        | down       |



### Working with selection
| Action title       | Shortcut       |
| ------------------ | :------------: |
| set selection mark | C-Space, C-@   |
| select word        | C-s C-w        |
| move selected up   | M-up           |
| move selected down | M-down         |
|                    | C-x C-x        |
|                    |                |



### Work with file browsing
| Action title        | Shortcut   |
| ------------------- | :--------: |
| open file browser   | C-x d      |



#### Work with file browser
| Action title                                          | Shortcut              |
| ----------------------------------------------------- | :-------------------: |
| exit file browser                                     | q                     |
| move up to previous line                              | p, up                 |
| move down to next line                                | n, down               |
| move up to previous directory line                    | <                     |
| move down to next directory line                      | >                     |
| move to next marked file                              | M-}                   |
| move to previous marked file                          | M-{                   |
| move up to previous subdirectory                      | M-C-p                 |
| move down to next subdirectory                        | M-C-n                 |
| move to parent directory                              | ^                     |
| move to first child subdirectory                      | M-C-d                 |
| jump to file                                          | j                     |
|                                                       |                       |
| visit current file                                    | f, return             |
| view current file                                     | v                     |
| visit current file in other window                    | o                     |
| create a new sub-directory                            | +                     |
| compare file at point with the one at mark            | =                     |
|                                                       |                       |
| mark a file or subdirectory for later commands        | m                     |
| unmark a file or all files of a subdirectory          | u                     |
| unmark all marked files in a buffer                   | M-delete              |
| mark files with a given extension                     | * .                   |
| mark all directories                                  | * /                   |
| mark all symlinks                                     | * @                   |
| mark all executables                                  | * *                   |
| invert marking                                        | t                     |
| mark all files in the current subdir                  | * s                   |
| mark file names matching a regular expression         | * %                   |
| change the marks to a different character             | * c                   |
| mark files for which Elisp expression returns         | t * (                 |
|                                                       |                       |
| insert a subdirectory into this buffer                | i                     |
| remove marked files from the listing                  | k                     |
| remove a subdir listing                               | C-u k                 |
| re-read all directories (retains all marks), refresh  | g                     |
| toggle sorting of current subdir by name/date         | s                     |
| edit ls switches                                      | C-u s                 |
| recover marks, hidden lines, and such (undo)          | C-_                   |
| hide all subdirectories                               | M-$                   |
| hide or unhide subdirectory                           | $                     |
|                                                       |                       |
| copy file(s)                                          | C                     |
| rename a file or move files to another directory      | R                     |
| change ownership of file(s)                           | O                     |
| change the group of the file(s)                       | G                     |
| change mode of file(s)                                | M                     |
| print file(s)                                         | P                     |
| convert filename(s) to lower case                     | % l                   |
| convert filename(s) to upper case                     | % u                   |
| delete marked (as opposed to flagged) file(s)         | D                     |
| compress or uncompress file(s)                        | Z                     |
| run info on file                                      | I (DX)                |
| make symbolic link(s)                                 | S                     |
| make relative symbolic link(s)                        | Y                     |
| make hard link(s)                                     | H                     |
| search files for a regular expression                 | A                     |
| regexp query replace on marked files                  | Q                     |
| byte-compile file(s)                                  | B                     |
| load file(s)                                          | L                     |
| shell command on file(s)                              | !                     |
| asynchronous shell command on file(s)                 | &                     |
|                                                       |                       |
| flag file for deletion                                | d                     |
| flag all backup files (file names ending in ˜)        | ~                     |
| flag all auto-save files                              | #                     |
| flag various intermediate files                       | % &                   |
| flag numeric backups (ending in .˜1˜, .˜2˜, etc.)     | .                     |
| execute the deletions requested (flagged files)       | x                     |
| flag files matching a regular expression              | % d                   |
|                                                       |                       |
| mark filenames matching a regular expression          | % m                   |
| copy marked files by regexp                           | % C                   |
| rename marked files by regexp                         | % R                   |
| hardlink                                              | % H                   |
| symlink                                               | % S                   |
| symlink, with relative paths                          | % Y                   |
| mark for deletion                                     | % d                   |
|                                                       |                       |
| dired file(s) whose name matches a pattern            | M-x find-name-dired   |
| dired file(s) that contain pattern                    | M-x find-grep-dired   |
| dired file(s) based on find output                    | M-x find-dired        |
|                                                       |                       |
| dired help                                            | h                     |
| dired summary (short help) and error log              | ?                     |



## Work with tree
| Action title         | Shortcut   |
| -------------------- | :--------: |
| menu                 | C-c t      |
| toggle tree          | C-c t t    |
| focus tree           | C-c t b    |



## Work with git gutter
| Action title         | Shortcut   |
| -------------------- | :--------: |
| gutter menu          | C-c g      |
| pop hunk             | C-c g u    |
| revert current       | C-c g r    |
| jump next hunk       | C-c g n    |
| jump previous        | C-c g p    |
| stage current hunk   | C-c g s    |
| mark current hunk    | C-c g m    |



## Checking
| Action title      | Shortcut   |
| ----------------- | :--------: |



## Work with Magit
| Action title      | Shortcut   |
| ----------------- | :--------: |
| open status       | C-x g      |



### Resolve Git Conflicts
| Action title                   | Shortcut   |
| ------------------------------ | :--------: |
| keep current                   | C-c ^ RET  |
| Keep all                       | C-c ^ a    |
| Keep mine                      | C-c ^ m    |
| Keep other                     | C-c ^ o    |
| Move to next conflict in file  | C-c ^ n    |



## Formatting
| Action title              | Shortcut   |
| ------------------------- | :--------: |
| uppercase word            | M-u        |
| lowercase word            | M-l        |
| capitalize word           | M-c        |
| uppercase selection       | C-x C-u    |
| lowercase selection       | C-x C-l    |
| join string with previous | M-^        |



## Multicursor
| Action title                 | Shortcut   |
| ---------------------------- | :--------: |
| multicursor menu             | C-c m      |
| next like this               | C-c m n    |
| skip next                    | C-c m N    |



## Work with Projectile
| Action title                                            | Shortcut   |
| ------------------------------------------------------- | :--------: |
| Help                                                    | C-c p C-h  |
| Switch project                                          | C-C p p    |
| Find file                                               | C-c p f    |
| Display a list of all files in all known projects.      | C-c p F    |
| Run grep on the files in the project.                   | C-c p s g  |
| Display a list of all project buffers currently open.   | C-c p b    |
|                                                         |            |

[Here](https://docs.projectile.mx/en/latest/usage/) Detailed Map key bindings



## Spell checking
| Action title                               | Shortcut   |
| ------------------------------------------ | :--------: |
| spell word or selected region or show menu | M-$        |
| return to spell session                    | C-u M-$    |



### Spell checking menu commands
| Action title                            | Shortcut   |
| -------------------------------------   | :--------: |
| add word to personal dictionary in menu | i          |
| skip word, leave incorrect              | space      |
| accept word for editing session         | a          |
| accept word for buffer editing session  | A          |
| replace                                 | r          |
| replace all in buffer                   | R          |
| exit                                    | x          |
| show list options                       | ?          |



### Hide/Show blocks
| Action title                                | Shortcut                |
| ------------------------------------------- | :---------------------: |
| Hide the current block                      | C-c @ C-h, C-c @ C-d    |
| Show the current block                      | C-c @ C-s               |
| Either hide or show the current block       | C-c @ C-c, C-x @ C-e    |
| Hide all top-level blocks                   | C-c @ C-M-h, C-c @ C-t  |
| Show all blocks in the buffer               | C-c @ C-M-s, C-c @ C-a  |
| Hide all blocks n levels below this block   | C-u n C-c @ C-l         |



### Expand region
| Action title                                                      | Shortcut   |
| ----------------------------------------------------------------- | :--------: |
| Expand region increases the selected region by semantic units.    | C-^        |



### Pairs
| Action title                                                                        | Shortcut        |
| ----------------------------------------------------------------------------------- | :-------------: |
| show Hydra menu                                                                     | C-c s           |
| Change inner (override)                                                             | C-c s o         |
| Kill expression                                                                     | C-c s k         |
| jump to pair forward                                                                | C-c s f         |
| jump to pair backward                                                               | C-c s b         |
| jump to begining wrapping delimiter                                                 | C-c s u         |
| jump to begining current expression                                                 | C-c s d         |
| Jump to end wrapping delimiter                                                      | C-M-e           |
| Jump to end current expression                                                      | C-S-a           |
| Remove the wrapping pair from the this expression.                                  | M-D             |
| Jump to the beginning of current expression, that is after the opening delimiter.   | C-S-d           |
| Jump to the end of current expression, that is before the closing delimiter         | C-S-a           |
| Copy expression                                                                     | C-M-w           |
| Remove the wrapping pair from the following expression                              | M-<delete>      |
| Remove the wrapping pair from the previous expression                               | M-<backspace>   |
|                                                                                     |                 |


### Helm
| Action title                  | shortcut       |
| ----------------------------- | -------------- |
| Buffers menu                  | C-x b          |
| Process list                  | C-x c p        |
|                               |                |
| correct word menu             | C-;            |
| buffer errors list            | C-c c          |
|                               |                |


# Development
this section for developers

## Build

### Dependencies
- docker
- make
- ssh

to build docker image execute folowing commands:

# Build AppImage Builder Docker Image
```
make build-appimage-builder

```


# Build AppImage

```
make build-appimage
```
You could move AppImage to directory which you prefere to store AppImages


