| mcPackages zincPackagesInPharoRepository zincPackages zodiacPackages pharoRepository zincRepository zodiacRepository targetRepository |

mcPackages := #(
 'Network-Kernel'
 'Network-MIME'
 'Network-Url'
 'Network-Protocols'
 'MonticelloRemoteRepositories' ).

zincPackagesInPharoRepository := #(
  'Zinc-Character-Encoding-Core').

zincPackages := #(
  'Zinc-HTTP' 'Zinc-FileSystem').
  
zodiacPackages := #(
  'Zodiac-Core' ).

pharoRepository := MCHttpRepository
    location: 'http://smalltalkhub.com/mc/Pharo/Pharo50/main'
    user: ''
    password: ''.
    
zincRepository := MCHttpRepository
	location: 'http://mc.stfx.eu/ZincHTTPComponents'
	user: ''
	password: ''.
	
zodiacRepository := MCHttpRepository
	location: 'http://mc.stfx.eu/Zodiac'
	user: ''
	password: ''.

targetRepository := MCDirectoryRepository new
	directory: './mcPackages' asFileReference;
	yourself.	
	
mcPackages do: [ :packageName |
  targetRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].
	
zincPackagesInPharoRepository do: [ :packageName |
  targetRepository storeVersion: (pharoRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

zincPackages do: [ :packageName |
  targetRepository storeVersion: (zincRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

zodiacPackages do: [ :packageName |
  targetRepository storeVersion: (zodiacRepository versionWithInfo: (MCPackage named: packageName) workingCopy ancestry ancestors first)].

	
	
    
  
  