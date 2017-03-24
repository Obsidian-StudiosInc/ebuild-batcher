#!/bin/bash
# Copyright 2017 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to remove stale CVS header # $Id$

COMMIT_MSG="Removed CVS header"
TREE="/usr/portage/local/os-xtoo"
PATTERN="\#\ \\\$"

cd ${TREE} || exit 1

PKGS=($( grep -ls "${PATTERN}" */*/*ebuild ))

batch_cmds() {
	echo "${COMMIT_MSG} -> ${ebuild}"
	sed -i "/${PATTERN}/d" ${ebuild} || return 1
	return 0
}
