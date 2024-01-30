#!/bin/bash

set -euo pipefail

function version() {
	echo "print a server-specific version string"
}

function install() {
	echo "install the server"
	echo "this should not do updates, to make the already-installed case fast"
}

function update() {
	echo "update to the latest version of the server"
}

function run() {
	echo "start and run the server"
	echo "must use supplied environment variables"
	echo "and an optional working directory"
}

source "$(dirname "$0")/cli.sh"
