	
'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 11 May 2016 at 8:59:11.695352 am'!

!Object class methodsFor: '*System-Object Events' stamp: 'rw 2/10/2002 13:09'!
flushEvents
	"EventManager removed"

	! !
	
			
| packages pharoRepository |
				    

localRepository := MCDirectoryRepository new
	directory: './mcPackages' asFileReference;
	yourself.	
	
localRepository directory files sorted
	do: [ :each | | mcVersion |
	
      loader := MCVersionLoader new.	
      mcVersion := each basenameWithoutExtension.
      mcVersion logCr..
	loader addVersion: (localRepository versionFrom: mcVersion).
	loader load.		
].	
"  
pharoRepository := MCHttpRepository
    location: 'http://smalltalkhub.com/mc/Pharo/Pharo50/main'
    user: ''
    password: ''.
      
versions do: [:versionName |
  | loader |
  versionName logCr.
  loader := MCVersionLoader new.	
  loader addVersion: (pharoRepository versionFrom: versionName).
  loader load.].
  
"