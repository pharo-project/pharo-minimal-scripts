'From Pharo6.0 of 13 May 2016 [Latest update: #60069] on 13 July 2016 at 9:43:54.170076 am'!

!HDTestReport methodsFor: 'running' stamp: 'AndreiChis 10/7/2013 11:59'!
serializeError: error of: aTestCase


! !



(RPackage organizer packages collect: #name) logCr.

"HDTestReport runPackages: (RPackage organizer packages collect: #name)."

HDTestReport runClasses: Smalltalk allClasses named: 'Tests'.

Smalltalk exitSuccess. 