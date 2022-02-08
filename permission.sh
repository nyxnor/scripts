#!/usr/bin/env sh

me="${0##*/}"
nocolor="\033[0m"
red="\033[31m"

notice(){ printf %s"${1}\n" 1>&2; }
error_msg(){ notice "${red}error: ${1}${nocolor}"; exit 1; }

usage(){
  printf %s"Usage: [sec|cnf] <FOLDER>
Options:
  sec FOLDER            secret keys permission folder set to 700 and files set to 600
  cnf FOLDER            configuration data permission folder set to 755 and files set to 644

Examples:
  ${me} sec /var/lib/tor
  ${me} cnf /etc/tor
"
  exit 1
}

[ "$(id -u)" -ne 0 ] && error_msg "run as root"


case "${1}" in
  sec)
    find "${3}" -type d -exec chmod 700 {} \;
    find "${3}" -type f -exec chmod 600 {} \;
  ;;
  cnf|conf)
    find "${3}" -type d -exec chmod 755 {} \;
    find "${3}" -type f -exec chmod 644 {} \;
  ;;
  *) usage
esac
