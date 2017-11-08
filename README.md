# ebuild-batcher.sh
[![License](https://img.shields.io/badge/license-GPLv3-9977bb.svg?style=plastic)](https://github.com/Obsidian-StudiosInc/ebuild-batcher/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/Obsidian-StudiosInc/ebuild-batcher/master.svg?colorA=9977bb&style=plastic)](https://travis-ci.org/Obsidian-StudiosInc/ebuild-batcher)
[![Build Status](https://img.shields.io/shippable/5840e5d1b5bc7810005ff861/master.svg?colorA=9977bb&style=plastic)](https://app.shippable.com/projects/5840e5d1b5bc7810005ff861/)

Experimental script for making the same change across all ebuilds that 
need such change. It can be used for things like bumping EAPI, or making 
other changes to ebuilds. This can save allot of time by making minor 
changes against several or all ebuilds in tree.

The script will attempt to make such change for every ebuild specified. 
If it succeeds it will commit the change to git. If it fails, it will 
revert all modifications via git reset and checkout. Therefore should be 
100% safe to use as any failures are reverted to previous state.

## Usage
The script functions off 2 variables and 1 function, all pretty self 
explanatory. Place the variables and function in a file/script of its 
own in any location you choose. Default location is in the provided 
scripts directory. That file/script is passed to ebuild-batcher.sh as 
the first argument, and sourced before run.


```bash
# String commit message
COMMIT_MSG="Change being made"

# Array of ebuilds to be modified
PKGS=( $( grep -ls 'EAPI="\?5"\?' */*/*ebuild  ) )

# Function of commands to run, return 0 on success, 1 on failure
batch_cmds() {
	echo "Making ebuild modification..." || return 1
	return 0
}

```

### Bump slots
Bumping slots on packages is easy using the provided slot-bumper.sh 
script. Just pass a few arguments;
 1. Package Name
 2. New Slot
 3. Old Slot Pattern, plain or regex

Example
```bash
./ebuild-batcher.sh scripts/slot-bumper.sh icu4j 0 59
```

### sed A to B
Sometimes you need to make a change in an ebuild, from A to B. Doing so 
is trivial with the provided sed_a_b.sh script. Just pass a few arguments;
 1. Commit message prefix, A to B will be added
 2. Replacement sed pattern (A), plain or regex
 3. Replacement (B)

Example
```bash
./ebuild-batcher.sh scripts/sed_a_b.sh "Bump eclipse slot" "\"4.6\"" "\"4.7\""
```
*A is used for both grep and sed.*
