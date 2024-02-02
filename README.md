# LanguageServerScripts
A collection of standardized scripts for managing [LSP][languageserverprotocol] language servers with a Swift API

Installing, updating, and running language servers is tricky. It can be complex, and is almost always very server-specific. The idea here is to establish a standarized script API so applications can use the servers while sharing common infrastructure for managing them.

This repo is also a Swift package that includes facilities for installation, should you be in control of a non-sandboxed app. Otherwise, the scripts themselves are available to be used directly for other installation mechanisms, including manual.

> [!WARNING]
> This is currenty very WIP. Layout and API still preliminary.

## Sandboxing

In general, language servers will not work when run inside a sandbox. A secondary benefit of standarized scripts is use with the [NSUserUnixTask](https://developer.apple.com/documentation/foundation/nsuserunixtask) API on macOS. This is a facility that allows out-of-sandbox process execution, which is perfect for this use. However, for this to work, the scripts need to be installed somehow, and that cannot be done by a sandboxed process.

This repo also includes a **global** registry of applications that would like to participate in the shared script model. The idea is any one application will install the necessary components to **all** targets in the registry. This way, once a users machine is set up for one app, it will also be prepared for all.

## The API

For this abstraction to actually work, there needs to be a uniform API for all server scripts:

```
Usage: script.sh [-w path] [-e KEY=VALUE] command

Supported commands: install, update, version, run

  -e: set an environment variable. Can be set multiple times.
  -w: change the working directory for the command.
```

Remember that this scripts are designed to be compatible with `NSUserUnixTask`. This means they cannot change working directory or set environment variables externally. This all must be handled from within the script.

## Example

```sh
# sh gopls.sh -e GOPATH=/Users/me/go -w /Project/Directory run
```

## Common Directory

Server scripts are named after the server, included in single a known location.

```
~/Library/Application Support/com.chimehq.LanguageServerScripts/gopls.sh
```

## Global Client List

If you choose, your process's bundle id can be added to a global list. Clients can then automatically create a symlink within your `Application Scripts` directory to `com.chimehq.LanguageServerScripts` so that the common directory will be accessible to you from within the sandbox. 

```
~/Library/Application Scripts/com.chimehq.Edit
~/Library/Application Scripts/com.chimehq.Edit.Clojure
~/Library/Application Scripts/com.chimehq.Edit.Elixir
~/Library/Application Scripts/com.chimehq.Edit.Go
~/Library/Application Scripts/com.chimehq.Edit.Python
~/Library/Application Scripts/com.chimehq.Edit.Ruby
~/Library/Application Scripts/com.chimehq.Edit.Rust
~/Library/Application Scripts/com.chimehq.Edit.Swift
```

## Shared command line interface

Bash is hard to use, but the API needs to be standardized. I thought it would be handy to try to have some core logic in a shared script too:

```
/Library/Application Support/com.chimehq.LanguageServerScripts/cli.sh
```

This script:

- parses flags
- determines and excutes the supplied action
- optionally captures the user's shell environment

> [!WARNING]
> Flags are parsed, but currently they have no effect.

Here's an example of how to use this. Note that the `source` command must come after the functions are defined.

```bash
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
```

## Versioning

This scripts will change. How should clients know if they have the latest versions?

```
/Library/Application Support/com.chimehq.LanguageServerScripts/VERSIONS
```

This file will contain a sorted list of name/integer pairs corresponding to the versions of everything inside of this directory except for the VERSIONS file itself.

```
cli.sh 12
gopls.sh 5
imaginary_server.sh 4564
```

Clients are permitted to upgrade any script to a newer version.

## Contributing and Collaboration

I would love to hear from you! Issues or pull requests work great.

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[languageserverprotocol]: https://github.com/ChimeHQ/LanguageServerProtocol
