#!/bin/bash
# Copyright 2016 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to update guava slot

GUAVA="20"
COMMIT_MSG="Bumped to guava:${GUAVA}"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=($( grep -ls 'guava:[189]\+' */*/*ebuild ))

batch_cmds() {
	echo "Updating guava -> ${ebuild}"
	sed -i -e "s|guava:[189]\+|guava:20|" ${ebuild} \
		|| return 1
	return 0
}
