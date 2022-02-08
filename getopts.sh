#!/usr/bin/env sh

me="${0##*/}"
nocolor="\033[0m"
red="\033[31m"

notice(){ printf %s"${1}\n" 1>&2; }
error_msg(){ notice "${red}error: ${1}${nocolor}"; exit 1; }

usage(){
  printf %s"Usage: [-d] [-q] [-s TIME]
Options:
  -d, --debug           run in development mode
  -q, --quiet           don't print info messages
  -s, --sleep TIME      sleep the TIME interval from 1 to 5 seconds

Examples:
  ${me} --debug --quiet --sleep 2
  ${me} -d -q -s 1
"
  exit 1
}

## check if argument is within range
## usage:
##  range_arg key "1-5"
##  range_arg key "1" "2" "3" "4" "5"
##  range_arg key "a-cA-C"
##  range_arg key "a" "b" "c" "A" "B" "C"
range_arg(){
  list="${*}"
  eval var='$'"${1}"
  range="${list#"${1} "}"
  if [ -n "${var:-}" ]; then
    success=0
    for tests in ${range}; do
      ## it needs to expand for ranges 'a-z' to be evaluated, and not considered as a value to be used
      # shellcheck disable=SC2295
      [ "${var%%*[^${tests}]*}" ] && success=1
    done
    ## if not withing range, fail and show the fixed range that can be used
    [ ${success} -ne 1 ] && error_msg "Option '${opt_orig}'can not be '${var}'! It can only be: ${range}."
  fi
}

## if option requires argument, check if it was provided, if yes, assign the arg to the opt
## $arg was already assigned, and if valid, will use it for the key value
## usage: get_arg key
get_arg(){
  ## if argument is empty or starts with '-', fail as it possibly is an option
  case "${arg}" in ""|-*) error_msg "Option '${opt_orig}' requires an argument.";; esac
  ## assign
  value="${arg}"
  ## Escaping quotes is needed because else it will fail if the argument is quoted
  # shellcheck disable=SC2140
  eval "${1}"="\"${value}\""

  ## shift positional argument two times, as this option demands argument, unless they are separated by equal sign '='
  ## shift_n default value was assigned when trimming hifens '--' from the options
  ## if shift_n is equal to zero, '--option arg'
  ## if shift_n is not equal to zero, '--option=arg'
  [ -z "${shift_n}" ] && shift_n=2
}

## at least one option is necessary
[ -z "${1}" ] && usage

## hacky getopts
## accepts long (--option) and short (-o) options
## accept argument assignment with space (--option arg | -o arg) or equal sign (--option=arg | -o=arg)
while :; do
  ## '--option=value' should shift once and '--option value' should shift twice
  ## but at this point it is not possible to be sure if option requires an argument
  ## reset shift to zero, at the end, if it is still 0, it will be assigned to one
  ## has to be zero here so we can check later if option argument is separated by space ' ' or equal sign '='
  shift_n=""
  opt_orig="${1}" ## save opt orig for error message to understand which opt failed
  case "${opt_orig}" in
    --*=*) opt="${1%=*}"; opt="${opt#*--}"; arg="${1#*=}"; shift_n=1;; ## long option '--sleep=1'
    -*=*) opt="${1%=*}"; opt="${opt#*-}"; arg="${1#*=}"; shift_n=1;; ## short option '-s=1'
    --*) opt="${1#*--}"; arg="${2}";; ## long option '--sleep 1'
    -*) opt="${1#*-}"; arg="${2}";; ## short option '-s 1'
    "") break;; ## options ended
    *) usage;; ## not an option
  esac
  case "${opt}" in
    s|s=*|sleep|sleep=*) ## main action, require argument
      ## option requires argument
      get_arg sleep_n
      ## check if argument is within the range we need
      #range_arg sleep_n "1" "2" "3" "4" "5"
      range_arg sleep_n "1-5"
    ;;
    q|quiet) quiet=1;; ## helpful messages can be omitted
    d|debug) set -x;; ## useful for debugging
    -) shift 1; break;; ## this is '--', used to stop option parsing
    "") break;; ## no more options, break loop
    h|help|*) usage;; ## help is calling
  esac
  ## shift as many times as demanded
  ## if empty, shift at least once to pass to next option
  shift "${shift_n:-1}"
done

## default values
: "${quiet:=0}"

## enforce mandatory argument
[ -z "${sleep_n}" ] && error_msg "Sleep must not be blank"

# shellcheck disable=SC2154
[ "${quiet}" -eq 0 ] && printf '%s\n' "Sleeping interval of '${sleep_n}'"
# shellcheck disable=2086
sleep ${sleep_n}