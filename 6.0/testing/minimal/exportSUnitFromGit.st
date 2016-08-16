FileStream forceNewFileNamed: 'SUnit.st' do: [ :stream |
	| repo writer version |
	repo := MCFileTreeRepository new
		directory: './pharo-core/src' asFileReference;
		yourself.	
		
	writer := MCStWriter on: stream.
	writer writeInitializers: false.

	version := (repo loadVersionFromFileNamed: 'SUnit-Core.package').
	writer writeDefinitions: version snapshot definitions.

	version := (repo loadVersionFromFileNamed: 'SUnit-Tests.package').
	writer writeDefinitions: version snapshot definitions.

	stream nextPutAll: '
	  LongTestCase initialize.
	  TestCase initialize.
	'. ].