'From Pharo 6.0 of 13 May 2016 [Latest update: #60184] on 17 August 2016 at 9:16:23.516041 am'!

!MockSourceEditor methodsFor: 'as yet unclassified' stamp: 'PavelKrivanek 11/8/2012 13:31'!
insertAndSelect: aString at: anInteger

	text := (text first: anInteger-1), 
		(' ' , aString), 
		(text copyFrom: anInteger to: text size).
		
	selectionStart := anInteger.
	selectionEnd := anInteger + aString size ! !
