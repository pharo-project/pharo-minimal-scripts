actions
installBitmap

	| array |
	
	array := Smalltalk specialObjectsArray copy.
	array at: 5 put: Bitmap.
	Smalltalk specialObjectsArray becomeForward: array.