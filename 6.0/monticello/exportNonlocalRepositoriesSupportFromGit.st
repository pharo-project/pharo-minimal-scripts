
|  mcPackages pharoRepository targetRepository |

mcPackages := #(
 'Network-Kernel'
 'Network-MIME'
 'Network-Url'
 'Network-Protocols'
 'MonticelloRemoteRepositories'
 
 'Monticello'
 'Ring-Monticello'
 'Zinc-Character-Encoding-Core'
 'Zinc-HTTP'
 'Zinc-FileSystem'
 'Zodiac-Core'
 ).

pharoRepository := MCFileTreeRepository new
	directory: './pharo-core/src' asFileReference;
	yourself.	
    
targetRepository := MCDirectoryRepository new
	directory: './mcPackages' asFileReference;
	yourself.	
	
mcPackages do: [ :packageName |
  packageName logCr.
  targetRepository storeVersion: (pharoRepository loadVersionFromFileNamed: packageName, '.package')].	
	
	
    
  
  