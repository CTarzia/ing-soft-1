!classDefinition: #TerniLapilliTest category: #'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 18:59:10'!
test01XPlacesFirstChip
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self assert: (game isXAt: 1@1) .
	self assert: (game isPlayingO)! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/15/2019 20:23:40'!
test02OCantPlayFirst
	| game |
	game _ TerniLapilli newGame.
	
	self should: [ game OplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: TerniLapilli wrongTurn .
	self assert: (game isPlayingX)
	! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/15/2019 20:23:56'!
test03XCantPlayTwiceInARow
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self should: [ game XplaceChipAt: 1@2.] 
	raise: Error 
	withMessageText: TerniLapilli wrongTurn .
	self assert: (game isPlayingO)! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 18:59:45'!
test04OPlaysAfterPlayerX
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self assert: (game isOAt: 2@1) .
	self assert: (game isPlayingX)! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/15/2019 20:24:07'!
test11XCantMoveAgainAfterMoving
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	game XmoveChipAt: 2@2 to: 3@2.
	
	self should: [ game XmoveChipAt: 3@2 to: 3@3.] 
	raise: Error 
	withMessageText: TerniLapilli wrongTurn .
	self assert: (game isPlayingO)
	
	! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/15/2019 20:24:16'!
test18XCantMoveAfterPlacingAChip
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	
	self should: [ game XmoveChipAt: 2@2 to: 3@2.] 
	raise: Error 
	withMessageText: TerniLapilli wrongTurn .
	self assert: game isPlayingO.
	self assert: (game isXAt: 2@2).


	
	! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/15/2019 20:24:25'!
test20OCantMoveAgainAfterMoving
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	game XmoveChipAt: 2@2 to: 3@2.
	game OmoveChipAt: 2@1 to: 2@2.
	
	self should: [ game OmoveChipAt: 2@2 to: 3@3.] 
	raise: Error 
	withMessageText: TerniLapilli wrongTurn .
	self assert: (game isPlayingX)
	
	! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/15/2019 20:24:38'!
test26OCantMoveAfterPlacingAChip
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	self should: [ game OmoveChipAt: 2@3 to: 3@3.] 
	raise: Error 
	withMessageText: TerniLapilli wrongTurn .
	self assert: game isPlayingX.
	self assert: (game isOAt: 2@3).
	
	! !


!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/17/2019 14:20:14'!
test05XCantPlayInOccupiedPositionByX
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self should: [ game XplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: TerniLapilli positionTaken .
	! !

!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/17/2019 14:20:26'!
test06OCantPlayInOccupiedPositionByX
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self should: [ game OplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: TerniLapilli positionTaken 
	! !

!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/15/2019 20:25:18'!
test08XCantPlayInInvalidPosition
	| game |
	game _ TerniLapilli newGame.
	
	self should: [game XplaceChipAt: 5@5.] 
	raise: Error 
	withMessageText: TerniLapilli invalidPosition 

	
	! !

!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/15/2019 20:25:26'!
test09OCantPlayInInvalidPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	self should: [game OplaceChipAt: 5@5.] 
	raise: Error 
	withMessageText: TerniLapilli invalidPosition 

	
	! !

!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/17/2019 14:20:36'!
test36XCantPlayInOccupiedPositionByO
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self should: [ game XplaceChipAt: 2@1.] 
	raise: Error 
	withMessageText: TerniLapilli positionTaken .
	! !

!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/17/2019 14:21:28'!
test37OCantPlayInOccupiedPositionByO
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 3@1.
	
	self should: [ game OplaceChipAt: 2@1.] 
	raise: Error 
	withMessageText: TerniLapilli positionTaken 
	! !


!TerniLapilliTest methodsFor: 'chip limit' stamp: 'gc 10/15/2019 20:25:43'!
test07XCantHaveMoreThan3Chips
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	self should: [ game XplaceChipAt: 3@1.] 
	raise: Error 
	withMessageText: TerniLapilli tooManyChips 
	! !

!TerniLapilliTest methodsFor: 'chip limit' stamp: 'gc 10/15/2019 20:25:55'!
test12OCantHaveMoreThan3Chips
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	game XmoveChipAt: 2@2 to: 3@2.
	
	self should: [ game OplaceChipAt: 3@1.] 
	raise: Error 
	withMessageText: TerniLapilli tooManyChips 
	! !


!TerniLapilliTest methodsFor: 'basic move' stamp: 'gc 10/12/2019 19:00:59'!
test10XMovesOneChipOnce
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	game XmoveChipAt: 2@2 to: 3@2.
	
	self assert: (game isXAt: 3@2).
	self deny: (game isXAt: 2@2).
	self assert: game isPlayingO ! !

!TerniLapilliTest methodsFor: 'basic move' stamp: 'gc 10/12/2019 19:01:29'!
test19OMovesOneChipOnce
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	game XmoveChipAt: 2@2 to: 3@2.
	game OmoveChipAt: 2@1 to: 3@1.
	
	self assert: (game isOAt: 3@1).
	self deny: (game isOAt: 2@1).
	self assert: game isPlayingX.
! !


!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:26:33'!
test13XCantMoveFromPositionThatIsntX
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	self should: [ game XmoveChipAt: 3@2 to: 3@3.] 
	raise: Error 
	withMessageText: TerniLapilli noChipToMove .
	self assert: game isPlayingX.

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:26:55'!
test14XCantMoveIfItDoesntHave3Chips
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	
	self should: [ game XmoveChipAt: 1@3 to: 2@3.] 
	raise: Error 
	withMessageText: TerniLapilli placeBeforeMoving .
	self assert: game isPlayingX

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:27:09'!
test15XCantMoveToOccupiedPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	self should: [ game XmoveChipAt: 2@2 to: 2@3.] 
	raise: Error 
	withMessageText: TerniLapilli endPositionTaken .
	self assert: game isPlayingX.
	self assert: (game isXAt: 2@2)

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:27:20'!
test16XCantMoveToPositionNotAdjacent
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	self should: [ game XmoveChipAt: 1@3 to: 3@1.] 
	raise: Error 
	withMessageText: TerniLapilli movedTooFar .
	self assert: game isPlayingX.
	self assert: (game isXAt: 1@3)


	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:27:31'!
test17XCantMoveToInvalidPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	self should: [ game XmoveChipAt: 1@3 to: 1@4.] 
	raise: Error 
	withMessageText: TerniLapilli invalidPosition .
	self assert: game isPlayingX.
	self assert: (game isXAt: 1@3)


	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:27:44'!
test21OCantMoveFromPositionThatIsntO
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	game XmoveChipAt: 2@2 to: 3@2.
	
	self should: [ game OmoveChipAt: 3@2 to: 3@3.] 
	raise: Error 
	withMessageText: TerniLapilli noChipToMove .
	self assert: game isPlayingO.

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:27:55'!
test22OCantMoveIfItDoesntHave3Chips
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@3.
	
	self should: [ game OmoveChipAt: 1@2 to: 2@2.] 
	raise: Error 
	withMessageText: TerniLapilli placeBeforeMoving .
	self assert: game isPlayingO

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:28:19'!
test23OCantMoveToOccupiedPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	game XmoveChipAt: 2@2 to: 3@3.
	
	self should: [ game OmoveChipAt: 2@1 to: 1@1.] 
	raise: Error 
	withMessageText: TerniLapilli endPositionTaken .
	self assert: game isPlayingO.
	self assert: (game isOAt: 2@1)

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:28:35'!
test24OCantMoveToPositionNotAdjacent
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	game XmoveChipAt: 2@2 to: 3@1.
	
	self should: [ game OmoveChipAt: 1@2 to: 3@3.] 
	raise: Error 
	withMessageText: TerniLapilli movedTooFar .
	self assert: game isPlayingO.
	self assert: (game isOAt: 1@2)


	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/15/2019 20:28:45'!
test25OCantMoveToInvalidPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	game XmoveChipAt: 2@2 to: 3@1.
	
	self should: [ game OmoveChipAt: 2@1 to: 2@0.] 
	raise: Error 
	withMessageText: TerniLapilli invalidPosition .
	self assert: game isPlayingO.
	self assert: (game isOAt: 2@1)


	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/17/2019 15:50:12'!
test38XcantMoveInvalidDiagonal
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 2@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 1@3.
	
	self should: [ game XmoveChipAt: 2@3 to: 3@2.] 
	raise: Error 
	withMessageText: TerniLapilli movedTooFar .
	self assert: game isPlayingX.
	self assert: (game isXAt: 2@3)

	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/17/2019 15:58:51'!
test39OcantMoveInvalidDiagonal
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 3@2.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 3@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 1@3.
	game XmoveChipAt: 2@2 to: 1@1. 
	
	self should: [ game OmoveChipAt: 1@2 to: 2@3.] 
	raise: Error 
	withMessageText: TerniLapilli movedTooFar .
	self assert: game isPlayingO.
	self assert: (game isOAt: 1@2)

	! !


!TerniLapilliTest methodsFor: 'game didn''t end' stamp: 'gc 10/12/2019 19:23:12'!
test27GameIsTiedIfNobodyWon
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	self assert: game isTied.
	
	! !

!TerniLapilliTest methodsFor: 'game didn''t end' stamp: 'gc 10/12/2019 19:50:23'!
test28GameIsntOverIfNobodyWon
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 2@2.
	game OplaceChipAt: 2@3.
	
	self deny: game isOver.
	self deny: game hasPlayerOWon.
	self deny: game hasPlayerXWon .
	
	! !


!TerniLapilliTest methodsFor: 'game won' stamp: 'gc 10/12/2019 20:09:59'!
test29XWinsGameWithoutMoving
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 1@2.
	game OplaceChipAt: 2@2.
	game XplaceChipAt: 1@3.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon .
	self assert: game isOver.
	self deny: game isTied .	
	! !

!TerniLapilliTest methodsFor: 'game won' stamp: 'gc 10/12/2019 20:10:54'!
test30XWinsGameAfterMoving
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 2@1.
	game OplaceChipAt: 2@2.
	game XplaceChipAt: 3@2.
	game OplaceChipAt: 3@3.
	
	game XmoveChipAt: 3@2 to: 3@1.
	
	self assert: game hasPlayerXWon.
	self deny: game hasPlayerOWon .
	self assert: game isOver.
	self deny: game isTied .
	
	! !

!TerniLapilliTest methodsFor: 'game won' stamp: 'gc 10/12/2019 20:10:59'!
test31OWinsGameWithoutMoving
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 1@2.
	game OplaceChipAt: 2@2.
	game XplaceChipAt: 3@3.
	game OplaceChipAt: 2@3.
	
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon .
	self assert: game isOver.
	self deny: game isTied .
	
	! !

!TerniLapilliTest methodsFor: 'game won' stamp: 'gc 10/12/2019 20:11:06'!
test32OWinsGameAfterMoving
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 2@1.
	game OplaceChipAt: 2@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 3@1.
	
	game XmoveChipAt: 1@3 to: 2@3.
	game OmoveChipAt: 3@1 to: 3@2.
	
	self assert: game hasPlayerOWon.
	self deny: game hasPlayerXWon .
	self assert: game isOver.
	self deny: game isTied .
	
	! !


!TerniLapilliTest methodsFor: 'game ended' stamp: 'gc 10/15/2019 20:29:07'!
test33OCantPlaceAChipAfterGameIsOver
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 1@2.
	game OplaceChipAt: 2@2.
	game XplaceChipAt: 1@3.
	
	self should: [ game OplaceChipAt: 3@3.] 
	raise: Error 
	withMessageText: TerniLapilli gameOver .
	self assert: game hasPlayerXWon.
	self deny: game isTied .
	
	
	! !

!TerniLapilliTest methodsFor: 'game ended' stamp: 'gc 10/15/2019 20:29:17'!
test34XCantMoveAChipAfterGameIsOver
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	game XplaceChipAt: 1@2.
	game OplaceChipAt: 2@2.
	game XplaceChipAt: 3@3.
	game OplaceChipAt: 2@3.
	
	self should: [ game XmoveChipAt: 3@3 to: 3@2 .] 
	raise: Error 
	withMessageText: TerniLapilli gameOver .
	self assert: game hasPlayerOWon.
	self deny: game isTied .
	
	
	! !

!TerniLapilliTest methodsFor: 'game ended' stamp: 'gc 10/15/2019 20:29:25'!
test35OCantMoveAChipAfterGameIsOver
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 2@1.
	game OplaceChipAt: 2@2.
	game XplaceChipAt: 3@2.
	game OplaceChipAt: 3@3.
	game XmoveChipAt: 3@2 to: 3@1.
	
	
	self should: [ game OmoveChipAt: 3@3 to: 3@2 .] 
	raise: Error 
	withMessageText: TerniLapilli gameOver .
	self assert: game hasPlayerXWon.
	self deny: game isTied .
	
	
	! !


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'xs os status turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'gc 10/17/2019 16:10:44'!
initialize
	xs _ Bag new.
	os _ Bag new.
	turn _ #X.
	status _ TerniLapilliStatus with: self.! !


!TerniLapilli methodsFor: 'getter' stamp: 'gc 10/17/2019 16:06:23'!
os
	^os! !

!TerniLapilli methodsFor: 'getter' stamp: 'gc 10/17/2019 16:06:28'!
xs
	^xs! !


!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/17/2019 16:13:40'!
hasPlayerOWon
	^self hasWon: os! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/17/2019 16:13:47'!
hasPlayerXWon
	^self hasWon: xs! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/17/2019 16:04:47'!
hasWon: aPlayersChips
	| winningPossibilities |
	
	winningPossibilities _ Bag new.
	
	winningPossibilities add: (Bag with: (1@1) with: (1@2) with: (1@3)).
	winningPossibilities add: (Bag with: (2@1) with: (2@2) with: (2@3)).
	winningPossibilities add: (Bag with: (3@1) with: (3@2) with: (3@3)).
	
	winningPossibilities add: (Bag with: (1@1) with: (2@1) with: (3@1)).
	winningPossibilities add: (Bag with: (1@2) with: (2@2) with: (3@2)).
	winningPossibilities add: (Bag with: (1@3) with: (2@3) with: (3@3)).
	
	winningPossibilities add: (Bag with: (1@1) with: (2@2) with: (3@3)).
	winningPossibilities add: (Bag with: (1@3) with: (2@2) with: (3@1)).
	
	^ winningPossibilities includes: aPlayersChips .! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 20:06:44'!
isEmptyAt: aPosition
	^((xs includes: aPosition) or: (os includes: aPosition) ) not.! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 17:42:19'!
isOAt: aPosition 
	^os includes: aPosition ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/17/2019 16:16:31'!
isOver
	^self hasPlayerOWon or: self hasPlayerXWon ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/17/2019 16:09:18'!
isPlayingO
	^turn = #O ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/17/2019 16:09:27'!
isPlayingX
	^turn = #X ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/17/2019 16:16:57'!
isTied
	^self isOver not! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 17:42:33'!
isXAt: aPosition 
	^xs includes: aPosition ! !


!TerniLapilli methodsFor: 'placeChip' stamp: 'gc 10/17/2019 16:07:42'!
OaddChipAt: aPosition
	os add: aPosition.
	turn _ #X.
	status _ TerniLapilliStatus with: self.! !

!TerniLapilli methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:01:07'!
OplaceChipAt: aPosition 
	self checkValidPlacementOn: aPosition .
	status OplaceChiptAt: aPosition on: self! !

!TerniLapilli methodsFor: 'placeChip' stamp: 'gc 10/17/2019 16:08:04'!
XaddChipAt: aPosition
	xs add: aPosition.
	turn _ #O.
	status _ TerniLapilliStatus with: self.! !

!TerniLapilli methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:00:25'!
XplaceChipAt: aPosition 
	self checkValidPlacementOn: aPosition .
	status XplaceChiptAt: aPosition on: self! !


!TerniLapilli methodsFor: 'moveChip' stamp: 'gc 10/17/2019 16:08:20'!
OmoveChipAt: startingPoint to: endingPoint
	self checkValidMovement: os from: startingPoint to: endingPoint .
	status OmoveChipAt: startingPoint to: endingPoint  on: self.! !

!TerniLapilli methodsFor: 'moveChip' stamp: 'gc 10/17/2019 16:08:41'!
OmovesChipFrom: startingPoint to: endingPoint 
	os remove: startingPoint.
	os add: endingPoint .
	turn _ #X.
	status _ TerniLapilliStatus with: self.! !

!TerniLapilli methodsFor: 'moveChip' stamp: 'gc 10/15/2019 19:59:48'!
XmoveChipAt: startingPoint to: endingPoint
	self checkValidMovement: xs from: startingPoint to: endingPoint .
	status XmoveChipAt: startingPoint to: endingPoint on: self .! !

!TerniLapilli methodsFor: 'moveChip' stamp: 'gc 10/17/2019 16:08:58'!
XmovesChipFrom: startingPoint to: endingPoint 
	xs remove: startingPoint.
	xs add: endingPoint .
	turn _ #O.
	status _ TerniLapilliStatus with: self.! !


!TerniLapilli methodsFor: 'validation' stamp: 'gc 10/15/2019 20:19:36'!
checkAvailabilityOf: aPosition
	(self isEmptyAt: aPosition ) ifFalse: [^self error: self class positionTaken ].! !

!TerniLapilli methodsFor: 'validation' stamp: 'gc 10/17/2019 16:15:50'!
checkValidMovement: aPlayerChips from: startingPoint to: endingPoint
	self checkValidPosition: endingPoint .
	(aPlayerChips includes: startingPoint ) ifFalse: [^self error: self class noChipToMove ].
	(self isEmptyAt: endingPoint) ifFalse: [^self error: self class endPositionTaken ].
	(startingPoint = (2@2)) 
		ifTrue: [((startingPoint eightNeighbors) includes: endingPoint) ifFalse: [^ self error: self class movedTooFar ].] 
		ifFalse: [(((startingPoint fourNeighbors) includes: endingPoint) or: ((2@2) = endingPoint) ) ifFalse: [^ self error: self class movedTooFar ]. ]! !

!TerniLapilli methodsFor: 'validation' stamp: 'gc 10/15/2019 20:00:47'!
checkValidPlacementOn: aPosition
	self checkValidPosition: aPosition .
	self checkAvailabilityOf: aPosition .! !

!TerniLapilli methodsFor: 'validation' stamp: 'gc 10/15/2019 20:20:05'!
checkValidPosition: aPosition
	(((aPosition x) between: 1 and: 3) and: ((aPosition y) between: 1 and: 3) ) ifFalse: [^self error: self class invalidPosition ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'instance creation' stamp: 'gc 10/12/2019 20:15:26'!
newGame
	 ^self new initialize! !


!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:01'!
endPositionTaken
	^'No podes mover a una posicion ocupada'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:09'!
gameOver
	^'El juego ya termino'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:20'!
invalidPosition
	^'No se puede colocar o mover fichas en posiciones invalidas'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:26'!
movedTooFar
	^'Solo podes mover fichas a posiciones adyacentes'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:32'!
noChipToMove
	^ 'En esa posicion no hay una ficha tuya'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:38'!
placeBeforeMoving
	^'Te faltan jugar fichas antes de mover'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:44'!
positionTaken
	^'Ya hay una ficha en esa posicion'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:50'!
tooManyChips
	^ 'Los jugadores no pueden tener mas de 3 fichas cada uno'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/15/2019 20:16:57'!
wrongTurn
	^ 'No es el turno de ese jugador'! !


!classDefinition: #TerniLapilliStatus category: #'Terni Lapilli'!
Object subclass: #TerniLapilliStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliStatus methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:10:09'!
OmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self subclassResponsibility ! !

!TerniLapilliStatus methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:10:12'!
XmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self subclassResponsibility ! !


!TerniLapilliStatus methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:10:34'!
OplaceChiptAt: aPosition on: aTerniLapilli
	^self subclassResponsibility ! !

!TerniLapilliStatus methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:10:36'!
XplaceChiptAt: aPosition on: aTerniLapilli
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliStatus class' category: #'Terni Lapilli'!
TerniLapilliStatus class
	instanceVariableNames: ''!

!TerniLapilliStatus class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 16:11:15'!
canHandle: aTerniLapilli
	^self subclassResponsibility ! !

!TerniLapilliStatus class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 16:00:07'!
with: aTerniLapilli
	^(self subclasses detect: [:aSubclass | aSubclass canHandle: aTerniLapilli ]) new! !


!classDefinition: #OMovingChips category: #'Terni Lapilli'!
TerniLapilliStatus subclass: #OMovingChips
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OMovingChips methodsFor: 'moveChip' stamp: 'gc 10/15/2019 19:30:40'!
OmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli

	^aTerniLapilli OmovesChipFrom: startingPoint to: endingPoint ! !

!OMovingChips methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:17:10'!
XmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli

	^self error: TerniLapilli wrongTurn ! !


!OMovingChips methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:22:01'!
OplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli tooManyChips ! !

!OMovingChips methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:17:21'!
XplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli wrongTurn ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OMovingChips class' category: #'Terni Lapilli'!
OMovingChips class
	instanceVariableNames: ''!

!OMovingChips class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 16:14:27'!
canHandle: aTerniLapilli
	|gameTied|
	gameTied _ ((aTerniLapilli hasPlayerOWon ) or: (aTerniLapilli hasPlayerXWon )) not.
	^(aTerniLapilli os) size = 3 and: ((aTerniLapilli xs) size = 3) and: gameTied and: aTerniLapilli isPlayingO ! !


!classDefinition: #OPlacingChips category: #'Terni Lapilli'!
TerniLapilliStatus subclass: #OPlacingChips
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OPlacingChips methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:22:33'!
OmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self error: TerniLapilli placeBeforeMoving ! !

!OPlacingChips methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:23:19'!
XmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self error: TerniLapilli wrongTurn ! !


!OPlacingChips methodsFor: 'placeChip' stamp: 'gc 10/15/2019 19:31:06'!
OplaceChiptAt: aPosition on: aTerniLapilli
	^aTerniLapilli OaddChipAt: aPosition .! !

!OPlacingChips methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:17:39'!
XplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli wrongTurn ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OPlacingChips class' category: #'Terni Lapilli'!
OPlacingChips class
	instanceVariableNames: ''!

!OPlacingChips class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 16:14:36'!
canHandle: aTerniLapilli
	|gameTied|
	gameTied _ ((aTerniLapilli hasPlayerOWon ) or: (aTerniLapilli hasPlayerXWon )) not.
	^(aTerniLapilli os) size < 3 and: ((aTerniLapilli xs) size <= 3) and: gameTied and: aTerniLapilli isPlayingO! !


!classDefinition: #Owon category: #'Terni Lapilli'!
TerniLapilliStatus subclass: #Owon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Owon methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:18:12'!
OmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self error: TerniLapilli gameOver ! !

!Owon methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:18:10'!
XmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self error: TerniLapilli gameOver ! !


!Owon methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:18:00'!
OplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli gameOver ! !

!Owon methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:17:49'!
XplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli gameOver ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Owon class' category: #'Terni Lapilli'!
Owon class
	instanceVariableNames: ''!

!Owon class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 16:14:44'!
canHandle: aTerniLapilli
	^aTerniLapilli hasPlayerOWon ! !


!classDefinition: #XMovingChips category: #'Terni Lapilli'!
TerniLapilliStatus subclass: #XMovingChips
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!XMovingChips methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:18:20'!
OmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli

	^self error: TerniLapilli wrongTurn ! !

!XMovingChips methodsFor: 'moveChip' stamp: 'gc 10/15/2019 19:03:21'!
XmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli

	^aTerniLapilli XmovesChipFrom: startingPoint to: endingPoint ! !


!XMovingChips methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:18:27'!
OplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli wrongTurn ! !

!XMovingChips methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:22:10'!
XplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli tooManyChips ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XMovingChips class' category: #'Terni Lapilli'!
XMovingChips class
	instanceVariableNames: ''!

!XMovingChips class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 16:14:53'!
canHandle: aTerniLapilli
	|gameTied|
	gameTied _ ((aTerniLapilli hasPlayerOWon ) or: (aTerniLapilli hasPlayerXWon )) not.
	^(aTerniLapilli os) size = 3 and: ((aTerniLapilli xs) size = 3) and: gameTied and: aTerniLapilli isPlayingX ! !


!classDefinition: #XPlacingChips category: #'Terni Lapilli'!
TerniLapilliStatus subclass: #XPlacingChips
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!XPlacingChips methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:18:46'!
OmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self error: TerniLapilli wrongTurn ! !

!XPlacingChips methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:22:40'!
XmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self error: TerniLapilli placeBeforeMoving ! !


!XPlacingChips methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:18:38'!
OplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli wrongTurn ! !

!XPlacingChips methodsFor: 'placeChip' stamp: 'gc 10/15/2019 18:38:28'!
XplaceChiptAt: aPosition on: aTerniLapilli
	^aTerniLapilli XaddChipAt: aPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XPlacingChips class' category: #'Terni Lapilli'!
XPlacingChips class
	instanceVariableNames: ''!

!XPlacingChips class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 16:15:01'!
canHandle: aTerniLapilli
	|gameTied|
	gameTied _ ((aTerniLapilli hasPlayerOWon ) or: (aTerniLapilli hasPlayerXWon )) not.
	^(aTerniLapilli os) size < 3 and: ((aTerniLapilli xs) size < 3) and: gameTied and: aTerniLapilli isPlayingX ! !


!classDefinition: #Xwon category: #'Terni Lapilli'!
TerniLapilliStatus subclass: #Xwon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Xwon methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:18:54'!
OmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self error: TerniLapilli gameOver ! !

!Xwon methodsFor: 'moveChip' stamp: 'gc 10/15/2019 20:19:00'!
XmoveChipAt: startingPoint to: endingPoint on: aTerniLapilli
	^self error: TerniLapilli gameOver ! !


!Xwon methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:19:08'!
OplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli gameOver ! !

!Xwon methodsFor: 'placeChip' stamp: 'gc 10/15/2019 20:19:11'!
XplaceChiptAt: aPosition on: aTerniLapilli
	^self error: TerniLapilli gameOver ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Xwon class' category: #'Terni Lapilli'!
Xwon class
	instanceVariableNames: ''!

!Xwon class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 16:15:10'!
canHandle: aTerniLapilli
	^aTerniLapilli hasPlayerXWon ! !
