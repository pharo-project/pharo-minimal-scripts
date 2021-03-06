	
'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 11 May 2016 at 8:59:11.695352 am'!

!Object class methodsFor: '*System-Object Events' stamp: 'rw 2/10/2002 13:09'!
flushEvents
	"EventManager removed"

	! !
	
			
| packages pharoRepository |
				    
MCCacheRepository reset.

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

!

InternetConfiguration initialize.
NetNameResolver initialize.
Socket initialize.
Base64MimeConverter initialize.

ZnBase64Encoder initialize.
ZnByteEncoder initialize.
ZnUTF8Encoder initialize.
ZnLogEvent initialize.
ZnConstants initialize.
ZnHeaders initialize.
ZnNetworkingUtils initialize.
ZnServer initialize.
ZnSingleThreadedServer initialize.