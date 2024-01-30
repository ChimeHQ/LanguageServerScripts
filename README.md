# LanguageServerScripts
A collection of standardized scripts for managing [LSP][languageserverprotocol] language servers with a Swift API

Installing, updating, and running language servers is tricky. It can be complex, and is almost always very server-specific. The idea here is to establish a standarized script API so applications can use the servers while sharing common infrastructure for managing them.

This repo is also a Swift package that includes facilities for installation, should you be in control of a non-sandboxed app. Otherwise, the scripts themselves are available to be used directly for other installation mechanisms, including manual.

> [!WARNING]
> This is currenty very WIP.

## Sandboxing

In general, language servers will not work when run inside a sandbox. A secondary benefit of standarized scripts is use with the [NSUserUnixTask](https://developer.apple.com/documentation/foundation/nsuserunixtask) API on macOS. This is a facility that allows out-of-sandbox process execution, which is perfect for this use. However, for this to work, the scripts need to be installed somehow, and that cannot be done by a sandboxed process.

This repo also includes a **global** registry of applications that would like to participate in the shared script model. The idea is any one application will install the necessary components to **all** targets in the registry. This way, once a users machine is set up for one app, it will also be prepared for all.

## Contributing and Collaboration

I would love to hear from you! Issues or pull requests work great.

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[languageserverprotocol]: https://github.com/ChimeHQ/LanguageServerProtocol
