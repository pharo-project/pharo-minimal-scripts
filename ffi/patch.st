'From Pharo5.0 of 16 April 2015 [Latest update: #50635] on 10 March 2016 at 4:42:36.874296 pm'!

!SmalltalkImage methodsFor: '*Deprecated50' stamp: 'ChristopheDemarey 2/26/2016 15:41'!
addToStartUpList: aClass after: predecessor

	self addToStartup: aClass! !

'From Pharo5.0 of 16 April 2015 [Latest update: #50635] on 10 March 2016 at 4:44:36.705666 pm'!

!SmalltalkImage methodsFor: '*Deprecated50' stamp: 'ChristopheDemarey 3/10/2016 11:28'!
addToStartup: aClass
	self deprecated: 
		'Please use registration methods provided in SessionManager / registration category.', 
		String cr,
		'ex: SessionManager default registerSystemClassNamed: self name'.
		
	SessionManager default 
		registerUserClassNamed: aClass name! !
	
	
	
Smalltalk snapshot: true andQuit: true.