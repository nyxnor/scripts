# Scripts - Some critical relevant interesting parsimonious temendrous scripts

Useful configuration files and executables to facilitate every day development.

The intent of this repository is to be an advanced tutorial, but you will have to read scripts instead of markdown, paying attention to the code comments.

---
Table of Contents
---
- [Requirements](#requirements)
- [Configuration files](#configuration-files)
- [Scripts](#scripts)
- [Reading](#reading)
---

## Requirements

- Unix like system with a  POSIX compliant shell (sh, ash, dash, bash, ksh, zsh etc) and standard shell utilities (grep, sed, find etc).
- Some shellscripting knowledge as this is not a begginers guide. To learn, see the [reading](#reading) topic.

## Configuration files

- [.editorconfig](editorconfig) - EditorConfig helps maintain consistent coding styles for multiple developers working on the same project across various editors and IDEs
- [.shellcheckrc](.shellcheckrc) - Shellcheck run commands file


## Scripts

- [check-progs.sh](check-progs.sh) - check if program is installed (placed on PATH) and executable.
- [expansions.sh](expansions.sh) - useful expansions to get script name, correct folder path, assign default values if key is empty or unset.
- [formatting.sh](formatting.sh) - tips on formatting your scripts, dedicated to emphatization, colors, bold, underline, error messages.
- [getopts.sh](getopts.sh) - enhanced getopts to accept long and short options, as well as requiring arguments, checking if arguments are within range, setting default values to not brek tests and arguments expressed after an equal sign (--option=arg).
- [permission.sh](permission.sh) - bulk/recursively permission set for all files and folders inside chosen directory. Commonly used with folder 755 and file 644, or folder 700 and file 600.
- [toc.sh](toc.sh) - build markdown table of contents, check if header is repeated. Requires the header to be set by hashtag (#), not by equals (===) nor by hifens (---).

## Reading

Materials referenced here are a must read before any question is asked.

- [pure-sh-bible](https://github.com/dylanaraps/pure-sh-bible#get-the-base-name-of-a-file-path) - A collection of pure POSIX sh alternatives to external processes.
- [POSIX: Shell & Utilities: Detailed Toc](https://pubs.opengroup.org/onlinepubs/9699919799/utilities/contents.html) - The Open Group Base Specifications Issue 7, 2018 edition, IEEE Std 1003.1-2017 (Revision of IEEE Std 1003.1-2008)


## Development

To add new scripts, the following rules will be taken into consideration:

**Portability**
- POSIX compliant
- Platform agnostic

**Usability**
- It is faster to understand the options and run the script than to do the tasks manually

**Coding style**
- Respects the coding standard or enhances it
- Has code comments
- Has usage message
