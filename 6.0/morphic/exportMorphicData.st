|dict|
dict := Dictionary new.
dict at: #DejaVu put: (TextStyle named: 'Bitmap DejaVu Sans').
dict at: #DecimalProperty put: (Unicode classPool at: #DecimalProperty).
dict at: #GeneralCategory put: (Unicode classPool at: #GeneralCategory).
FLSerializer serialize: dict toFileNamed: 'morphicData.fuel'.

