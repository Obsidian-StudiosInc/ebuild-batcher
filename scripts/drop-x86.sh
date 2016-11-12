#!/bin/bash
# Copyright 2016 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to drop x86 keyword

COMMIT_MSG="Dropped keyword x86"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -ls x86 */*/*ebuild ))

batch_cmds() {
	echo "${COMMIT_MSG} -> ${ebuild}"
	sed -i -e "s| ~x86\(-[a-z]*\)\?||g" ${ebuild} || return 1
	return 0
}
