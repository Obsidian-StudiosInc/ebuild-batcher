#!/bin/bash
# Copyright 2016 Obsidian-Studios, Inc.
# Author William L. Thomson Jr.
#        wlt@o-sinc.com
#
# Distributed under the terms of The GNU Public License v3.0 (GPLv3)

while :
do
	case "$1" in
		-m | --merge)
			MERGE=0
			shift
			;;
		-*)
			echo "Error: Unknown option: $1 >&2"
			exit 2
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
	echo "Error batch command file not specified"
	exit 1
fi

if [[ ! ${COMMIT_MSG} ]]; then
	echo "COMMIT_MSG=${COMMIT_MSG}"
	exit 1
fi

if [[ ! ${PKGS} ]]; then
	echo "Error PKGS not set"
	exit 1
fi

skip() {
	if [[ ${1} -ne 0 ]]; then
		git reset
		git checkout -- .
		echo "Skipping -> ${pkg}"
	fi
	return ${1}
}

batch() {
	local pkg
	for pkg in ${PKGS[@]}; do
		# skip symlinks, modify real packages only
		[[ -L ${pkg} ]] && continue
		local cat_dir="$( dirname ${pkg} )"
		local category="$( dirname ${cat_dir} )"
		local ebuild="$( basename ${pkg} )"

		cd "${TREE}/${cat_dir}"

		batch_cmds
		! skip $? && continue

		ebuild ${ebuild} digest
		! skip $? && continue

		if [[ ${MERGE} ]]; then
			sudo emerge -qv1 =${category}/${ebuild/\.ebuild/}
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
