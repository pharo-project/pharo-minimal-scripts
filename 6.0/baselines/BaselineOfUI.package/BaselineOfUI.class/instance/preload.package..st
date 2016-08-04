baseline
preload: loader package: packageSpec

	
	'Starting preload action' logCr.
	
	Author fullName: self class name.

	Trait named: #TViewModel
	uses: {}
	category: 'Rubric-Editing-Core-Support'.
"	
Morph subclass: #RubScrolledTextExtra
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'Rubric-Editing-Widgets'.
	
RubScrolledTextExtra subclass: #RubScrolledTextSideRuler
	instanceVariableNames: 'side'
	classVariableNames: ''
	package: 'Rubric-Editing-Widgets'.
"
	Pragma compile: 'methodSelector
	^method selector'.


	
