| writer version blacklist definitions blacklistedClasses blacklistedMethods |

blacklistedClasses := #(
	HDChangeReport
	HDLintReport
	HDCoverageReport
	HDTestCoverage
).

blacklistedMethods := #().

FileStream forceNewFileNamed: 'Jenkins.st' do: [ :stream |
	"stream binary.
	UTF8TextConverter writeBOMOn: stream."
	stream text.
	writer := MCStWriter on: stream.
	writer writeInitializers: false.
	#('HudsonBuildTools20')  do: [ :packageName |
		version := MCVersion package: (MCPackage named: packageName).
		definitions := version snapshot definitions.
		definitions := definitions reject: [:def | blacklistedClasses includes: def className ].
		definitions := definitions reject: [:def | def isMethodDefinition and: [blacklistedMethods includes: def selector] ].
		writer writeDefinitions: definitions.].
].

