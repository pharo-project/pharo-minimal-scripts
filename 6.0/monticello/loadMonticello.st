			
| packages pharoRepository |
				    
MCCacheRepository reset.

localRepository := MCDirectoryRepository new
	directory: './mcPackages' asFileReference;
	yourself.	
	
localRepository directory files sorted
	do: [ :each | | mcVersion |
	
   [  
      loader := MCVersionLoader new.	
      mcVersion := each basenameWithoutExtension.
      mcVersion logCr..
	loader addVersion: (localRepository versionFrom: mcVersion).
	loader load.	
    ] on: MCMergeOrLoadWarning do: [:warning | 
      warning messageText logCr.
      warning resume: true].
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

!

#(getGif:, getJpeg:, getPng: getImageOfType:usingParser:fromUrl:) do: [:sel | ZnEasy class removeSelector: sel].

"ZnImageExampleDelegate removeFromSystem.
ZnReadEvalPrintDelegate removeFromSystem.
ZnTestRunnerDelegate removeFromSystem."