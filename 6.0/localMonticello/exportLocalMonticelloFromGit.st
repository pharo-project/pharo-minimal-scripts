FileStream forceNewFileNamed: 'Monticello.st' do: [ :stream |
	| repo writer version |
	repo := MCFileTreeRepository new
		directory: './pharo-core/src' asFileReference;
		yourself.	
		
	writer := MCStWriter on: stream.
	writer writeInitializers: false.

	version := (repo loadVersionFromFileNamed: 'Compression.package').
	writer writeDefinitions: version snapshot definitions.

	version := (repo loadVersionFromFileNamed: 'Monticello.package').
	version := MCVersion package: (MCPackage named: 'Monticello').
	writer writeDefinitions: version snapshot definitions.

	version := (repo loadVersionFromFileNamed: 'Ring-Monticello.package').
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