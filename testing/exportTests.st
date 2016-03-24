| writer version blacklist definitions blacklistedClasses blacklistedMethods |

blacklistedClasses := #(
	ASTTransformExamplePluginActive
	OCCompilerTest
	MCServerRegistry
	EventManagerTest
	RPackageMCSynchronisationTest
	RPackageCategorySynchronisationTest
	RPackageClassesSynchronisationTest
	RPackageExtensionMethodsSynchronisationTest
	RPackageMethodsSynchronisationTest
	RPackageMonticelloSynchronisationTest
	RPackageTraitSynchronisationTest
).
blacklistedMethods := #(
testPercentEncodingHiragana
testNext
testPeek
testPeekFor
testReset
testUpToEnd
testMultistringFont
testInBlockArgumentInstanceVariableShadowing
testExportAMethodWithLangTag
testImportAMethodWithLangTag
testSplitStringOnRegex
testFindTokens
testFindTokensEscapedBy
testFindTokensIncludes
).
"HTTPEncodingTest"

FileStream forceNewFileNamed: 'Tests.st' do: [ :stream |
	writer := MCStWriter on: stream.
	writer writeInitializers: false.
	#('RPackage-Tests' 'Collections-Tests' 'Kernel-Tests' 'AST-Tests-Core' 'Announcements-Tests-Core' 'Compression-Tests' 'FileSystem-Tests-Core' 
	'FileSystem-Tests-Disk' 'Files-Tests' 'JobsTests'  'Multilingual-Tests' 'NodeNavigation-Test' 'OpalCompiler-Tests'  'Random-Tests' 'ReleaseTests'
	'Ring-Tests-Kernel'  'Ring-Tests-Containers' 'Tests'
	'FileSystem-Memory')  do: [ :packageName |
		version := MCVersion package: (MCPackage named: packageName).
		definitions := version snapshot definitions.
		definitions := definitions reject: [:def | blacklistedClasses includes: def className ].
		definitions := definitions reject: [:def | def isMethodDefinition and: [blacklistedMethods includes: def selector] ].
		writer writeDefinitions: definitions.].
].

