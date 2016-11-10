
'From Pharo6.0 of 13 May 2016 [Latest update: #60288] on 10 November 2016 at 4:44:21.017371 pm'!

!Pragma methodsFor: 'Deprecated60' stamp: 'VincentBlondeau 11/4/2016 14:24'!
keyword
	^ self selector! !

	


'From Pharo 6.0 of 13 May 2016 [Latest update: #60204] on 6 September 2016 at 12:26:30.078251 pm'!

!SubscriptionRegistry methodsFor: 'accessing' stamp: 'TudorGirba 5/18/2011 13:14'!
glmSubscriptions
	^ subscriptions! !

	
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
