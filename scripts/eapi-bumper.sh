#!/bin/bash
# Copyright 2016-2018 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to update eapi

EAPI="6"
COMMIT_MSG="Bumped to EAPI=${EAPI}"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -ls 'EAPI="\?5"\?' */*/*ebuild ))

batch_cmds() {
	echo "Updating EAPI -> ${ebuild}"
	sed -i -e "s|EAPI=\"\?[0-9]\"\?|EAPI=\"${EAPI}\"|" ${ebuild} \
		|| return 1
	return 0
}
