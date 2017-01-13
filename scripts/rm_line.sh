#!/bin/bash
# Copyright 2016 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

# Batch script file to remove a line

COMMIT_MSG="Removed blank line"
TREE="/usr/portage/local/os-xtoo"

cd ${TREE} || exit 1

PKGS=(
	dev-java/glassfish-hk2-api/glassfish-hk2-api-2.5.0_beta31.ebuild
	dev-java/glassfish-hk2-locator/glassfish-hk2-locator-2.5.0_beta31.ebuild
	dev-java/glassfish-hk2-osgi-resource-locator/glassfish-hk2-osgi-resource-locator-2.5.0_beta31.ebuild
)

batch_cmds() {
	echo "${COMMIT_MSG} -> ${ebuild}"
	sed -i -e '22d' ${ebuild} || return 1
	return 0
}
