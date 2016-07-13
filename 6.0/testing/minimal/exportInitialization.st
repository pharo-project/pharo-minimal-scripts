Gofer it
        smalltalkhubUser: 'Pharo' project: 'Bootstrap';
        package: 'ClassInitializationSorter';
        package: 'PharoBootstrap-Initialization';
        load.
Metacello new
        smalltalkhubUser: 'demarey' project: 'CargoPackageManager';
        configuration: 'Cargo';
        version: #bleedingEdge;
        load: 'client'.

packages := PharoKernelAssembly asOngoingPackageVersion packageUnits.
classes := (packages flatCollect: [ :each | (RPackageOrganizer default packageNamed: each) classes ])
        select: [ :class | class class selectors includes: #initialize ].

ordered := ClassInitializationSorter sort: classes asSet.
'initialization.st' asFileReference writeStreamDo: [ :file | 
	file nextPutAll: ordered asString.
	file nextPutAll: ' do: [:cn | Transcript show: ''initializing class: '', cn. (Smalltalk at: cn) initialize]. !!'.
	file cr.].
