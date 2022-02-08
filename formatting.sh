#!/usr/bin/env sh

# shellcheck disable=SC2034

me="${0##*/}"

## Coloring the script helps to emphasize on important information, such as errors and warnings
nocolor="\033[0m"
bold="\033[1m"
nobold="\033[22m"
underline="\033[4m"
nounderline="\033[24m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"


## notice will the script name on front
notice(){ printf %s"${me}: ${1}\n"; }
## if test failes, error out, send error message, and exit unsucessfully, a non zero error code
error_msg(){ notice "${red}error: ${1}${nocolor}" >&2; exit 1; }

notice "This is a notice"
error_msg "This is an error"