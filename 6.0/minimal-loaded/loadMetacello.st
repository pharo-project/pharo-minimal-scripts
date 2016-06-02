| versions |

versions := 'versions.txt' asFileReference contents lines.


pharoRepository := MCHttpRepository
    location: 'http://smalltalkhub.com/mc/Pharo/Pharo60/main'
    user: ''
    password: ''.
	
MCMethodDefinition initializersEnabled: false.

versions do: [:version | 
   loader := MCVersionLoader new.	
   loader addVersion: (pharoRepository versionFrom: version).
   loader load.		
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
