#!/bin/bash
# Copyright 2016 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to sed change A to B

if [[ -z ${2} ]]; then
	echo "Error commit message prefix not specified, arg 2"
	exit 1
fi

if [[ -z ${3} ]]; then
	echo "Error sed pattern A not specified, arg 3"
	exit 1
fi

if [[ -z ${4} ]]; then
	echo "Error sed replacement B not specified, arg 4"
	exit 1
fi

_A="${3}"
_B="${4}"

COMMIT_MSG="${2} ${_A} -> ${_B}"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -ls "${_A}" */*/*ebuild ))

batch_cmds() {
	echo "${ebuild}: ${COMMIT_MSG}"
	sed -i --follow-symlinks -e "s|${_A}|${_B}|g" ${ebuild} || return 1
	return 0
}
