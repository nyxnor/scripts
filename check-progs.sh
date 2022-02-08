#!/usr/bin/env sh

me="${0##*/}"
nocolor="\033[0m"
red="\033[31m"

notice(){ printf %s"${1}\n" 1>&2; }
error_msg(){ notice "${red}error: ${1}${nocolor}"; exit 1; }

usage(){
  printf %s"Usage: PROG1 PROG2
Examples:
  ${me} sed grep curl wget
"
  exit 1
}

[ -z "${1}" ] && usage

has() {
  _cmd=$(command -v "${1}") 2>/dev/null || return 1
  [ -x "${_cmd}" ] || return 1
}

## check if required programs are installed
check_deps(){
  for item in "${@}"; do
    has "${item}" || dep_miss="${dep_miss} ${item}"
  done
  [ -n "${dep_miss}" ] && error_msg "missing program(s): ${dep_miss}"
  true
}

## get all positional arguments and check if the programs are installed
# shellcheck disable=SC2086
check_deps "${@}"