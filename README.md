# ebuild-batcher.sh
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
explanatory.

```bash
# String commit message
COMMIT_MSG="Change being made"

# Array of ebuilds to be modified
PKGS=( $( grep -ls 'EAPI="\?5"\?' */*/*ebuild  ) )

# Function of commands to run
batch_cmds() {
	echo "Making ebuild modification..."
}

```
