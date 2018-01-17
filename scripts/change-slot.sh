#!/bin/bash
# Copyright 2016-2018 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to change slot

COMMIT_MSG="Changed hardcoded slot"
TREE="/usr/portage/local/os-xtoo"
PATTERN="SLOT\=\"3\""

cd ${TREE} || exit 1

PKGS=($( grep -ls "${PATTERN}" */*/*ebuild ))

batch_cmds() {
	echo "${MSG} -> ${ebuild}"
	sed -i -e "s|${PATTERN}|SLOT=\"$\(get_major_version\)\"|" ${ebuild} \
		|| return 1
	return 0
}
