#!/bin/bash
# Copyright 2016-2018 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to modify MY_PV

COMMIT_MSG="Modified PV"
TREE="/usr/portage/local/os-xtoo"

cd "${TREE}" || exit 1

PKGS=($( ls dev-java/glassfish-hk2*/*ebuild ))

batch_cmds() {
	echo "${COMMIT_MSG} -> ${ebuild}"
	sed -i -e 's|MY_PV="${PV/_beta/-b0}"|MY_PV="${PV%*_beta*}-b$( printf "%02d" ${PV#*_beta*})"|' \
		${ebuild} || return 1
	return 0
}
