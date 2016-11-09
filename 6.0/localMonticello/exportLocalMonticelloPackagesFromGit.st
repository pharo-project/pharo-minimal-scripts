| mcPackages pharoRepository targetMCRepository |

mcPackages := #(
 'Compression'
 'Monticello'
 'Ring-Monticello'
 ).

pharoRepository := MCFileTreeRepository new
	directory: './pharo-core/src' asFileReference;
	yourself.	

targetMCRepository := MCDirectoryRepository new
	directory: './mcPackages' asFileReference;
	yourself.	  
  
mcPackages do: [ :packageName |
  packageName logCr.
  targetMCRepository storeVersion: (pharoRepository loadVersionFromFileNamed: packageName, '.package')].


	
	
    
  
  