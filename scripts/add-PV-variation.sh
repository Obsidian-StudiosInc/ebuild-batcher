#!/bin/bash
# Copyright 2016-2018 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to add PV modification

COMMIT_MSG="Add MY_PV, _rc -> .RC"
TREE="/usr/portage/local/os-xtoo"

cd "${TREE}" || exit 1

PKGS=($( ls dev-java/jetty*/*ebuild ))

batch_cmds() {
	echo "${COMMIT_MSG} -> ${ebuild}"
	sed -i '/MY_PV="${PV\/2016\/v2016}"/a MY_PV="${MY_PV/_rc/.RC}"' \
		${ebuild} || return 1
	return 0
}
