# ebuild-batcher.sh
[![License](http://img.shields.io/badge/license-GPLv3-blue.svg?style=plastic)](https://github.com/Obsidian-StudiosInc/ebuild-batcher/blob/master/LICENSE)
[![Build Status](https://travis-ci.org/Obsidian-StudiosInc/ebuild-batcher.svg?branch=master)](https://travis-ci.org/Obsidian-StudiosInc/ebuild-batcher)

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
