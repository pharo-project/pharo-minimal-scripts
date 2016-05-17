MCMethodDefinition initializersEnabled: false.

Gofer it smalltalkhubUser: 'Pharo' project: 'Pharo60'; package: 'Compiler';  load.
Gofer it smalltalkhubUser: 'Pharo' project: 'Pharo60'; package: 'RPackage-Tests';  load.
!

ParseNode initialize.
Scanner initialize.
Decompiler initialize.
MessageNode initialize.
VariableNode initialize.

"MCMockRPackage initialize"
!

MCMethodDefinition initializersEnabled: true.

Smalltalk snapshot: true andQuit: true.
