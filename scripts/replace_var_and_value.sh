#!/bin/bash
# Copyright 2016-2018 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to replace a variable and value with a new one

OLD_VAR="${2}"
NEW_VAR="${3}"
NEW_VALUE="${4}"

COMMIT_MSG="Replace ${2}=* -> ${3}=\"${4}\""
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -l "${2}\=" */*/*.ebuild ))

batch_cmds() {
	echo "${COMMIT_MSG} -> ${ebuild}"
	sed -i -e 's|'${OLD_VAR}'=.*|'${NEW_VAR}'="'${NEW_VALUE}'"|' \
		${ebuild} || return 1
	return 0
}
