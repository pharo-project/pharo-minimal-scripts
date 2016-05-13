| writer version |

FileStream forceNewFileNamed: 'SUnit.st' do: [ :stream |
	writer := MCStWriter on: stream.
	writer writeInitializers: false.

	version := MCVersion package: (MCPackage named: #'SUnit-Core').
	writer writeDefinitions: version snapshot definitions.

	version := MCVersion package: (MCPackage named: #'SUnit-Tests').
	writer writeDefinitions: version snapshot definitions.


	stream nextPutAll: '
LongTestCase initialize.
TestCase initialize.
Stdio stdout nextPutAll: ''DONE'';lf; flush.'.
.].

