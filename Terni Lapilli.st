!classDefinition: #TerniLapilliTest category: #'Terni Lapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 20:22:34'!
test01PlayerXPlacesFirstChip
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self assert: (game isXAt: 1@1) .
	self assert: (game isPlayingO)! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 20:25:33'!
test02PlayerOCantPlayFirst
	| game |
	game _ TerniLapilli newGame.
	
	self should: [ game OplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'No es el turno de ese jugador'.
	self assert: (game isPlayingX)
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 20:25:51'!
test03PlayerXCantPlayTwiceInARow
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self should: [ game XplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'No es el turno de ese jugador'.
	self assert: (game isPlayingO)! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 20:26:02'!
test04PlayerOPlaysAfterPlayerX
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self assert: (game isOAt: 2@1) .
	self assert: (game isPlayingX)! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 20:26:15'!
test05PlayerXCantPlayInOccupiedPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	game OplaceChipAt: 2@1.
	
	self should: [ game XplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'Ya hay una ficha en esa posicion'.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 20:26:23'!
test06PlayerOCantPlayInOccupiedPosition
	| game |
	game _ TerniLapilli newGame.
	game XplaceChipAt: 1@1.
	
	self should: [ game OplaceChipAt: 1@1.] 
	raise: Error 
	withMessageText: 'Ya hay una ficha en esa posicion'.
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 20:42:48'!
test07PlayerXCantHaveMoreThan3Chips
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


!classDefinition: #TerniLapilli category: #'Terni Lapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'board turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilli methodsFor: 'play' stamp: 'gc 10/10/2019 18:51:04'!
OplaceChipAt: aPosition 
	turn = #X ifTrue: [^self error: 'No es el turno de ese jugador'].
	(board at: aPosition) = #Empty ifFalse: [^self error: 'Ya hay una ficha en esa posicion'].
	board at: aPosition put: #O.
	turn _ #X! !

!TerniLapilli methodsFor: 'play' stamp: 'gc 10/10/2019 20:42:37'!
XplaceChipAt: aPosition 
	turn = #O ifTrue: [^self error: 'No es el turno de ese jugador'].
	(board at: aPosition) = #Empty ifFalse: [^self error: 'Ya hay una ficha en esa posicion'].
	(((board values) select: [:aChip | aChip = #X ]) size > 2)  ifTrue: [^self error: 'Los jugadores no pueden tener mas de 3 fichas cada uno'].
	
	board at: aPosition  put: #X.
	turn _ #O.! !


!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 17:50:04'!
at: aPosition
	^board at: aPosition
! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 20:29:03'!
initialize
	board _ Dictionary newFrom: {
			1@1 -> #Empty. 
			1@2 -> #Empty. 
			1@3 -> #Empty. 
			2@1 -> #Empty. 
			2@2 -> #Empty. 
			2@3 -> #Empty. 
			3@1 -> #Empty. 
			3@2 -> #Empty. 
			3@3 -> #Empty.
	}.
	turn _ #X! !


!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/10/2019 18:42:04'!
isOAt: aPosition 
	^(board at: aPosition) = #O! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/10/2019 18:38:45'!
isPlayingO
	^turn = #O! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/10/2019 18:39:05'!
isPlayingX
	^turn = #X! !

!TerniLapilli methodsFor: 'observer' stamp: 'gc 10/10/2019 18:26:17'!
isXAt: aPosition 
	^(board at: aPosition) = #X! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'Terni Lapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'gc 10/10/2019 17:47:49'!
newGame
	 ^self new initialize! !
