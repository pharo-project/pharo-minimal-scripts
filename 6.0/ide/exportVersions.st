'versions.txt' asFileReference writeStreamDo: [ :s |
	((MCWorkingCopy allManagers collect: [ :wc | wc ancestry ancestors first name  ]) sorted) do: [ :versionName | 
	    (versionName = 'FFI-Kernel-JanVanDeSandt.40') ifFalse: [
		s nextPutAll: versionName; lf. ]]].