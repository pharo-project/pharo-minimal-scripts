actions
postload: loader package: packageSpec

	| gofer repo |
	
	Nautilus registerToolsOn: Smalltalk tools.
	Smalltalk tools register: TestRunner as: #testRunner.
	Smalltalk tools register: MCWorkingCopyBrowser as: #monticelloBrowser.
	
	"reload icons because of new tools" 
	
	repo := MCFileTreeRepository new
	directory: './pharo-core/src' asFileReference;
	yourself.
		
	gofer := Gofer it repository: repo.
	gofer package: #'Polymorph-TaskbarIcons'.
	gofer load.	

	BIConfigurableFormatter initialize.
	
	Smalltalk garbageCollect.
	Smalltalk cleanOutUndeclared. 

	Author reset.
