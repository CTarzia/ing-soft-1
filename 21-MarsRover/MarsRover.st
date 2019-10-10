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


!MarsRoverTest methodsFor: 'Error' stamp: 'gc 10/10/2019 16:26:53'!
test14InvalidDirectionShouldThrowError
	self should: [ MarsRover at: 1@1 lookingAt: Direction .] 
	raise: Error 
	withMessageText: 'El rover debe empezar en una direccion valida'! !

!MarsRoverTest methodsFor: 'Error' stamp: 'gc 10/9/2019 18:17:12'!
test21InvalidMoveShouldThrowError
	|rover|
	rover _ MarsRover at: 1@1 lookingAt: North.
	self should: [ rover do: 'a'] 
	raise: Error 
	withMessageText: 'Movimientos Invalidos'! !

!MarsRoverTest methodsFor: 'Error' stamp: 'gc 10/9/2019 23:35:20'!
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

!Direction methodsFor: 'rotate' stamp: 'gc 10/10/2019 16:29:38'!
left
	^self subclassResponsibility 
! !

!Direction methodsFor: 'rotate' stamp: 'gc 10/10/2019 16:31:17'!
right
	^self subclassResponsibility 
! !


!Direction methodsFor: 'move' stamp: 'gc 10/10/2019 16:07:12'!
moveBackwardFrom: aPosition
	^self subclassResponsibility ! !

!Direction methodsFor: 'move' stamp: 'gc 10/10/2019 16:06:57'!
moveForwardFrom: aPosition
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Direction class' category: #MarsRover!
Direction class
	instanceVariableNames: ''!

!Direction class methodsFor: 'validation' stamp: 'gc 10/10/2019 16:33:12'!
isValidDirection: aDirection
	^Direction allSubclasses detect: [:aSubclass| aSubclass = aDirection] ifNone: [self error: 'El rover debe empezar en una direccion valida'].! !


!classDefinition: #East category: #MarsRover!
Direction subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'rotate' stamp: 'gc 10/9/2019 23:18:24'!
left
 	^North new! !

!East methodsFor: 'rotate' stamp: 'gc 10/9/2019 23:18:32'!
right
 	^South new! !


!East methodsFor: 'move' stamp: 'gc 10/10/2019 16:12:40'!
moveBackwardFrom: aPosition
	^ -1@0 + aPosition! !

!East methodsFor: 'move' stamp: 'gc 10/10/2019 16:12:47'!
moveForwardFrom: aPosition
	^ 1@0 + aPosition! !


!classDefinition: #North category: #MarsRover!
Direction subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'rotate' stamp: 'gc 10/9/2019 23:18:41'!
left
 	^West new! !

!North methodsFor: 'rotate' stamp: 'gc 10/9/2019 23:18:46'!
right
 	^East new! !


!North methodsFor: 'move' stamp: 'gc 10/10/2019 16:12:57'!
moveBackwardFrom: aPosition
	^ 0@-1 + aPosition! !

!North methodsFor: 'move' stamp: 'gc 10/10/2019 16:13:06'!
moveForwardFrom: aPosition
	^0@1 + aPosition! !


!classDefinition: #South category: #MarsRover!
Direction subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'rotate' stamp: 'gc 10/9/2019 23:18:52'!
left
 	^East new! !

!South methodsFor: 'rotate' stamp: 'gc 10/9/2019 23:18:56'!
right
 	^West new! !


!South methodsFor: 'move' stamp: 'gc 10/10/2019 16:13:15'!
moveBackwardFrom: aPosition
	^0@1 + aPosition! !

!South methodsFor: 'move' stamp: 'gc 10/10/2019 16:13:27'!
moveForwardFrom: aPosition
	^ 0@-1 + aPosition! !


!classDefinition: #West category: #MarsRover!
Direction subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'rotate' stamp: 'gc 10/9/2019 23:19:03'!
left
 	^South new! !

!West methodsFor: 'rotate' stamp: 'gc 10/9/2019 23:19:09'!
right
 	^North new! !


!West methodsFor: 'move' stamp: 'gc 10/10/2019 16:13:34'!
moveBackwardFrom: aPosition
	^ 1@0  + aPosition! !

!West methodsFor: 'move' stamp: 'gc 10/10/2019 16:13:40'!
moveForwardFrom: aPosition
	^-1@0  + aPosition! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'gc 10/10/2019 16:34:14'!
initilializeAt: aPosition lookingAt: aDirection 
	Direction isValidDirection: aDirection.
	position _ aPosition.
	direction _ aDirection new.! !


!MarsRover methodsFor: 'observer' stamp: 'gc 10/3/2019 21:10:19'!
direction
	^direction! !

!MarsRover methodsFor: 'observer' stamp: 'gc 10/3/2019 21:07:51'!
position
	^position! !


!MarsRover methodsFor: 'action' stamp: 'gc 10/10/2019 16:31:48'!
do: aListOfInstructions 
	(aListOfInstructions detect: [:instruction | (self isValidMove: instruction) not] ifNone: []) ifNotNil: [^self error: 'Movimientos Invalidos'].
	self move: aListOfInstructions ! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/10/2019 16:34:31'!
move: aListOfInstructions 
	| instructionNumber| 
	instructionNumber _ 1.
	[instructionNumber <= aListOfInstructions size] whileTrue: [
		(aListOfInstructions at: instructionNumber ) = $r ifTrue: [ self rotateRight ].
		(aListOfInstructions at: instructionNumber ) = $l ifTrue: [ self rotateLeft ].
		(aListOfInstructions at: instructionNumber ) = $f ifTrue: [ self moveForward ].
		(aListOfInstructions at: instructionNumber ) = $b ifTrue: [ self moveBackward ].
		
		instructionNumber _ instructionNumber + 1
	]! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/10/2019 16:11:12'!
moveBackward
	position _ direction moveBackwardFrom: position ! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/10/2019 16:11:18'!
moveForward
	position _ direction moveForwardFrom: position 
! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/10/2019 16:34:45'!
rotateLeft
	^direction _ direction left.! !

!MarsRover methodsFor: 'action' stamp: 'gc 10/10/2019 16:34:51'!
rotateRight 
	^direction _ direction right.! !


!MarsRover methodsFor: 'validation' stamp: 'gc 10/10/2019 16:24:30'!
isValidMove: aMove
	|validMoves|
	validMoves  _ Set withAll: #($f $r  $l  $b).
	^validMoves includes: aMove ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'gc 10/3/2019 21:06:14'!
at: aPoint lookingAt: aDirection 
	^self new initilializeAt: aPoint  lookingAt: aDirection .! !
