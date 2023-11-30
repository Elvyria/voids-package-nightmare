#!/usr/bin/env bash

# Repository Maintenance Tool
# https://github.com/Elvyria/voids-package-nightmare

set -e

export BORDER_FOREGROUND="3"

usage () {
	printf '
Usage:
    gitmare.sh SUBCOMMAND PACKAGE

SUBCOMMAND:
    add        add new package template to repository
    deprecate  deprecate package from repository
    update     commit package changes with version update

DEPENDENCIES:
    gum        (https://github.com/charmbracelet/gum)
'
	exit
}

# Usage:  gitmare.sh update $package
# Result: git commit srcpkgs/$package -m "Update '$package' $old -> $new"
gitmare_update() {
	pkgname="$1"

	. <(git show HEAD~:srcpkgs/$pkgname/template)
	old_v="$version"

	. srcpkgs/$pkgname/template
	new_v="$version"

	[ "$old_v" = "$new_v" ] && echo "Nothing to update" && exit 1

	message="Update '$pkgname' $old_v -> $new_v"
	git_cmd=('git' 'commit' "srcpkgs/$pkgname" '-m' "$message")

	gum style --border=rounded --padding="0 1" -- "$message"
	gum confirm && "${git_cmd[@]}"
}

# Usage:  gitmare.sh add $package
# Result: git commit srcpkgs/$package -m "Added template for '$package'"
gitmare_add() {
	pkgname="$1"

	if [ ! -f "srcpkgs/$pkgname/template" ]; then
		echo "No template"
		exit 1
	fi

	message="Added template for '$pkgname'"
	git_cmd=('git' 'commit' "srcpkgs/$pkgname" '-m' "$message")

	gum style --border=rounded --padding="0 1" -- "$message"
	gum confirm && git add "srcpkgs/$pkgname" && "${git_cmd[@]}"
}

# Usage:  gitmare.sh deprecate $package
# Result: git commit srcpkgs/$package -m "Deprecated '$package'"
gitmare_deprecate() {
	pkgname="$1"

	if [ ! -f "srcpkgs/$pkgname/template" ]; then
		echo 'No template'
		exit 1
	fi

	message="Deprecated '$pkgname'"
	git_cmd=('git' 'commit' "srcpkgs/$pkgname" '-m' "$message")

	gum style --border=rounded --padding="0 1" -- "$message"
	gum confirm && git rm "srcpkgs/$pkgname" && "${git_cmd[@]}"
}

case "$1" in
	add) gitmare_add "$2" ;;
	deprecate) gitmare_deprecate "$2" ;;
	update) gitmare_update "$2" ;;
	*) usage ;;
esac
