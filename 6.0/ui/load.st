Trait named: #TViewModel
	uses: {}
	category: 'Rubric-Editing-Core-Support'
	
	!



'From Pharo5.0 of 16 April 2015 [Latest update: #50756] on 13 May 2016 at 2:13:30.9058 pm'!


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
    
 
    Smalltalk tools register: Workspace as: #browser.
 
BalloonEngineConstants initialize.
BalloonEngine initialize.

GradientFillStyle initialize.


 !
 
 
'From Pharo6.0 of 13 May 2016 [Latest update: #60027] on 23 May 2016 at 3:32:44.089984 pm'!

!RubScrolledTextMorph methodsFor: 'accessing' stamp: 'AliakseiSyrel 3/17/2015 23:13'!
font: aFont
	"polymorphism with text area"
	self textFont: aFont! !
