#!/bin/bash
# Copyright 2016-2018 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to remove java-pkg_clean

COMMIT_MSG="Removed empty IUSE"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -ls 'IUSE=""' */*/*ebuild ))

batch_cmds() {
	echo "Removing empty IUSE -> ${ebuild}"
	sed -i '/IUSE=""/d' ${ebuild} || return 1
	return 0
}
