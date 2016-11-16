#!/bin/bash
# Copyright 2016 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to switch from zip to tar.gz

COMMIT_MSG="Switched from zip -> tar.gz"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -ls "github.*zip" */*/*ebuild ))

batch_cmds() {
	echo "Switching -> ${ebuild}"
	sed -i 's/\.zip/\.tar\.gz/g' ${ebuild} || return 1

	if [[ $(grep "app-arch/unzip" ${ebuild})  ]]; then
		sed -i 's|app-arch/unzip.*||' ${ebuild} || return 1
	fi
	return 0
}
