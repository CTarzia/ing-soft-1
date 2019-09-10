!classDefinition: #Rover category: #ToTheMoon!
DenotativeObject subclass: #Rover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ToTheMoon'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Rover class' category: #ToTheMoon!
Rover class
	instanceVariableNames: 'hardness porosity speed time side'!

!Rover class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:09:20'!
configureValues: direction
	
	hardness > 5 & (porosity < 5) ifTrue:[speed := 150. time := 10 * minute . side := 'clockwise' .].
	hardness < 5 & (porosity > 5) ifTrue:[speed := 100. time := 5 * minute . side := 'counter clockwise'. ].
	hardness = 5 & (porosity = 5)  & (direction = 'enter') ifTrue:[speed := 150. time := 5 * minute . side := 'clockwise'. ]. 	
	hardness = 5 & (porosity = 5)  & (direction = 'exit') ifTrue:[speed := 100. time := 10 * minute . side := 'clockwise'. ]. 	
	! !

!Rover class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:15:15'!
dig
	self configureValues: 'enter'.
	self rotate:'enter'.
	self takeSample.
	self configureValues: 'exit'.
	self reverseSide.
	self rotate: 'exit'.
	self resetValues .
	^'Ya excave, tome la muestra y sali.'.
	! !

!Rover class methodsFor: 'as yet unclassified' stamp: 'GZCT 8/31/2019 17:31:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	hardness := 0.
	porosity := 0.
	speed := 0.
	time := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (ProportionalDerivedUnit basicNew instVarAt: 1 put: 'minute'; instVarAt: 2 put: 'minutes'; instVarAt: 3 put: 'NO SIGN'; instVarAt: 4 put: (BaseUnit basicNew instVarAt: 1 put: 'day'; instVarAt: 2 put: 'days'; instVarAt: 3 put: 'NO SIGN'; yourself); instVarAt: 5 put: (1/1440); yourself); yourself).
	side := 'clockwise'.! !

!Rover class methodsFor: 'as yet unclassified' stamp: 's 8/31/2019 16:24:49'!
readHardness: actualHardness Porosity:actualPorosity
	hardness := actualHardness.
	porosity := actualPorosity.! !

!Rover class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:00:13'!
resetValues
	speed := 0. time := 0 * minute . side := 'clockwise' .
	! !

!Rover class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 16:57:50'!
reverseSide
	side = 'clockwise' ifTrue:[side:= 'counter clockwise'] ifFalse: [side:='clockwise'].! !

!Rover class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:12:09'!
rotate: direction
	direction = 'enter' ifTrue: [^'Ya entre'].
	^'Ya sali'.! !

!Rover class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:13:04'!
takeSample
	^'Tome la muestra'.! !

!Rover class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:12:54'!
turnOn
	self resetValues.
	hardness := 0.
	porosity := 0.
	^'Encendido'
	! !

Rover initializeAfterFileIn!