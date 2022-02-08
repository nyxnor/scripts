#!/usr/bin/env sh

# shellcheck disable=SC2034

## Useful expansions

## see what values are being assigned to each variable
set -x

## this script name
## me=script.sh
me="${0##*/}"

## relative directory path to this script, in other words, the base folder
## me=/path/to/this/script
me_dir="${0%/*}"

## if the positional argument $1 is not provided (unset or empty), use default value for it
## this value will be assigned to variable, not to $1
variable="${1:-default}"

## almost the same as above, if variable TMPDIR is unset or empty, assign it to positional argument $2
## if positional argument $2 is unset or empty, use default value for it
##  this means that $2 will not have the default value later on, it will just be used once in this expatnion
## folder will not be empty if it was exported or sourced
## it is commonly used for environment variables or sourced configuration fies
folder="${TMPDIR:="${2:-"/tmp"}"}"
## a lot of times it is needed to get the folder without the last forward slash so files can be ammended to it
## wrong: folder=/tmp/
## right: folder=/tmp
## so lets get everything until the last forward slash, excluding it, so we can get the right folder path
folder="${folder%*/}"
## not it is possible to use folder in conjunction with file, separated by a forward slash
file_path="${folder}/file"

## lets divide the host from the port
addr_port="127.0.0.1:80"
## get the port by removing everything till the last colon ':'
port="${addr_port##*:}"
## get the host/addr by removing everything after the most distant colon ':'
addr="${addr_port%%:*}"
