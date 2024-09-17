// swift-tools-version: 5.9

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

let swiftSettings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency")
]

for target in package.targets {
	var settings = target.swiftSettings ?? []
	settings.append(contentsOf: swiftSettings)
	target.swiftSettings = settings
}
