# lexet
Emacs build with useful utils configured for speed and comfortable writing code from console or UI versions of emacs. 

# Dependences

- docker
- make
- ssh

# Install

execute:
```
make install
make init
```

# Run

execute:
to run in console version
```
lexet <path-to-project>
```
to run UI version
```
lexetx <path-to-project>
```
or
```
lexetxs <path-to-project>
```


# Development
this section for developers

## Build
to build docker image execute folowing commands:
```
make build
```


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
| paste next        | M-y        |



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
| Action title       | Shortcut   |
| ------------------ | :--------: |
| set selection mark | C-Space    |
| select word        | C-s C-w    |
| move selected up   | M-up       |
| move selected down | M-down     |



### Dired Mod
| Action title       | Shortcut   |
| ------------------ | :--------: |
| open dired browser | C-x d      |
| help               | ?          |
| move up            | up         |
| move down          | down       |
| open file/dir      | return     |
| refresh            | g          |
| create dir         | +          |
| copy               | C          |
| rename             | R          |
| delete             | d          |
| chmod              | M          |
| jum to file        | j          |



### Work with file browsing
| Action title        | Shortcut   |
| ------------------- | :--------: |
| open file browser   | C-x d      |



#### Work with file browser
| Action title                                       | Shortcut              |
| -------------------------------------------------- | :-------------------: |
| exit file browser                                  | q                     |
| move up to previous line                           | p                     |
| move down to next line                             | n                     |
| move up to previous directory line                 | <                     |
| move down to next directory line                   | >                     |
| move to next marked file                           | M-}                   |
| move to previous marked file                       | M-{                   |
| move up to previous subdirectory                   | M-C-p                 |
| move down to next subdirectory                     | M-C-n                 |
| move to parent directory                           | ^                     |
| move to first child subdirectory                   | M-C-d                 |
|                                                    |                       |
| visit current file                                 | f                     |
| view current file                                  | v                     |
| visit current file in other window                 | o                     |
| create a new sub-directory                         | +                     |
| compare file at point with the one at mark         | =                     |
|                                                    |                       |
| mark a file or subdirectory for later commands     | m                     |
| unmark a file or all files of a subdirectory       | u                     |
| unmark all marked files in a buffer                | M-delete              |
| mark files with a given extension                  | * .                   |
| mark all directories                               | * /                   |
| mark all symlinks                                  | * @                   |
| mark all executables                               | * *                   |
| invert marking                                     | t                     |
| mark all files in the current subdir               | * s                   |
| mark file names matching a regular expression      | * %                   |
| change the marks to a different character          | * c                   |
| mark files for which Elisp expression returns      | t * (                 |
|                                                    |                       |
| insert a subdirectory into this buffer             | i                     |
| remove marked files from the listing               | k                     |
| remove a subdir listing                            | C-u k                 |
| re-read all directories (retains all marks)        | g                     |
| toggle sorting of current subdir by name/date      | s                     |
| edit ls switches                                   | C-u s                 |
| recover marks, hidden lines, and such (undo)       | C-_                   |
| hide all subdirectories                            | M-$                   |
| hide or unhide subdirectory                        | $                     |
|                                                    |                       |
| copy file(s)                                       | C                     |
| rename a file or move files to another directory   | R                     |
| change ownership of file(s)                        | O                     |
| change the group of the file(s)                    | G                     |
| change mode of file(s)                             | M                     |
| print file(s)                                      | P                     |
| convert filename(s) to lower case                  | % l                   |
| convert filename(s) to upper case                  | % u                   |
| delete marked (as opposed to flagged) file(s)      | D                     |
| compress or uncompress file(s)                     | Z                     |
| run info on file                                   | I (DX)                |
| make symbolic link(s)                              | S                     |
| make relative symbolic link(s)                     | Y                     |
| make hard link(s)                                  | H                     |
| search files for a regular expression              | A                     |
| regexp query replace on marked files               | Q                     |
| byte-compile file(s)                               | B                     |
| load file(s)                                       | L                     |
| shell command on file(s)                           | !                     |
| asynchronous shell command on file(s)              | &                     |
|                                                    |                       |
| flag file for deletion                             | d                     |
| flag all backup files (file names ending in ˜)     | ~                     |
| flag all auto-save files                           | #                     |
| flag various intermediate files                    | % &                   |
| flag numeric backups (ending in .˜1˜, .˜2˜, etc.)  | .                     |
| execute the deletions requested (flagged files)    | x                     |
| flag files matching a regular expression           | % d                   |
|                                                    |                       |
| mark filenames matching a regular expression       | % m                   |
| copy marked files by regexp                        | % C                   |
| rename marked files by regexp                      | % R                   |
| hardlink                                           | % H                   |
| symlink                                            | % S                   |
| symlink, with relative paths                       | % Y                   |
| mark for deletion                                  | % d                   |
|                                                    |                       |
| dired file(s) whose name matches a pattern         | M-x find-name-dired   |
| dired file(s) that contain pattern                 | M-x find-grep-dired   |
| dired file(s) based on find output                 | M-x find-dired        |
|                                                    |                       |
| dired help                                         | h                     |
| dired summary (short help) and error log           | ?                     |



## Work with git gutter
| Action title         | Shortcut   |
| -------------------- | :--------: |
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
| mark next like selected      | C-c m n    |
| mark previous like selected  | C-c m p    |
| mark all like selected       | C-c m a    |



## Work with Projectile
| Action title                          | Shortcut   |
| ------------------------------------- | :--------: |
| Help                                  | C-c p C-h  |
| Find file                             | C-c p f    |
| Run grep on the files in the project. | C-c p s g  |
|                                       |            |

[Here](Https://Projectile.Readthedocs.Io/En/Latest/Usage/) Detailed Map key bindings



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
| Action title                            | Shortcut   |
| --------------------------------------- | :--------: |
| move forward                            | C-M-f      |
| move backward                           | C-M-b      |
|                                         |            |
