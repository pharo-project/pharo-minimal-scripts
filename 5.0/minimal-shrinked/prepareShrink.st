'From Pharo5.0 of 16 April 2015 [Latest update: #50561] on 2 February 2016 at 8:14:28.007281 am'!

!FT2Handle class methodsFor: 'initialize-release' stamp: 'PavelKrivanek 2/2/2016 08:14'!
release

	SessionManager default unregisterClassNamed: self name! !

SystemAnnouncer uniqueInstance unsubscribe: TestCase. 
RBProgramNode resetFormatter.
Smalltalk snapshot: true andQuit: true.
