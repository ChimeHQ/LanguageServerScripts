// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "LanguageServerScripts",
	products: [
		.library(name: "LanguageServerScripts", targets: ["LanguageServerScripts"]),
	],
	targets: [
		.target(name: "LanguageServerScripts"),
		.testTarget(name: "LanguageServerScriptsTests", dependencies: ["LanguageServerScripts"]),
	]
)
