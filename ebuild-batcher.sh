#!/bin/bash
# Copyright 2016-2017 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

VERSION="Version 0.0"

help() {
	local me
        me="${0##*/}"
        echo "Ebuild batcher - Change a batch of ebuild(s)
Usage:
    ${me} <script> [script options]
    ${me} -m <script> [script options]

 Global Options:
  -m, --merge                Merge package before commit

 GNU Options:

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Copyright 2016-2017 Obsidian-Studios, Inc.
Distributed under the terms of The GNU Public License v3.0 (GPLv3)
"
	[[ $1 ]] && echo "Error: $1"
	exit "$2"
}

while :
do
	case "$1" in
		-m | --merge)
			MERGE=0
			shift
			;;
		-V | --version)
		        echo "${VERSION}"
        		exit 0
			;;
		-? | --help)
			help "" 0
			;;
		-*)
			help "Error: Unknown option: $1 >&2" 2
			;;
		*)
			break
			;;
	esac
done

if [[ ${1} ]]; then
	# shellcheck disable=SC1090
	. "${1}"
else
	help "Error batch command file not specified" 1
fi

if [[ ! ${COMMIT_MSG} ]]; then
	help "Error COMMIT_MSG not set" 1
fi

if [[ ! ${PKGS} ]]; then
	help "Error PKGS not set"
fi

skip() {
	if [[ ${1} -ne 0 ]]; then
		git reset
		git checkout -- .
		echo "Skipping -> ${pkg}"
	fi
	return "${1}"
}

batch() {
	local pkg
	for pkg in "${PKGS[@]}"; do
		local cat_dir
		local category
		local ebuild

		cat_dir="$( dirname "${pkg}" )"
		category="$( dirname "${cat_dir}" )"
		ebuild="$( basename "${pkg}" )"

		cd "${TREE}/${cat_dir}" || continue

		# skip 999, modify version only
		[[ "${ebuild}" == *9999* ]] && continue

		batch_cmds
		! skip $? && continue

		ebuild "${ebuild}" digest
		! skip $? && continue

		if [[ ${MERGE} ]]; then
			sudo emerge -qv1 ="${category}/${ebuild/\.ebuild/}"
			! skip $? && continue
		fi

		git add .
		repoman
		! skip $? && continue

		repoman commit -m "${cat_dir}: ${COMMIT_MSG}"
		! skip $? && continue
	done
}

batch
