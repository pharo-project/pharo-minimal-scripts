| writer version |

FileStream forceNewFileNamed: 'Monticello.st' do: [ :stream |
	writer := MCStWriter on: stream.
	writer writeInitializers: false.

	version := MCVersion package: (MCPackage named: #Monticello).
	writer writeDefinitions: version snapshot definitions.

	version := MCVersion package: (MCPackage named: 'Ring-Monticello').
	writer writeDefinitions: version snapshot definitions.

	stream nextPutAll: '

MCCacheRepository initialize.
MCPackageManager initialize.
MCLazyVersionInfo initialize.
MCMethodDefinition initialize.
MCDataStream initialize.
MCWorkingCopy initialize.

Smalltalk snapshot:true andQuit: true'.
].

