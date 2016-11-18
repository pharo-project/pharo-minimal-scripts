| versions |

localRepository := MCDirectoryRepository new
	directory: './metacelloPackages' asFileReference;
	yourself.	
	
MCMethodDefinition initializersEnabled: false.	
	
localRepository directory files sorted
	do: [ :each | | mcVersion |
	
   [  
      loader := MCVersionLoader new.	
      mcVersion := each basenameWithoutExtension.
      mcVersion logCr.
	loader addVersion: (localRepository versionFrom: mcVersion).
	loader load.	
    ] on: MCMergeOrLoadWarning do: [:warning | 
      warning messageText logCr.
      warning resume: true].
].	
	    
MCMethodDefinition initializersEnabled: true.	

RxMatcher initialize.
RxParser initialize.
RxsPredicate initialize.

MCFileTreeStCypressWriter initialize.
MCFileTreeFileSystemUtils initialize.
MCMockASubclass initialize.
MCMockClassA initialize.

MetacelloPlatform initialize.
MetacelloPharoPlatform initialize.
MetacelloPharo30Platform initialize.

STONWriter initialize.

SystemAnnouncer restoreAllNotifications.
