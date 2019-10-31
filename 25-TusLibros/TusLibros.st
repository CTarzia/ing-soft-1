!classDefinition: #CartTest category: #TusLibros stamp: 'gc 10/31/2019 16:30:47'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 22:19:11'!
test01createCartShouldBeEmpty
	|aCart|
	
	aCart _ Cart create.
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 22:31:44'!
test02addItemtoCartShouldHaveItemWithRightQuantity
	|aCart|
	
	aCart _ Cart create.
	aCart add: 4 of: 'item01'.
	
	self deny: aCart isEmpty.
	self assert: ((aCart amountOf: 'item01') isEqualTo: 4).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 22:42:04'!
test03addSameItemTwicetoCartShouldSumQuantities
	|aCart|
	
	aCart _ Cart create.
	aCart add: 4 of: 'item01'.
	aCart add: 5 of: 'item01'.
	
	self deny: aCart isEmpty.
	self assert: ((aCart amountOf: 'item01') isEqualTo: 9).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 23:01:49'!
test04CantAddItemToCartWithAmount0
	|aCart|
	
	aCart _ Cart create.
	
	self should: [ aCart add: 0 of: 'item01'.] 
	raise: Error 
	withMessageText: Cart invalidQuantity.
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 23:01:46'!
test05CantAddItemToCartWithAmountNegativeAmount
	|aCart|
	
	aCart _ Cart create.
	
	self should: [ aCart add: -1 of: 'item01'.] 
	raise: Error 
	withMessageText: Cart invalidQuantity.
	self assert: aCart isEmpty.! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 23:05:05'!
test06CanListEmptyCartAndReturnsEmptyList
	|aCart|
	
	aCart _ Cart create.
	
	self assert: ((aCart items) isEmpty)! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 23:20:33'!
test07CanListCardWithItemsAndReturnsItemsWithAmount
	|aCart expectedItems|
	
	aCart _ Cart create.
	aCart add: 5 of: 'item01'.
	aCart add: 6 of: 'item01'.
	aCart add: 4 of: 'item02'.
	
	expectedItems _ Set with: (Dictionary newFrom: {'item01'->11}) with: (Dictionary newFrom: {'item02'->4}).
	
	self assert: ((aCart items) isEqualTo: expectedItems)! !


!classDefinition: #Cart category: #TusLibros stamp: 'gc 10/31/2019 16:30:47'!
Object subclass: #Cart
	instanceVariableNames: 'items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'observer' stamp: 'gc 10/30/2019 22:53:24'!
amountOf: aProductId 
	^items occurrencesOf: aProductId.! !

!Cart methodsFor: 'observer' stamp: 'gc 10/30/2019 22:23:02'!
isEmpty
	^items isEmpty ! !

!Cart methodsFor: 'observer' stamp: 'gc 10/30/2019 23:17:37'!
items
	^(items asSet) collect: [:item | Dictionary newFrom: {item->(items occurrencesOf: item)}]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 23:03:45'!
add: aQuantity of: aProductId 
	aQuantity <= 0 ifTrue: [^self error: (self class invalidQuantity)].
	^aQuantity timesRepeat: [items add: aProductId ] .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'gc 10/30/2019 22:51:30'!
initialize
	items _ Bag new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'gc 10/31/2019 16:30:47'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'gc 10/30/2019 22:22:11'!
create
	^self new initialize! !


!Cart class methodsFor: 'error' stamp: 'gc 10/30/2019 23:01:15'!
invalidQuantity
	^'La cantidad debe ser mayor a 0'! !
