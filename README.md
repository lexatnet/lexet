# Lexet
Atom editor with useful environment.



# Download
You can download latest AppImage version from [releases](https://github.com/lexatnet/lexet/releases) page.



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

`<path-to-AppImage>` [-h] [-H HOME] [-c CONFIG] [-a {run, test}]
                [-m {atom, python}]

optional arguments:

-h, --help  Shows help message

-H `<HOME>`, --home `<HOME>` Path to lexet local files. Default: `~/.lexet`

-c `<CONFIG>`, --config `<CONFIG>` Path to config. Default: `~/.lexet/config`

-a {run, test}, --action {run} For future extensions of functionality. Default: `run`

-m {atom, python}, --mode {atom, python} Allows to run application in console mode. Default: `atom`

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
