#!/bin/bash
# Copyright 2017 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to update package slot

if [[ -z ${2} ]]; then
	echo "Error package name not specified, arg 2"
	exit 1
fi

if [[ -z ${3} ]]; then
	echo "Error new package slot not specified, arg 3"
	exit 1
fi

if [[ -z ${4} ]]; then
	echo "Error old package slot pattern not specified"
	exit 1
fi

PKG="$2"
SLOT="$3"
PATTERN="$4"

COMMIT_MSG="Bump slot -> ${PKG}:${SLOT}"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -ls "${PKG}:${PATTERN}" */*/*ebuild ))

batch_cmds() {
	echo "Updating ${PKG} -> ${ebuild}"
	sed -i -e "s|${PKG}:${PATTERN}|${PKG}:${SLOT}|" ${ebuild} \
		|| return 1
	return 0
}
