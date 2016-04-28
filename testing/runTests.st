| results | 

results := TestCase suite run.
Stdio stdout nextPutAll: (results) asString; lf.

Stdio stdout nextPutAll: 'FAILURES:'; lf.
results failures do: [:failure |
  Stdio stdout nextPutAll: ' - '; nextPutAll: (failure) asString; lf. 
  [failure debug] on: Exception do: [:exception | Stdio stdout nextPutAll: String tab; nextPutAll: (exception printStringLimitedTo: 180) withSeparatorsCompacted; lf.].
  ].

Stdio stdout nextPutAll: 'ERRORS:'; lf.
results errors do: [:error |
  Stdio stdout nextPutAll: ' - '; nextPutAll: (error) asString; lf. 
  [error debug] on: Exception do: [:exception | Stdio stdout nextPutAll: String tab; nextPutAll: (exception printStringLimitedTo: 180) asString withSeparatorsCompacted; lf.
  ((thisContext stack allButFirst: 6) first: 10)do: [:context | 
    Stdio stdout nextPutAll: String tab; nextPutAll: String tab; nextPutAll: (context printStringLimitedTo: 180) asString withSeparatorsCompacted; lf
    ]].
  Stdio stdout lf.
].
  
