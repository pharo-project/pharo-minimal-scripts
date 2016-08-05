test
	| repo wcs blacklist corrupted |
	repo := MCFileTreeRepository new
		directory: './pharo-core/src' asFileReference;
		yourself.
	wcs := MCWorkingCopy allManagers asOrderedCollection.
	blacklist := #('Metacello-TestsCommonMC' 'Rubric-Editing-Core-Support' '_UnpackagedPackage' 'Renraku-Rules' 'Metacello-TestsPlatform' 'Kernel').
	wcs removeAllSuchThat: [ :wc | blacklist includes: wc packageName ].
	corrupted := wcs
		select: [ :wc | 
			| packageName version snap current patch |
			packageName := wc packageName.
			version := repo loadVersionFromFileNamed: packageName , '.package'.
			snap := version completeSnapshot.
			current := wc completeSnapshot.
			patch := current patchRelativeToBase: snap.
			patch isEmpty not ].
	corrupted
		do: [ :wc | 
			[ [ Gofer it
				repository: repo;
				package: (wc packageName copyUpTo: $.);
				load ]
				on: ProvideAnswerNotification
				do: [ :e | 
					Transcript show: 'ProvideAnswerNotification '; show: e asString; cr.
					e resume: '' ] ]
				on: MCMergeOrLoadWarning
				do: [ :w | 
					Transcript show: 'MCMergeOrLoadWarning '; show: w asString; cr.
					w resume: true ] ]