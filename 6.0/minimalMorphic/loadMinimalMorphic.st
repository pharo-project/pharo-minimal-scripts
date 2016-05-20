Gofer new 
	smalltalkhubUser: 'Pharo' project: 'Pharo60';
	package: 'System-VMEvents';
	package: 'Graphics-Canvas';
	package: 'Morphic-Core';
	load.
	
!

'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 10:26:48.597611 am'!

!Morph methodsFor: '*Morphic-Base' stamp: 'BenjaminVanRyseghem 6/21/2013 17:53'!
justDroppedInto: aMorph event: anEvent
	"This message is sent to a dropped morph after it has been dropped on -- and been accepted by -- a drop-sensitive morph"

	| aWindow |
	(self formerOwner notNil and: [self formerOwner ~~ aMorph])
		ifTrue: [self removeHalo].
	self formerOwner: nil.
	self formerPosition: nil.
	(aWindow := aMorph ownerThatIsA: SystemWindow) 
		ifNotNil: [aWindow isActive 
			ifFalse: [aWindow activate]].

	"An object launched by certain parts-launcher mechanisms should end up fully visible..."
	(self hasProperty: #beFullyVisibleAfterDrop) 
		ifTrue: [aMorph == ActiveWorld 
			ifTrue: [self goHome].
			self removeProperty: #beFullyVisibleAfterDrop].

! !

IdentityTransform initialize.

EventSensorConstants initialize.

RealEstateAgent initialize.
WorldState initialize.
Morph initialize.
HandMorph initialize.

Cursor initTarget.

world := WorldMorph new.
world instVarNamed: #worldState put: WorldState new.
hand := HandMorph new.
world addHand: hand.
world activeHand.

Smalltalk at: #World put: world.
Smalltalk at: #ActiveWorld put: world.
Smalltalk at: #ActiveHand put: hand.
Smalltalk at: #ActiveEvent put: nil.

world viewBox: Display boundingBox.

Smalltalk at: #Sensor put: InputEventSensor basicNew.
InputEventSensor installEventSensorFramework.
InputEventSensor installMouseDecodeTable.

(Smalltalk at: #Sensor) flushAllButDandDEvents.
world world handsDo: [:h | h initForEvents].
world borderWidth: 0.

MorphicCoreUIManager new spawnNewProcess.
Display newDepth: 32.
world displayWorldSafely.
UIManager default: MorphicCoreUIManager new.
world displayWorldSafely.
UIManager default uiProcess resume.

World cleanseOtherworldlySteppers.
ExternalDropHandler resetRegisteredHandlers.

Display newDepth: 32.

(world instVarNamed: #worldState) canvas: nil.

(Smalltalk at: #ActiveHand) instVarNamed: #targetOffset put: 0@0.

WorldMorph initialize.
ExternalDropHandler initialize.
PasteUpMorph initialize.
DefaultExternalDropHandler initialize.

     