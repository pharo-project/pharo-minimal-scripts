| writer version |

FileStream forceNewFileNamed: 'Monticello.st' do: [ :stream |
	writer := MCStWriter on: stream.
	writer writeInitializers: false.

	version := MCVersion package: (MCPackage named: 'Compression').
	writer writeDefinitions: version snapshot definitions.

	version := MCVersion package: (MCPackage named: 'Monticello').
	writer writeDefinitions: version snapshot definitions.

	version := MCVersion package: (MCPackage named: 'Ring-Monticello').
	writer writeDefinitions: version snapshot definitions.
    
	stream nextPutAll: '
	
	ZipConstants initialize.
	ZipFileConstants initialize.
	ZipWriteStream initialize.
	GZipConstants initialize.
	InflateStream initialize.
	FastInflateStream initialize.
	
	MCCacheRepository initialize.
	MCPackageManager initialize.
	MCLazyVersionInfo initialize.
	MCMethodDefinition initialize.
	MCDataStream initialize.
	MCWorkingCopy initialize.'.
].

	
    
  
  