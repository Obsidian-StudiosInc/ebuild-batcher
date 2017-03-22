#!/bin/bash
# Copyright 2016 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to switch SRC_URI from http to https

COMMIT_MSG="SRC_URI http -> https"
TREE="/usr/portage/local/os-xtoo"
PATTERN="SRC_URI\=\"http\:"

cd ${TREE} || exit 1

PKGS=($( grep -ls "${PATTERN}" */*/*ebuild ))

batch_cmds() {
	echo "${COMMIT_MSG} -> ${ebuild}"
	sed -i -e "s|${PATTERN}|${PATTERN/p/ps}|" ${ebuild} \
		|| return 1
	return 0
}
