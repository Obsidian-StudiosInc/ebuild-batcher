#!/bin/bash
# Copyright 2016-2018 Obsidian-Studios, Inc.
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
  -c, --commit               Commit changes
  -m, --merge                Merge package before commit

 GNU Options:

  -?, --help                 Give this help list
      --usage                Give a short usage message
  -V, --version              Print program version

Copyright 2016-2018 Obsidian-Studios, Inc.
Distributed under the terms of The GNU Public License v3.0 (GPLv3)
"
	[[ $1 ]] && echo "Error: $1"
	exit "$2"
}

while :
do
	case "$1" in
		-c | --commit)
			COMMIT=0
			shift
			;;
		-k | --usepkg)
			USEPKG="k"
			shift
			;;
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
	help "Error PKGS not set" 1
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
	local p
	for p in "${PKGS[@]}"; do
		local category
		local ebuild
		local pkg

		cd "${TREE}/$( dirname "${p}" )" || continue

		category="$( basename "$( dirname "${PWD}" )" )"
		ebuild="${p##*\/}"
		pkg="${p%%\/*}"

		# skip 999, modify version only
		[[ "${ebuild}" == *9999* ]] && continue

		batch_cmds
		! skip $? && continue

		# anything change?
		[[ $(git diff . | wc -l) -eq 0 ]] && continue

		ebuild "${ebuild}" digest
		! skip $? && continue

		if [[ ${MERGE} ]]; then
			sudo emerge -q"${USEPKG}"v1 ="${ebuild/\.ebuild/}"
			! skip $? && continue
		fi

		[[ ${NOCOMMIT} ]] && git add .
		repoman
		! skip $? && continue

		if [[ ${COMMIT} ]]; then
			repoman commit -m "${category}/${pkg}: ${COMMIT_MSG}"
			! skip $? && continue
		fi
	done
}

batch
