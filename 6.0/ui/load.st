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
  
  
'From Pharo6.0 of 13 May 2016 [Latest update: #60098] on 21 July 2016 at 12:01:21.160349 pm'!

!Pragma methodsFor: 'accessing-method' stamp: 'PavelKrivanek 7/21/2016 12:00'!
methodSelector
	"Answer the selector of the method containing the pragma.
	 Do not confuse this with the selector of the pragma's message pattern."
	
	^method selector! !

	
	
   
| gofer |

[[ 

  ZnConnectionTimeout value: 300 during: [
    gofer:= Gofer it smalltalkhubUser: 'Pharo' project: 'SystemConfigurations'.
    gofer package: #ConfigurationOfUI.
    gofer load.
  ].
   

  ((Smalltalk at: #ConfigurationOfUI) project version: #stable) load.
  
 "  gofer:= Gofer it smalltalkhubUser: 'Pharo' project: 'Rubric'.
    gofer package: #Rubric.
    gofer load.	 " 
	
] on:  ProvideAnswerNotification do: [:e | e resume: ''].
] on:  MCMergeOrLoadWarning do: [:w | w resume: true].	
    
 
 !
 
 
'From Pharo6.0 of 13 May 2016 [Latest update: #60027] on 23 May 2016 at 3:32:44.089984 pm'!

!RubScrolledTextMorph methodsFor: 'accessing' stamp: 'AliakseiSyrel 3/17/2015 23:13'!
font: aFont
	"polymorphism with text area"
	self textFont: aFont! !
	
	


    
