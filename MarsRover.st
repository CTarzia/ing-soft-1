!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 18:01:51'!
test00NoInstructionStaysInPositionAndDirection
	| rover |
	rover _ MarsRover at: 1@1 lookingAt: #North.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #North.
	
	"Enunciado Mars Rover:
		f --> forward
		b --> backward
		r --> rotate right
		l --> rotate left
	"! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:27:52'!
test01fShouldMoveForward
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'f'.
	self assert: (rover  position) equals: 1@2.
	self assert: (rover  direction) equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:27:57'!
test02bShouldMoveBackward
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'b'.
	self assert: (rover  position) equals: 1@0.
	self assert: (rover  direction) equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:01'!
test03NfsShouldMoveForwardNTimes
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'fff'.
	self assert: (rover  position) equals: 1@4.
	self assert: (rover  direction) equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:05'!
test04NbsShouldMoveBackwardNTimes
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'bbb'.
	self assert: (rover  position) equals: 1@-2.
	self assert: (rover  direction) equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:09'!
test05fbEndsInStartingPoint
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'fb'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:14'!
test06rShouldRotateRight
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'r'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #East.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:19'!
test07rrShouldRotateRightTwice
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'rr'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #South.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:24'!
test08rrrShouldRotateRightThreeTimes
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'rrr'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #West.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:31'!
test09rrrrEndsInStartingDirection
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'rrrr'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:36'!
test10lShouldRotateLeft
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'l'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #West.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:41'!
test11llShouldRotateLeftTwice
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'll'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #South.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:46'!
test12lllShouldRotateLeftThreeTimes
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'lll'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #East.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:50'!
test13llllEndsInStartingDirection
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'llll'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 18:28:40'!
test14InvalidDirectionShouldThrowError
	self should: [ MarsRover at: 1@1 lookingAt: #Invalid.] 
	raise: Error 
	withMessageText: 'El rover debe empezar en una direccion valida'! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:28:58'!
test15fLookingEastShouldMoveRight
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #East.
	rover do: 'f'.
	self assert: (rover  position) equals: 2@1.
	self assert: (rover  direction) equals: #East.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:29:03'!
test16fLookingWestShouldMoveLeft
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #West.
	rover do: 'f'.
	self assert: (rover  position) equals: 0@1.
	self assert: (rover  direction) equals: #West.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:29:09'!
test17fLookingSouthShouldMoveBackwards
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #South.
	rover do: 'f'.
	self assert: (rover  position) equals: 1@0.
	self assert: (rover  direction) equals: #South.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:29:13'!
test18bLookingEastShouldMoveLeft
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #East.
	rover do: 'b'.
	self assert: (rover  position) equals: 0@1.
	self assert: (rover  direction) equals: #East.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:29:17'!
test19bLookingWestShouldMoveRight
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #West.
	rover do: 'b'.
	self assert: (rover  position) equals: 2@1.
	self assert: (rover  direction) equals: #West.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:29:24'!
test20bLookingSouthShouldMoveForward
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #South.
	rover do: 'b'.
	self assert: (rover  position) equals: 1@2.
	self assert: (rover  direction) equals: #South.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:29:37'!
test21InvalidMoveShouldThrowError
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	self should: [ rover do: 'a'] 
	raise: Error 
	withMessageText: 'Movimientos Invalidos'! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:31:47'!
test22ValidMovesWithInvalidMoveShouldThrowErrorAndStayInSamePosition
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	self should: [ rover do: 'ffbarf'] 
	raise: Error 
	withMessageText: 'Movimientos Invalidos'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction) equals: #North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:34:09'!
test23frfShouldMoveDiagonally
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: #North.
	rover do: 'frf'.
	self assert: (rover  position) equals: 2@2.
	self assert: (rover  direction) equals: #East.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'gc 10/6/2019 18:37:52'!
initilializeAt: aPoint lookingAt: aDirection 
	|validDirections|
	validDirections _ Set withAll: #(#North #East #West #South).
	(validDirections includes: aDirection) 
	ifFalse: [^self error: 'El rover debe empezar en una direccion valida'].
	position := aPoint.
	direction := aDirection.! !


!MarsRover methodsFor: 'observer' stamp: 'gc 10/3/2019 21:10:19'!
direction
	^direction! !

!MarsRover methodsFor: 'observer' stamp: 'gc 10/3/2019 21:07:51'!
position
	^position! !


!MarsRover methodsFor: 'action' stamp: 'gc 10/6/2019 19:30:19'!
do: aListOfInstructions 
	(aListOfInstructions detect: [:c| (self isValidMove: c) not ] ifNone: []) ifNotNil: [^self error: 'Movimientos Invalidos']. 
	self move: aListOfInstructions ! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/6/2019 19:29:58'!
move: aListOfInstructions 
	| instructionNumber | 
	instructionNumber _ 1.
	[instructionNumber <= aListOfInstructions size] whileTrue: [
		(aListOfInstructions at: instructionNumber ) = $r ifTrue: [ self rotateRight ].
		(aListOfInstructions at: instructionNumber ) = $l ifTrue: [ self rotateLeft ].
		(aListOfInstructions at: instructionNumber ) = $f ifTrue: [ self moveLeft ].
		(aListOfInstructions at: instructionNumber ) = $b ifTrue: [ self moveRight ].
		instructionNumber _ instructionNumber + 1
	]! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/6/2019 19:05:51'!
moveInDirection: aMoveDirection
	direction = #North ifTrue: [position _ 0@aMoveDirection + position].
	direction = #East ifTrue: [position _ aMoveDirection@0 + position ].
	direction = #West ifTrue: [position _ (-1*aMoveDirection)@0 + position ].
	direction = #South ifTrue: [position _ 0@(-1*aMoveDirection) + position ].! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/6/2019 19:07:51'!
moveLeft
	self moveInDirection: 1! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/6/2019 19:07:57'!
moveRight
	self moveInDirection: -1! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/6/2019 18:19:51'!
rotateLeft
	direction = #North ifTrue: [^direction _ #West].  
	direction = #West ifTrue: [^direction _ #South].
	direction = #South ifTrue: [^direction _ #East].
	direction = #East ifTrue: [^direction _ #North].! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/6/2019 19:08:35'!
rotateRight 
	direction = #North ifTrue: [ ^direction _ #East ].
	direction = #East ifTrue: [ ^direction _ #South ].
	direction = #South ifTrue: [ ^direction _ #West ].
	direction = #West ifTrue: [ ^direction _ #North ]
! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'gc 10/6/2019 19:22:09'!
isValidMove: aMove
	|validMoves|
	validMoves _ Set withAll: #($f $b $r $l).
	^(validMoves includes: aMove )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'gc 10/3/2019 21:06:14'!
at: aPoint lookingAt: aDirection 
	^self new initilializeAt: aPoint  lookingAt: aDirection .! !
