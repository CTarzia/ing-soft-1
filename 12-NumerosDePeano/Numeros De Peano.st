!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 20:53:14'!
* unNumeroDePeano
	^unNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 18:59:57'!
+ unNumeroDePeano
 	^unNumeroDePeano  next! !

!I class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:59:46'!
- unNumeroDePeano
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:31:49'!
/ unNumeroDePeano
	unNumeroDePeano = I ifTrue: [^I] ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].! !

!I class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:28:13'!
> unNumeroDePeano
	^false! !

!I class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 16:00:59'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:58:57'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se puede tener numeros negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 18:31:06'!
next
	^II
	! !

!I class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:47:04'!
restaReversa: unNumeroDePeano
	^unNumeroDePeano previous.
! !


!classDefinition: #II category: #'Numeros De Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 15:51:55'!
* unNumeroDePeano
	^ unNumeroDePeano + (self previous * unNumeroDePeano)! !

!II class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 19:00:34'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:49:52'!
- unNumeroDePeano
	^unNumeroDePeano restaReversa: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:32'!
/ unNumeroDePeano
	unNumeroDePeano = self ifTrue: [^I].
	unNumeroDePeano > self ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	^ I + (self - unNumeroDePeano / unNumeroDePeano ).! !

!II class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:29:29'!
> unNumeroDePeano
	unNumeroDePeano = I ifTrue: [^true].
	^self previous > unNumeroDePeano previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:55:42'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'gc 9/1/2019 19:36:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 19:16:35'!
next
	next ifNil:[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 19:01:37'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 19:05:38'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'g 8/26/2019 18:40:06'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'f 8/31/2019 17:49:43'!
restaReversa: unNumeroDePeano
	^ self previous restaReversa: unNumeroDePeano previous! !


!classDefinition: #III category: #'Numeros De Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros De Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
* unNumeroDePeano
	^ unNumeroDePeano + (self previous * unNumeroDePeano)! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
- unNumeroDePeano
	^unNumeroDePeano restaReversa: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
/ unNumeroDePeano
	unNumeroDePeano = self ifTrue: [^I].
	unNumeroDePeano > self ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	^ I + (self - unNumeroDePeano / unNumeroDePeano ).! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
> unNumeroDePeano
	unNumeroDePeano = I ifTrue: [^true].
	^self previous > unNumeroDePeano previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'gc 9/1/2019 19:36:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
next
	next ifNil:[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:40'!
restaReversa: unNumeroDePeano
	^ self previous restaReversa: unNumeroDePeano previous! !


!classDefinition: #IIII category: #'Numeros De Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros De Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
* unNumeroDePeano
	^ unNumeroDePeano + (self previous * unNumeroDePeano)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
+ unNumeroDePeano
	^self previous + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
- unNumeroDePeano
	^unNumeroDePeano restaReversa: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
/ unNumeroDePeano
	unNumeroDePeano = self ifTrue: [^I].
	unNumeroDePeano > self ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	^ I + (self - unNumeroDePeano / unNumeroDePeano ).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
> unNumeroDePeano
	unNumeroDePeano = I ifTrue: [^true].
	^self previous > unNumeroDePeano previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'gc 9/1/2019 19:36:59'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
next
	next ifNil:[
		next _ self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
previous: unNumeroDePeano
	previous _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'g 9/1/2019 19:32:41'!
restaReversa: unNumeroDePeano
	^ self previous restaReversa: unNumeroDePeano previous! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!