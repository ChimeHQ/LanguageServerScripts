#!/bin/bash

set -euo pipefail

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
		exit 1
		;;
esac
