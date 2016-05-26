'versions.txt' asFileReference writeStreamDo: [ :s |
	((MCWorkingCopy allManagers collect: [ :wc | wc ancestry ancestors first name  ]) sorted) do: [ :versionName | 
		s nextPutAll: versionName; lf. ]].