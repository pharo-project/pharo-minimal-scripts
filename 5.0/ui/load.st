Trait named: #TViewModel
	uses: {}
	category: 'Rubric-Editing-Core-Support'
	
	!

!MorphicUIManager methodsFor: 'ui requests' stamp: 'ChristopheDemarey 8/14/2015 15:09'!
warningDefaultAction: anException

  UIManager default logError: anException.
  anException resume.
	
	! !


'From Pharo5.0 of 16 April 2015 [Latest update: #50756] on 13 May 2016 at 2:13:30.9058 pm'!

!MorphicUIManager methodsFor: 'ui requests' stamp: 'ChristopheDemarey 8/14/2015 15:09'!
unhandledErrorDefaultAction: anException

	UIManager default logError: anException.

	(anException isResumable) 
	  ifFalse: [ Smalltalk exitFailure.] 
	  ifTrue: [ anException resume. ]
	! !

|gofer |
	

[[ 

   gofer:= Gofer it smalltalkhubUser: 'Pharo' project: 'Rubric'.
    gofer package: #Rubric.
    gofer load.	


  ZnConnectionTimeout value: 300 during: [
    gofer:= Gofer it smalltalkhubUser: 'Pharo' project: 'SystemConfigurations'.
    gofer package: #ConfigurationOfUI.
    gofer load.
  ].
  
  

  ((Smalltalk at: #ConfigurationOfUI) project version: #stable) load.
	


	
] on:  ProvideAnswerNotification do: [:e | e resume: ''].
] on:  MCMergeOrLoadWarning do: [:w | w resume: true].	
	
	
 


    Smalltalk tools register: Workspace as: #browser.
 