| writer version blacklist definitions blacklistedClasses blacklistedMethods |

blacklistedClasses := #(
	ASTTransformExamplePluginActive
	MCServerRegistry
	EventManagerTest
	RPackageMCSynchronisationTest
	RPackageCategorySynchronisationTest
	RPackageClassesSynchronisationTest
	RPackageExtensionMethodsSynchronisationTest
	RPackageMethodsSynchronisationTest
	RPackageMonticelloSynchronisationTest
	RPackageTraitSynchronisationTest
	OSEnvironmentTest
).

blacklistedMethods := #(
	testInBlockArgumentInstanceVariableShadowing
	testInBlockTempArgumentShadowing
	testInBlockTempInstanceVariableShadowing
	testInBlockTempShadowing
	testInstanceVariableShadowing
	testReservedNameAsBlockArgumentShadowing
	testReservedNameAsMethodArgumentShadowing
	testSiblingBlocksInstanceVariableShadowing
	
	testComplexIsSelfEvaluating

	testExportAMethodWithLangTag
	testSplitStringOnRegex
	
	testEUCJP

	testPercentEncodingHiragana
	testMultistringFont

	testOpening

	testClassWithPluginEnabled

	testUnescapePercentsWithTextEncoding
	testMcWorkingCopy
	testMcPackage
).

FileStream forceNewFileNamed: 'Tests.st' do: [ :stream |
	stream binary.
	UTF8TextConverter writeBOMOn: stream.
	stream text.
	writer := MCStWriter on: stream.
	writer writeInitializers: false.
	#('RPackage-Tests' 'Collections-Tests' 'Kernel-Tests' 'AST-Tests-Core' 'Announcements-Tests-Core' 'Compression-Tests' 'FileSystem-Tests-Core' 
	'FileSystem-Tests-Disk' 'Files-Tests' 'JobsTests'  'Multilingual-Tests' 'NodeNavigation-Test' 'OpalCompiler-Tests'  'Random-Tests' 'ReleaseTests'
	'Ring-Tests-Kernel'  'Ring-Tests-Containers' 'Tests' 'Zinc-Character-Encoding-Tests'
	'FileSystem-Memory')  do: [ :packageName |
		version := MCVersion package: (MCPackage named: packageName).
		definitions := version snapshot definitions.
		definitions := definitions reject: [:def | blacklistedClasses includes: def className ].
		definitions := definitions reject: [:def | def isMethodDefinition and: [blacklistedMethods includes: def selector] ].
		writer writeDefinitions: definitions.].
].

