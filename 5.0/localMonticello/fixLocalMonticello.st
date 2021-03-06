'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 1:36:00.128099 pm'!

!RPackageOrganizer methodsFor: 'private registration' stamp: 'EstebanLorenzano 2/21/2014 12:56'!
basicRegisterPackage: aPackage
	"A new package is now available and declared in the receiver. Note that it is a low level implementation method since it does not deal with package contained information and does not update the related mapping tables."
	
	packages 
		at: aPackage name asSymbol 
		put: aPackage.
	"register mc package"
	MCWorkingCopy forPackage: (MCPackage named: aPackage name).
	
	^ aPackage! !

!

'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 3:35:27.377099 pm'!

!RPackageOrganizer class methodsFor: 'singleton' stamp: 'StephaneDucasse 6/3/2012 22:39'!
resetDefault

	"self resetDefault"
	default  ifNotNil: [
		"When an Organizer is not used anymore, we should always pay attention that these two actions are corretly done."
		default unregisterInterestToSystemAnnouncement.
		MCWorkingCopy removeDependent: default].
	default := self new.
	self packageClass initialize! !


'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 3:35:38.129822 pm'!

!RPackageOrganizer methodsFor: 'private' stamp: 'CamilleTeruel 7/29/2012 18:47'!
stopNotification
	"(self instVarNamed: #default) stopNotification"
	
	"pay attention that we can break the system using this method"
	
	SystemAnnouncer uniqueInstance unsubscribe: self.
	MCWorkingCopy removeDependent: self.! !
	

'From Pharo5.0 of 16 April 2015 [Latest update: #50752] on 10 May 2016 at 3:36:09.623307 pm'!

!RPackageOrganizer methodsFor: 'system integration' stamp: 'BernardoContreras 10/24/2014 17:36'!
registerInterestToAnnouncer: anAnnouncer	
	"There should be only one"
	anAnnouncer unsubscribe: self.
	
	anAnnouncer weak
		when: CategoryAdded send: #systemCategoryAddedActionFrom: to: self;
		when: CategoryRemoved send: #systemCategoryRemovedActionFrom: to: self;
		when: CategoryRenamed send: #systemCategoryRenamedActionFrom: to: self;
		when:  ClassAdded send: #systemClassAddedActionFrom: to: self;
		when:  ClassRecategorized send: #systemClassRecategorizedActionFrom: to: self;
		when:  ClassRemoved send: #systemClassRemovedActionFrom: to: self;
		when:  ClassRenamed send: #systemClassRenamedActionFrom: to: self;
		when:  ClassReorganized send: #systemClassReorganizedActionFrom: to: self;
		when:  MethodAdded send: #systemMethodAddedActionFrom: to: self;
		when:  MethodModified send: #systemMethodModifiedActionFrom: to: self;
		when:  MethodRecategorized send: #systemMethodRecategorizedActionFrom: to: self;
		when:  MethodRemoved send: #systemMethodRemovedActionFrom: to: self;
		when:  ProtocolAdded send: #systemProtocolAddedActionFrom: to: self;
		when:  ProtocolRemoved send: #systemProtocolRemovedActionFrom: to: self.
		
	self flag: #hack. "for decoupling MC"
	#MCWorkingCopy asClassIfPresent: [ 
		anAnnouncer weak
			when: (Smalltalk globals at: #MCWorkingCopyCreated) 
				send: #updateAfterNewMCPackageRegistred: 
				to: self;
			when: (Smalltalk globals at: #MCWorkingCopyDeleted) 
				send: #updateAfterNewMCPackageUnregistred: 
				to: self	].! !

			
SystemAnnouncer restoreAllNotifications.

RPackageOrganizer default packageNames do: [:packageName |
  (MCWorkingCopy forPackage: (MCPackage named: packageName)).
  (MCVersion package: (MCPackage named: packageName))].
