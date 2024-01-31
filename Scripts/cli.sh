#!/bin/bash

set -euo pipefail

# This determines and re-creates the user's login shell environment. Many servers servers depend on correct shell configuration. Users tend to not realize this, and since they often will test a server from their own shell, things work fine.
#
# Three variables appear to be required for this shell to start, TERM, HOME, and PATH. These are inherited from the current shell.
function capture_environment() {
	ENV_OUTPUT=`TERM=$TERM HOME=$HOME PATH=$PATH $SHELL -ilc env`

	IFS=$'\n' ENV_ARRAY=( $ENV_OUTPUT )

	for pair in ${ENV_ARRAY[@]}; do
		echo "exporting: $pair"
		export $pair
	done
}

# parse option flags
while getopts "e:hw:" flag; do
	case $flag in
	e)
		echo "have to set environment variable: $OPTARG"
		;;
	h)
		echo "Usage: script.sh [-w path] [-e KEY=VALUE] command"
		echo ""
		echo "Supported commands: install, update, version, run"
		echo ""
		echo "  -e: set an environment variable. Can be set multiple times."
		echo "  -w: change the working directory for the command."

		exit 0
		;;
	w)
		echo "have to change working directory: $OPTARG"
		;;
	\?)
		exit 1
		;;
	esac
done

# remove all flags parsed by getopts
shift $(($OPTIND - 1))

# execute script command, deferring to pre-defined functions
case $1 in
	install)
		install
		;;

	update)
		update
		;;

	version)
		version
		;;

	run)
		run
		;;

	*)
		echo "unrecognized command: $1"

		exit 1
		;;
esac
