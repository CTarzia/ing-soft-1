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

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 20:20:33'!
test02OCantPlayFirst
	| game |
	game _ TerniLapilli newGame.
	
	self should: [ game OplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'No es el turno de ese jugador'.
	self assert: (game isPlayingX)
	! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 18:59:37'!
test03XCantPlayTwiceInARow
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self should: [ game XplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'No es el turno de ese jugador'.
	self assert: (game isPlayingO)! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 18:59:45'!
test04OPlaysAfterPlayerX
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self assert: (game isOAt: 2@1) .
	self assert: (game isPlayingX)! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 19:01:06'!
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
	withMessageText: 'No es el turno de ese jugador'.
	self assert: (game isPlayingO)
	
	! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 19:14:46'!
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
	withMessageText: 'No es el turno de ese jugador'.
	self assert: game isPlayingO.
	self assert: (game isXAt: 2@2).


	
	! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 19:02:57'!
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
	game OmoveChipAt: 1@2 to: 2@2.
	
	self should: [ game OmoveChipAt: 2@2 to: 3@3.] 
	raise: Error 
	withMessageText: 'No es el turno de ese jugador'.
	self assert: (game isPlayingX)
	
	! !

!TerniLapilliTest methodsFor: 'turn' stamp: 'gc 10/12/2019 19:14:31'!
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
	withMessageText: 'No es el turno de ese jugador'.
	self assert: game isPlayingX.
	self assert: (game isOAt: 2@3).
	
	! !


!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/12/2019 18:59:52'!
test05XCantPlayInOccupiedPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self should: [ game XplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'Ya hay una ficha en esa posicion'.
	! !

!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/12/2019 19:00:01'!
test06OCantPlayInOccupiedPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self should: [ game OplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'Ya hay una ficha en esa posicion'.
	! !

!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/12/2019 18:50:10'!
test08XCantPlayInInvalidPosition
	| game |
	game _ TerniLapilli newGame.
	
	self should: [game XplaceChipAt: 5@5.] 
	raise: Error 
	withMessageText: 'No se puede colocar o mover fichas en posiciones invalidas'.

	
	! !

!TerniLapilliTest methodsFor: 'chip placement requirement' stamp: 'gc 10/12/2019 18:50:18'!
test09OCantPlayInInvalidPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	self should: [game OplaceChipAt: 5@5.] 
	raise: Error 
	withMessageText: 'No se puede colocar o mover fichas en posiciones invalidas'.

	
	! !


!TerniLapilliTest methodsFor: 'chip limit' stamp: 'gc 10/12/2019 19:00:08'!
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
	withMessageText: 'Los jugadores no pueden tener mas de 3 fichas cada uno'.
	! !

!TerniLapilliTest methodsFor: 'chip limit' stamp: 'gc 10/12/2019 19:01:12'!
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
	withMessageText: 'Los jugadores no pueden tener mas de 3 fichas cada uno'.
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


!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 18:56:47'!
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
	withMessageText: 'En esa posicion no hay una ficha tuya'.
	self assert: game isPlayingX.

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 18:57:00'!
test14XCantMoveIfItDoesntHave3Chips
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 1@2.
	game XplaceChipAt: 1@3.
	game OplaceChipAt: 2@1.
	
	self should: [ game XmoveChipAt: 1@3 to: 2@3.] 
	raise: Error 
	withMessageText: 'Te faltan jugar fichas antes de mover'.
	self assert: game isPlayingX

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 18:57:26'!
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
	withMessageText: 'No podes mover a una posicion ocupada'.
	self assert: game isPlayingX.
	self assert: (game isXAt: 2@2)

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 18:57:48'!
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
	withMessageText: 'Solo podes mover fichas a posiciones adyacentes'.
	self assert: game isPlayingX.
	self assert: (game isXAt: 1@3)


	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 18:57:59'!
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
	withMessageText: 'No se puede colocar o mover fichas en posiciones invalidas'.
	self assert: game isPlayingX.
	self assert: (game isXAt: 1@3)


	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 19:05:48'!
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
	withMessageText: 'En esa posicion no hay una ficha tuya'.
	self assert: game isPlayingO.

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 19:07:32'!
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
	withMessageText: 'Te faltan jugar fichas antes de mover'.
	self assert: game isPlayingO

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 19:08:59'!
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
	withMessageText: 'No podes mover a una posicion ocupada'.
	self assert: game isPlayingO.
	self assert: (game isOAt: 2@1)

	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 19:10:28'!
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
	withMessageText: 'Solo podes mover fichas a posiciones adyacentes'.
	self assert: game isPlayingO.
	self assert: (game isOAt: 1@2)


	
	! !

!TerniLapilliTest methodsFor: 'move requirement' stamp: 'gc 10/12/2019 19:11:39'!
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
	withMessageText: 'No se puede colocar o mover fichas en posiciones invalidas'.
	self assert: game isPlayingO.
	self assert: (game isOAt: 2@1)


	
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


!TerniLapilliTest methodsFor: 'game ended' stamp: 'gc 10/12/2019 20:11:16'!
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
	withMessageText: 'El juego ya termino'.
	self assert: game hasPlayerXWon.
	self deny: game isTied .
	
	
	! !

!TerniLapilliTest methodsFor: 'game ended' stamp: 'gc 10/12/2019 20:11:21'!
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
	withMessageText: 'El juego ya termino'.
	self assert: game hasPlayerOWon.
	self deny: game isTied .
	
	
	! !

!TerniLapilliTest methodsFor: 'game ended' stamp: 'gc 10/12/2019 20:11:26'!
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
	withMessageText: 'El juego ya termino'.
	self assert: game hasPlayerXWon.
	self deny: game isTied .
	
	
	! !


!classDefinition: #GameStatus category: #'Terni Lapilli'!
Object subclass: #GameStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!GameStatus methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:56:04'!
OisWinner
	^self subclassResponsibility ! !

!GameStatus methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:56:09'!
XisWinner
	^self subclassResponsibility ! !

!GameStatus methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:56:32'!
gameEnded
	^self subclassResponsibility ! !

!GameStatus methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:56:49'!
gameShouldntBeOver
	^self subclassResponsibility ! !

!GameStatus methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:56:36'!
isTied
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameStatus class' category: #'Terni Lapilli'!
GameStatus class
	instanceVariableNames: ''!

!GameStatus class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:59:19'!
canHandle: Ochips and: Xchips
	^self subclassResponsibility ! !

!GameStatus class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:36:30'!
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

!GameStatus class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:34:20'!
with: Ochips and: Xchips
	^(self subclasses detect: [:aSubclass | aSubclass canHandle: Ochips and: Xchips]) new! !


!classDefinition: #Owon category: #'Terni Lapilli'!
GameStatus subclass: #Owon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Owon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:42:15'!
OisWinner
	^true! !

!Owon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:42:29'!
XisWinner
	^false! !

!Owon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:42:39'!
gameEnded
	^true! !

!Owon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:47:53'!
gameShouldntBeOver
	^TerniLapilli gameOver ! !

!Owon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:46:18'!
isTied
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Owon class' category: #'Terni Lapilli'!
Owon class
	instanceVariableNames: ''!

!Owon class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:37:12'!
canHandle: Ochips and: Xchips
	^GameStatus hasWon: Ochips! !


!classDefinition: #Tie category: #'Terni Lapilli'!
GameStatus subclass: #Tie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Tie methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:42:56'!
OisWinner
	^false! !

!Tie methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:43:07'!
XisWinner
	^false! !

!Tie methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:43:11'!
gameEnded
	^false! !

!Tie methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:48:48'!
gameShouldntBeOver! !

!Tie methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:46:33'!
isTied
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tie class' category: #'Terni Lapilli'!
Tie class
	instanceVariableNames: ''!

!Tie class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:38:18'!
canHandle: Ochips and: Xchips
	^((GameStatus hasWon: Ochips) or: (GameStatus hasWon: Ochips)) not.! !


!classDefinition: #Xwon category: #'Terni Lapilli'!
GameStatus subclass: #Xwon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Xwon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:43:32'!
OisWinner
	^false! !

!Xwon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:44:07'!
XisWinner
	^true! !

!Xwon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:43:55'!
gameEnded
	^true! !

!Xwon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:48:38'!
gameShouldntBeOver
	^TerniLapilli gameOver ! !

!Xwon methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:46:25'!
isTied
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Xwon class' category: #'Terni Lapilli'!
Xwon class
	instanceVariableNames: ''!

!Xwon class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 16:59:35'!
canHandle: Ochips and: Xchips
	^GameStatus hasWon: Xchips! !


!classDefinition: #Player category: #'Terni Lapilli'!
Object subclass: #Player
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!Player methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:39:49'!
checkTurn: aPlayer
	^self subclassResponsibility ! !

!Player methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:40:03'!
shouldBeO
	^self subclassResponsibility ! !

!Player methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:40:04'!
shouldBeX
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: #'Terni Lapilli'!
Player class
	instanceVariableNames: ''!

!Player class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:07:04'!
canHandle: aPlayer
	^self subclassResponsibility ! !

!Player class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:21:51'!
with: aPlayer
	^(self subclasses detect: [:aSubclass | aSubclass canHandle: aPlayer ]) new.! !


!classDefinition: #O category: #'Terni Lapilli'!
Player subclass: #O
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!O methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:21:03'!
checkTurn: aPlayer
	| tryingToPlay |
	tryingToPlay _ Player with: aPlayer.
	tryingToPlay shouldBeO.! !

!O methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:19:46'!
shouldBeO! !

!O methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:20:36'!
shouldBeX
	^TerniLapilli wrongTurn ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'O class' category: #'Terni Lapilli'!
O class
	instanceVariableNames: ''!

!O class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:06:21'!
canHandle: aPlayer
	^aPlayer = #O! !


!classDefinition: #X category: #'Terni Lapilli'!
Player subclass: #X
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!X methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:22:35'!
checkTurn: aPlayer
	| tryingToPlay |
	tryingToPlay _ Player with: aPlayer.
	tryingToPlay shouldBeX.! !

!X methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:23:15'!
shouldBeO
	^TerniLapilli wrongTurn ! !

!X methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:23:11'!
shouldBeX! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'X class' category: #'Terni Lapilli'!
X class
	instanceVariableNames: ''!

!X class methodsFor: 'as yet unclassified' stamp: 'gc 10/14/2019 15:06:35'!
canHandle: aPlayer
	^aPlayer = #X! !


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'xs os turn status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'gc 10/14/2019 16:39:23'!
initialize
	xs _ Bag new.
	os _ Bag new.
	turn _ #X.
	status _ GameStatus with: os and: xs.! !


!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/14/2019 16:41:47'!
hasPlayerOWon
	^status OisWinner! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/14/2019 16:44:49'!
hasPlayerXWon
	^status XisWinner ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 20:06:44'!
isEmptyAt: aPosition
	^((xs includes: aPosition) or: (os includes: aPosition) ) not.! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 17:42:19'!
isOAt: aPosition 
	^os includes: aPosition ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/14/2019 16:45:34'!
isOver
	^status gameEnded ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/10/2019 18:38:45'!
isPlayingO
	^turn = #O! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/10/2019 18:39:05'!
isPlayingX
	^turn = #X! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/14/2019 16:46:05'!
isTied
	^status isTied! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 17:42:33'!
isXAt: aPosition 
	^xs includes: aPosition ! !


!TerniLapilli methodsFor: 'placeChip' stamp: 'gc 10/14/2019 16:53:11'!
OplaceChipAt: aPosition 
	self checkValidPosition: aPosition.
	"turn = #X ifTrue: [^self class wrongTurn]."
	(Player with: turn) checkTurn: #O.
	"(self isOver ) ifTrue: [^self  class gameOver ]."
	status gameShouldntBeOver.
	(self isEmptyAt: aPosition ) ifFalse: [^self class positionTaken ].
	(os size = 3)  ifTrue: [^self class tooManyChips ].
	
	os add: aPosition.
	turn _ #X.
	status _ GameStatus with: os and: xs.! !

!TerniLapilli methodsFor: 'placeChip' stamp: 'gc 10/14/2019 16:53:18'!
XplaceChipAt: aPosition 
	self checkValidPosition: aPosition .
	"turn = #O ifTrue: [^self class wrongTurn]."
	(Player with: turn) checkTurn: #X.
	(self isEmptyAt: aPosition ) ifFalse: [^self class positionTaken ].
	(xs size = 3)  ifTrue: [^self class tooManyChips ].
	
	xs add: aPosition.
	turn _ #O.
	status _ GameStatus with: os and: xs.! !


!TerniLapilli methodsFor: 'moveChip' stamp: 'gc 10/14/2019 16:52:51'!
OmoveChipAt: startingPoint to: endingPoint
	self checkValidPosition: endingPoint .
	"(turn = #O) ifFalse: [^self class wrongTurn ]."
	(Player with: turn) checkTurn: #O.
	"(self isOver ) ifTrue: [^self  class gameOver ]."
	status gameShouldntBeOver.
	(os size < 3) ifTrue: [^self class placeBeforeMoving ].
	(os includes: startingPoint ) ifFalse: [^self class noChipToMove ].
	(self isEmptyAt: endingPoint) ifFalse: [^self class endPositionTaken ].
	((startingPoint eightNeighbors) includes: endingPoint) ifFalse: [^ self class movedTooFar ]. 
	os remove: startingPoint.
	os add: endingPoint .
	turn _ #X.
	status _ GameStatus with: os and: xs.! !

!TerniLapilli methodsFor: 'moveChip' stamp: 'gc 10/14/2019 16:53:32'!
XmoveChipAt: startingPoint to: endingPoint
	self checkValidPosition: endingPoint .
	"(turn = #X) ifFalse: [^self class wrongTurn]."
	(Player with: turn) checkTurn: #X.
	"(self isOver ) ifTrue: [^self  class gameOver ]."
	status gameShouldntBeOver.
	(xs size < 3) ifTrue: [^self class placeBeforeMoving ].
	(xs includes: startingPoint ) ifFalse: [^self class noChipToMove ].
	(self isEmptyAt: endingPoint ) ifFalse: [^self class endPositionTaken ].
	((startingPoint eightNeighbors) includes: endingPoint) ifFalse: [^ self class movedTooFar ]. 
	xs remove: startingPoint.
	xs add: endingPoint .
	turn _ #O.
	status _ GameStatus with: os and: xs.
	! !


!TerniLapilli methodsFor: 'validation' stamp: 'gc 10/12/2019 20:38:03'!
checkValidPosition: aPosition
	(((aPosition x) between: 1 and: 3) and: ((aPosition y) between: 1 and: 3) ) ifFalse: [^self class invalidPosition ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'instance creation' stamp: 'gc 10/12/2019 20:15:26'!
newGame
	 ^self new initialize! !


!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:31:41'!
endPositionTaken
	^self error: 'No podes mover a una posicion ocupada'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:26:24'!
gameOver
	^self error: 'El juego ya termino'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:37:45'!
invalidPosition
	^self error: 'No se puede colocar o mover fichas en posiciones invalidas'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:33:19'!
movedTooFar
	^self error: 'Solo podes mover fichas a posiciones adyacentes'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:30:09'!
noChipToMove
	^self error: 'En esa posicion no hay una ficha tuya'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:28:41'!
placeBeforeMoving
	^self error: 'Te faltan jugar fichas antes de mover'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:34:30'!
positionTaken
	^self error: 'Ya hay una ficha en esa posicion'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:35:40'!
tooManyChips
	^self error: 'Los jugadores no pueden tener mas de 3 fichas cada uno'! !

!TerniLapilli class methodsFor: 'error' stamp: 'gc 10/12/2019 20:25:21'!
wrongTurn
	^self error: 'No es el turno de ese jugador'! !
