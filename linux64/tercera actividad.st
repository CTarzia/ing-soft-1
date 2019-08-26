!classDefinition: #bill category: #'tercera actividad'!
DenotativeObject subclass: #bill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tercera actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'bill class' category: #'tercera actividad'!
bill class
	instanceVariableNames: 'energia'!

!bill class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 17:45:57'!
caminar:unaCantidadDeKilometros

	energia - 3 - unaCantidadDeKilometros >= 0
		ifTrue:  [energia _ energia - 3 - unaCantidadDeKilometros ] ifFalse: [self Error]
! !

!bill class methodsFor: 'as yet unclassified' stamp: 'ct 8/12/2019 21:35:07'!
comer:unaCantidadDeKilosDeCerebro
	"comment stating purpose of message"
	energia _ 4*unaCantidadDeKilosDeCerebro + energia! !

!bill class methodsFor: 'as yet unclassified' stamp: 'ct 8/12/2019 21:28:14'!
energia
	"comment stating purpose of message"
	^energia! !

!bill class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 18:08:30'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := 20.! !

bill initializeAfterFileIn!