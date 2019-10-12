!classDefinition: #TerniLapilliTest category: #'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:59:10'!
test01XPlacesFirstChip
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self assert: (game isXAt: 1@1) .
	self assert: (game isPlayingO)! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:20:33'!
test02OCantPlayFirst
	| game |
	game _ TerniLapilli newGame.
	
	self should: [ game OplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'No es el turno de ese jugador'.
	self assert: (game isPlayingX)
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:59:37'!
test03XCantPlayTwiceInARow
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self should: [ game XplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'No es el turno de ese jugador'.
	self assert: (game isPlayingO)! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:59:45'!
test04OPlaysAfterPlayerX
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self assert: (game isOAt: 2@1) .
	self assert: (game isPlayingX)! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:59:52'!
test05XCantPlayInOccupiedPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self should: [ game XplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'Ya hay una ficha en esa posicion'.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:00:01'!
test06OCantPlayInOccupiedPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self should: [ game OplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'Ya hay una ficha en esa posicion'.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:00:08'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:50:10'!
test08XCantPlayInInvalidPosition
	| game |
	game _ TerniLapilli newGame.
	
	self should: [game XplaceChipAt: 5@5.] 
	raise: Error 
	withMessageText: 'No se puede colocar o mover fichas en posiciones invalidas'.

	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:50:18'!
test09OCantPlayInInvalidPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	self should: [game OplaceChipAt: 5@5.] 
	raise: Error 
	withMessageText: 'No se puede colocar o mover fichas en posiciones invalidas'.

	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:00:59'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:01:06'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:01:12'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:56:47'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:57:00'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:57:26'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:57:48'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 18:57:59'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:14:46'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:01:29'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:02:57'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:05:48'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:07:32'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:08:59'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:10:28'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:11:39'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:14:31'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:23:12'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 19:50:23'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:09:59'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:10:54'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:10:59'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:11:06'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:11:16'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:11:21'!
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

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:11:26'!
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


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'xs os turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'gc 10/12/2019 17:44:46'!
initialize
	xs _ Bag new.
	os _ Bag new.
	turn _ #X! !


!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 19:45:44'!
hasPlayerOWon
	^self hasWon: os.! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 19:41:19'!
hasPlayerXWon
	^self hasWon: xs! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 19:39:01'!
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
	
	^ winningPossibilities includes: aPlayersChips .
	
	! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 20:06:44'!
isEmptyAt: aPosition
	^((xs includes: aPosition) or: (os includes: aPosition) ) not.! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 17:42:19'!
isOAt: aPosition 
	^os includes: aPosition ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 19:45:57'!
isOver
	^self hasPlayerXWon or: self hasPlayerOWon ! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/10/2019 18:38:45'!
isPlayingO
	^turn = #O! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/10/2019 18:39:05'!
isPlayingX
	^turn = #X! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 20:10:36'!
isTied
	^self isOver not! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/12/2019 17:42:33'!
isXAt: aPosition 
	^xs includes: aPosition ! !


!TerniLapilli methodsFor: 'placeChip' stamp: 'gc 10/12/2019 20:36:09'!
OplaceChipAt: aPosition 
	self checkValidPosition: aPosition.
	turn = #X ifTrue: [^self class wrongTurn].
	(self isOver ) ifTrue: [^self  class gameOver ].
	(self isEmptyAt: aPosition ) ifFalse: [^self class positionTaken ].
	(os size = 3)  ifTrue: [^self class tooManyChips ].
	
	os add: aPosition.
	turn _ #X! !

!TerniLapilli methodsFor: 'placeChip' stamp: 'gc 10/12/2019 20:35:59'!
XplaceChipAt: aPosition 
	self checkValidPosition: aPosition .
	turn = #O ifTrue: [^self class wrongTurn].
	(self isEmptyAt: aPosition ) ifFalse: [^self class positionTaken ].
	(xs size = 3)  ifTrue: [^self class tooManyChips ].
	
	xs add: aPosition.
	turn _ #O.! !


!TerniLapilli methodsFor: 'moveChip' stamp: 'gc 10/12/2019 20:33:51'!
OmoveChipAt: startingPoint to: endingPoint
	self checkValidPosition: endingPoint .
	(turn = #O) ifFalse: [^self class wrongTurn ].
	(self isOver ) ifTrue: [^self class gameOver ].
	(os size < 3) ifTrue: [^self class placeBeforeMoving ].
	(os includes: startingPoint ) ifFalse: [^self class noChipToMove ].
	(self isEmptyAt: endingPoint) ifFalse: [^self class endPositionTaken ].
	((startingPoint eightNeighbors) includes: endingPoint) ifFalse: [^ self movedTooFar ]. 
	os remove: startingPoint.
	os add: endingPoint .
	turn _ #X
	! !

!TerniLapilli methodsFor: 'moveChip' stamp: 'gc 10/12/2019 20:33:37'!
XmoveChipAt: startingPoint to: endingPoint
	self checkValidPosition: endingPoint .
	(turn = #X) ifFalse: [^self class wrongTurn].
	(self isOver ) ifTrue: [^self  class gameOver ].
	(xs size < 3) ifTrue: [^self class placeBeforeMoving ].
	(xs includes: startingPoint ) ifFalse: [^self class noChipToMove ].
	(self isEmptyAt: endingPoint ) ifFalse: [^self class endPositionTaken ].
	((startingPoint eightNeighbors) includes: endingPoint) ifFalse: [^ self class movedTooFar ]. 
	xs remove: startingPoint.
	xs add: endingPoint .
	turn _ #O
	! !


!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gc 10/12/2019 20:38:03'!
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
