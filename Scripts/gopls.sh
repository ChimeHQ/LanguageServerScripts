#!/bin/bash

set -euo pipefail

function set_gopls() {
	capture_environment

	GOBIN=`go env GOBIN`

	if [[ -z "${GOBIN}" ]]; then
		GOBIN=${HOME}/go/bin
	fi

	GOPLS="${GOBIN}/gopls"
}

function version() {
	set_gopls

	$GOPLS version
}

function install() {
	set_gopls

	if [ -f $GOPLS ]; then
		exit 0
	fi

	go install "golang.org/x/tools/gopls@latest"
}

function update() {
	capture_environment

	go install "golang.org/x/tools/gopls@latest"
}

function run() {
	set_gopls

	$GOPLS
}

source "$(dirname "$0")/cli.sh"
