Trait named: #TViewModel
	uses: {}
	category: 'Rubric-Editing-Core-Support'
	
	!

Morph subclass: #RubScrolledTextExtra
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Rubric-Editing-Widgets'!
RubScrolledTextExtra subclass: #RubScrolledTextSideRuler
	instanceVariableNames: 'side'
	classVariableNames: ''
	package: 'Rubric-Editing-Widgets'
	
   
!   


'From Pharo6.0 of 13 May 2016 [Latest update: #60030] on 24 May 2016 at 5:20:47.184466 pm'!

!MetacelloCachingGoferResolvedReference methodsFor: 'querying' stamp: 'dkh 6/8/2012 14:04:22'!
workingCopy
	"Answer a working copy or throw an error if not present."

	| pName |
	cachedVersion == nil ifTrue: [ ^super workingCopy ].
	pName := cachedVersion package name.
	^MCWorkingCopy allManagers
		detect: [ :each | pName asLowercase = each packageName asLowercase]
		ifNone: [ self error: 'Working copy for ' , self name , ' not found' ]! !

    
| gofer |

[[ 

  ZnConnectionTimeout value: 300 during: [
    gofer:= Gofer it smalltalkhubUser: 'Pharo' project: 'SystemConfigurations'.
    gofer package: #ConfigurationOfUI.
    gofer load.
  ].
   

  ((Smalltalk at: #ConfigurationOfUI) project version: #stable) load.
  
   gofer:= Gofer it smalltalkhubUser: 'Pharo' project: 'Rubric'.
    gofer package: #Rubric.
    gofer load.	  
	
] on:  ProvideAnswerNotification do: [:e | e resume: ''].
] on:  MCMergeOrLoadWarning do: [:w | w resume: true].	
    
 
 !
 
 
'From Pharo6.0 of 13 May 2016 [Latest update: #60027] on 23 May 2016 at 3:32:44.089984 pm'!

!RubScrolledTextMorph methodsFor: 'accessing' stamp: 'AliakseiSyrel 3/17/2015 23:13'!
font: aFont
	"polymorphism with text area"
	self textFont: aFont! !
	
	


    
