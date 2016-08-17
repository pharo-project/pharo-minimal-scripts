| writer version blacklist definitions blacklistedClasses blacklistedMethods  repo |

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
	
	testDeepStructure
	
	testFindTokens
	testFindTokensIncludes
	testNext
	testPeek
	testPeekFor
	testReset
	testUpToEnd
	testImportAMethodWithLangTag
	testUTF16Back
	testUTF8Back
	testFindTokensEscapedBy

	testShuffled
	testAtRandom

	testBlockEscape

	testCannotReturn
	testCannotReturn
	testIsTerminatingNormalTermination
	testWaitAndWaitTimeoutTogether	
).

repo := MCFileTreeRepository new
		directory: './pharo-core/src' asFileReference;
		yourself.	

FileStream forceNewFileNamed: 'Tests.st' do: [ :stream |
	"stream binary.
	UTF8TextConverter writeBOMOn: stream."
	stream text.
	writer := MCStWriter on: stream.
	writer writeInitializers: false.
	#('RPackage-Tests' 'Collections-Tests' 'Kernel-Tests' 'AST-Tests-Core' 'Announcements-Tests-Core'  'FileSystem-Tests-Core' 
	'FileSystem-Tests-Disk' 'Files-Tests' 'JobsTests'  'Multilingual-Tests' 'OpalCompiler-Tests'  'Random-Tests' 'ReleaseTests'
	'Ring-Tests-Kernel'  'Ring-Tests-Containers' 'Zinc-Character-Encoding-Tests' 'Tests' 
	
	'FileSystem-Memory')  do: [ :packageName |
		version := (repo loadVersionFromFileNamed: packageName, '.package').
		definitions := version snapshot definitions.
		definitions := definitions reject: [:def | blacklistedClasses includes: def className ].
		definitions := definitions reject: [:def | def isMethodDefinition and: [blacklistedMethods includes: def selector] ].
		writer writeDefinitions: definitions.].
].

