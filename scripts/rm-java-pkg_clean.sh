#!/bin/bash
# Copyright 2016-2018 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to remove java-pkg_clean

COMMIT_MSG="Removed java-pkg_clean"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -ls "java-pkg_clean" */*/*ebuild ))

batch_cmds() {
	echo "Removing java-pkg_clean -> ${ebuild}"
	sed -i '/java-pkg_clean/d' ${ebuild} || return 1
	return 0
}
