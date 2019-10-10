!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'Idle' stamp: 'gc 10/9/2019 23:31:01'!
test00NoInstructionStaysInPositionAndDirection
	| rover |
	rover _ MarsRover at: 1@1 lookingAt: North.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: North.
	
	"Enunciado Mars Rover:
		f --> forward
		b --> backward
		r --> rotate right
		l --> rotate left
	"! !


!MarsRoverTest methodsFor: 'Basic Backward' stamp: 'gc 10/9/2019 23:31:13'!
test02bShouldMoveBackward
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'b'.
	self assert: (rover  position) equals: 1@0.
	self assert: (rover  direction class) equals: North.! !

!MarsRoverTest methodsFor: 'Basic Backward' stamp: 'gc 10/9/2019 23:31:22'!
test04NbsShouldMoveBackwardNTimes
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'bbb'.
	self assert: (rover  position) equals: 1@-2.
	self assert: (rover  direction class) equals: North.! !


!MarsRoverTest methodsFor: 'Basic Forward' stamp: 'gc 10/9/2019 23:31:33'!
test01fShouldMoveForward
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'f'.
	self assert: (rover  position) equals: 1@2.
	self assert: (rover  direction class) equals: North.! !

!MarsRoverTest methodsFor: 'Basic Forward' stamp: 'gc 10/9/2019 23:31:39'!
test03NfsShouldMoveForwardNTimes
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'fff'.
	self assert: (rover  position) equals: 1@4.
	self assert: (rover  direction class) equals: North.! !


!MarsRoverTest methodsFor: 'Basic Right' stamp: 'gc 10/9/2019 23:31:51'!
test06rShouldRotateRight
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'r'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: East.! !

!MarsRoverTest methodsFor: 'Basic Right' stamp: 'gc 10/9/2019 23:32:07'!
test07rrShouldRotateRightTwice
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'rr'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: South.! !

!MarsRoverTest methodsFor: 'Basic Right' stamp: 'gc 10/9/2019 23:32:15'!
test08rrrShouldRotateRightThreeTimes
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'rrr'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: West.! !

!MarsRoverTest methodsFor: 'Basic Right' stamp: 'gc 10/9/2019 23:32:23'!
test09rrrrEndsInStartingDirection
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'rrrr'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: North.! !


!MarsRoverTest methodsFor: 'Basic Left' stamp: 'gc 10/9/2019 23:32:32'!
test10lShouldRotateLeft
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'l'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: West.! !

!MarsRoverTest methodsFor: 'Basic Left' stamp: 'gc 10/9/2019 23:32:39'!
test11llShouldRotateLeftTwice
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'll'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: South.! !

!MarsRoverTest methodsFor: 'Basic Left' stamp: 'gc 10/9/2019 23:32:50'!
test12lllShouldRotateLeftThreeTimes
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'lll'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: East.! !

!MarsRoverTest methodsFor: 'Basic Left' stamp: 'gc 10/9/2019 23:32:58'!
test13llllEndsInStartingDirection
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'llll'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: North.! !


!MarsRoverTest methodsFor: 'Forward with directions' stamp: 'gc 10/9/2019 23:33:14'!
test15fLookingEastShouldMoveEast
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: East.
	rover do: 'f'.
	self assert: (rover  position) equals: 2@1.
	self assert: (rover  direction class) equals: East.! !

!MarsRoverTest methodsFor: 'Forward with directions' stamp: 'gc 10/9/2019 23:33:22'!
test16fLookingWestShouldMoveWest
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: West.
	rover do: 'f'.
	self assert: (rover  position) equals: 0@1.
	self assert: (rover  direction class) equals: West.! !

!MarsRoverTest methodsFor: 'Forward with directions' stamp: 'gc 10/9/2019 23:33:30'!
test17fLookingSouthShouldMoveSouth
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: South.
	rover do: 'f'.
	self assert: (rover  position) equals: 1@0.
	self assert: (rover  direction class) equals: South.! !


!MarsRoverTest methodsFor: 'Backward with directions' stamp: 'gc 10/9/2019 23:33:45'!
test18bLookingEastShouldMoveWest
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: East.
	rover do: 'b'.
	self assert: (rover  position) equals: 0@1.
	self assert: (rover  direction class) equals: East.! !

!MarsRoverTest methodsFor: 'Backward with directions' stamp: 'gc 10/9/2019 23:33:50'!
test19bLookingWestShouldMoveEast
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: West.
	rover do: 'b'.
	self assert: (rover  position) equals: 2@1.
	self assert: (rover  direction class) equals: West.! !

!MarsRoverTest methodsFor: 'Backward with directions' stamp: 'gc 10/9/2019 23:33:57'!
test20bLookingSouthShouldMoveNorth
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: South.
	rover do: 'b'.
	self assert: (rover  position) equals: 1@2.
	self assert: (rover  direction class) equals: South.! !


!MarsRoverTest methodsFor: 'Errors' stamp: 'gc 10/9/2019 18:17:01'!
test14InvalidDirectionShouldThrowError
	self should: [ MarsRover at: 1@1 lookingAt: Move.] 
	raise: Error 
	withMessageText: 'El rover debe empezar en una direccion valida'! !

!MarsRoverTest methodsFor: 'Errors' stamp: 'gc 10/9/2019 18:17:12'!
test21InvalidMoveShouldThrowError
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	self should: [ rover do: 'a'] 
	raise: Error 
	withMessageText: 'Movimientos Invalidos'! !

!MarsRoverTest methodsFor: 'Errors' stamp: 'gc 10/9/2019 23:35:20'!
test22ValidMovesWithInvalidMoveShouldThrowErrorAndStayInSamePosition
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	self should: [ rover do: 'ffbarf'] 
	raise: Error 
	withMessageText: 'Movimientos Invalidos'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: North.! !


!MarsRoverTest methodsFor: 'Various Movements' stamp: 'gc 10/9/2019 23:34:12'!
test05fbEndsInStartingPoint
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'fb'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover direction class) equals: North.! !

!MarsRoverTest methodsFor: 'Various Movements' stamp: 'gc 10/9/2019 23:34:18'!
test23frfShouldMoveDiagonally
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'frf'.
	self assert: (rover  position) equals: 2@2.
	self assert: (rover  direction class) equals: East.! !

!MarsRoverTest methodsFor: 'Various Movements' stamp: 'gc 10/9/2019 23:38:04'!
test24Roundabout
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	rover do: 'frfrfrf'.
	self assert: (rover  position) equals: 1@1.
	self assert: (rover  direction class) equals: West.! !


!classDefinition: #Direction category: #MarsRover!
Object subclass: #Direction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Direction methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 19:41:12'!
left
	self subclassResponsibility 
! !

!Direction methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 22:58:47'!
moveInDirection: aMoveDirection From: aPosition
	self subclassResponsibility 
! !

!Direction methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 20:20:29'!
right
	self subclassResponsibility 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Direction class' category: #MarsRover!
Direction class
	instanceVariableNames: ''!

!Direction class methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 22:29:53'!
IsValidDirection: aDirection
	^Direction allSubclasses detect: [:aSubclass| aSubclass = aDirection] ifNone: [self error: 'El rover debe empezar en una direccion valida'].! !


!classDefinition: #East category: #MarsRover!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:18:24'!
left
 	^North new! !

!East methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:00:01'!
moveInDirection: aMoveDirection From: aPosition
	^ aMoveDirection@0 + aPosition 
! !

!East methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:18:32'!
right
 	^South new! !


!classDefinition: #North category: #MarsRover!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:18:41'!
left
 	^West new! !

!North methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:00:43'!
moveInDirection: aMoveDirection From: aPosition
	^ 0@aMoveDirection + aPosition
! !

!North methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:18:46'!
right
 	^East new! !


!classDefinition: #South category: #MarsRover!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:18:52'!
left
 	^East new! !

!South methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:02:32'!
moveInDirection: aMoveDirection From: aPosition
	^0@(-1*aMoveDirection) + aPosition
! !

!South methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:18:56'!
right
 	^West new! !


!classDefinition: #West category: #MarsRover!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:19:03'!
left
 	^South new! !

!West methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:02:14'!
moveInDirection: aMoveDirection From: aPosition
	^(-1*aMoveDirection)@0 + aPosition
! !

!West methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:19:09'!
right
 	^North new! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'gc 10/9/2019 23:04:36'!
initilializeAt: aPosition lookingAt: aDirection 
	Direction IsValidDirection: aDirection.
	position _ aPosition.
	direction _ aDirection new.! !


!MarsRover methodsFor: 'observer' stamp: 'gc 10/3/2019 21:10:19'!
direction
	^direction! !

!MarsRover methodsFor: 'observer' stamp: 'gc 10/3/2019 21:07:51'!
position
	^position! !


!MarsRover methodsFor: 'action' stamp: 'gc 10/9/2019 22:33:30'!
do: aListOfInstructions 
	aListOfInstructions do: [ :anInstruction | Move FindMove: anInstruction ].
	self move: aListOfInstructions ! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/9/2019 23:24:26'!
move: aListOfInstructions 
	| instructionNumber currentMove| 
	instructionNumber _ 1.
	[instructionNumber <= aListOfInstructions size] whileTrue: [
		currentMove _ (Move FindMove: (aListOfInstructions at: instructionNumber)) new.
		direction _ currentMove executeDirectionWith: self direction.
		position _ currentMove executePositionWith: self direction From: self position .
		"
		(aListOfInstructions at: instructionNumber ) = $r ifTrue: [ self rotateRight ].
		(aListOfInstructions at: instructionNumber ) = $l ifTrue: [ self rotateLeft ].
		(aListOfInstructions at: instructionNumber ) = $f ifTrue: [ self moveLeft ].
		(aListOfInstructions at: instructionNumber ) = $b ifTrue: [ self moveRight ].
		"
		instructionNumber _ instructionNumber + 1
	]! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/9/2019 20:23:52'!
moveBackward
	self moveInDirection: -1! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/9/2019 20:23:29'!
moveForward
	self moveInDirection: 1
! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/9/2019 19:34:00'!
moveInDirection: aMoveDirection
	direction = North ifTrue: [position _ 0@aMoveDirection + position].
	direction = East ifTrue: [position _ aMoveDirection@0 + position ].
	direction = West ifTrue: [position _ (-1*aMoveDirection)@0 + position ].
	direction = South ifTrue: [position _ 0@(-1*aMoveDirection) + position ].! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/9/2019 19:42:18'!
rotateLeft
	^direction _ (direction left) new.
	"direction = #North ifTrue: [^direction _ #West].  
	direction = #West ifTrue: [^direction _ #South].
	direction = #South ifTrue: [^direction _ #East].
	direction = #East ifTrue: [^direction _ #North]."! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/9/2019 20:19:05'!
rotateRight 
	^direction _ (direction right) new.
	"
	direction = North ifTrue: [ ^direction _ East ].
	direction = East ifTrue: [ ^direction _ South ].
	direction = South ifTrue: [ ^direction _ West ].
	direction = West ifTrue: [ ^direction _ North ]
"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'gc 10/3/2019 21:06:14'!
at: aPoint lookingAt: aDirection 
	^self new initilializeAt: aPoint  lookingAt: aDirection .! !


!classDefinition: #Move category: #MarsRover!
Object subclass: #Move
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Move methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 22:44:10'!
executeDirectionWith: aDirection
	self subclassResponsibility ! !

!Move methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:23:42'!
executePositionWith: aDirection From: aPosition 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Move class' category: #MarsRover!
Move class
	instanceVariableNames: ''!

!Move class methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:11:07'!
FindMove: aMove
	^Move allSubclasses detect: [:aSubclass| aSubclass isEqualTo: aMove ] ifNone: [self error: 'Movimientos Invalidos'].! !


!classDefinition: #B category: #MarsRover!
Move subclass: #B
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!B methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 22:46:37'!
executeDirectionWith: aDirection
	^aDirection ! !

!B methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:26:42'!
executePositionWith: aDirection From: aPosition 
	^aDirection moveInDirection: -1 From: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'B class' category: #MarsRover!
B class
	instanceVariableNames: ''!

!B class methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 17:40:00'!
isEqualTo: aMove
	^aMove = $b! !


!classDefinition: #F category: #MarsRover!
Move subclass: #F
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!F methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 22:47:24'!
executeDirectionWith: aDirection
	^aDirection ! !

!F methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:24:50'!
executePositionWith: aDirection From: aPosition 
	^aDirection moveInDirection: 1 From: aPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'F class' category: #MarsRover!
F class
	instanceVariableNames: ''!

!F class methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 17:40:42'!
isEqualTo: aMove
	^aMove = $f! !


!classDefinition: #L category: #MarsRover!
Move subclass: #L
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!L methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 22:49:16'!
executeDirectionWith: aDirection
	^ aDirection left! !

!L methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:25:19'!
executePositionWith: aDirection From: aPosition 
	^aPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'L class' category: #MarsRover!
L class
	instanceVariableNames: ''!

!L class methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 17:40:54'!
isEqualTo: aMove
	^aMove = $l! !


!classDefinition: #R category: #MarsRover!
Move subclass: #R
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!R methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 22:49:33'!
executeDirectionWith: aDirection
	^ aDirection right! !

!R methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 23:25:41'!
executePositionWith: aDirection From: aPosition 
	^aPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'R class' category: #MarsRover!
R class
	instanceVariableNames: ''!

!R class methodsFor: 'as yet unclassified' stamp: 'gc 10/9/2019 17:41:02'!
isEqualTo: aMove
	^aMove = $r! !
