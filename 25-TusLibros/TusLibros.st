!classDefinition: #CartTest category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'gc 11/4/2019 19:17:35'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'gc 11/4/2019 19:18:01'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'gc 11/4/2019 19:18:01'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSoldByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'gc 11/4/2019 19:17:35'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSoldByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'gc 11/4/2019 19:18:01'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSoldByTheStore.
	self assert: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'gc 11/4/2019 19:18:01'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'gc 11/4/2019 19:18:01'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSoldByTheStore.
	self assert: (cart occurrencesOf: self itemSoldByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'gc 11/4/2019 20:12:51'!
test09CartTotalForManyItemsReturnsSum

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSoldByTheStore.
	
	self assert: (cart total) equals: (2 * (self defaultCatalog at: self itemSoldByTheStore)) .
	! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'gc 11/4/2019 19:18:01'!
defaultCatalog
	
	^ Dictionary newFrom:  {self itemSoldByTheStore -> (10*peso) }.! !

!CartTest methodsFor: 'support' stamp: 'gc 11/4/2019 19:17:35'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'gc 11/4/2019 19:18:01'!
itemSoldByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 19:18:01'!
defaultCatalog
	^ Dictionary newFrom:  {self itemSoldByTheStore -> (10*peso) }.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 19:18:01'!
itemSoldByTheStore
	^ 'validBook'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 19:09:34'!
setUp
	cart _ Cart acceptingItemsOf: self defaultCatalog ! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 19:36:15'!
test01cashierCantCheckOutEmptyCart
	| creditCard date salesBook expireDate|
	salesBook _ OrderedCollection new.
	date _ FixedGregorianDate today.
	expireDate _ GregorianMonthOfYear year: (date year next ) month: (date month ).
	creditCard _ CreditCard with: 1234567891234567 for: 'Alan Kay' expiresOn: expireDate.

	self 
		should: [ Cashier with: cart on: date with: creditCard registeringOn: salesBook .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorMessage.
			self assert: salesBook isEmpty .]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 19:39:17'!
test02cashierCantCheckOutWithExpiredCreditCard
	| creditCard date salesBook expireDate|
	salesBook _ OrderedCollection new.
	date _ FixedGregorianDate today.
	expireDate _ GregorianMonthOfYear year: (date year previous ) month: (date month ).
	creditCard _ CreditCard with: 1234567891234567 for: 'Alan Kay' expiresOn: expireDate.
	cart add: self itemSoldByTheStore .

	self 
		should: [ Cashier with: cart on: date with: creditCard registeringOn: salesBook .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCardErrorMessage.
			self assert: salesBook isEmpty .]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 20:18:50'!
test03cashierCalculatesTotalPriceWhenCheckingOut
	| creditCard date salesBook expireDate cashier total |
	salesBook _ OrderedCollection new.
	date _ FixedGregorianDate today.
	expireDate _ GregorianMonthOfYear year: (date year next ) month: (date month ).
	creditCard _ CreditCard with: 1234567891234567 for: 'Alan Kay' expiresOn: expireDate.
	cart add: 2 of: self itemSoldByTheStore .

	cashier _  Cashier with: cart on: date with: creditCard registeringOn: salesBook .
	total _ cashier checkout.
	self assert: (total) equals: (2 * (self defaultCatalog at: self itemSoldByTheStore) ).
	self assert: (salesBook size) equals: 1.
	self assert: total equals: (salesBook at: 1).! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 20:58:02'!
test01CantCreateCardWithShortNumber
	| expireDate year |
	year _ GregorianYear number: 1995.
	expireDate _ GregorianMonthOfYear year: year month: September .
	self 
		should: [ CreditCard with: 123456789123467 for: 'Alan Kay' expiresOn: expireDate.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidNumberErrorMessage.]	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 20:58:15'!
test02CantCreateCardWithLongNumber
	| expireDate year |
	year _ GregorianYear number: 1995.
	expireDate _ GregorianMonthOfYear year: year month: September .
	self 
		should: [ CreditCard with: 12345678912345678 for: 'Alan Kay' expiresOn: expireDate.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidNumberErrorMessage.]	! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 20:58:25'!
test03CantCreateCardWithLongName
	| expireDate year |
	year _ GregorianYear number: 1995.
	expireDate _ GregorianMonthOfYear year: year month: September .
	self 
		should: [ CreditCard with: 1234567891234567 for: 'Alan Kay, Alan Turing, Dan Ingalls and Adele Goldberg' expiresOn: expireDate.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard invalidNameErrorMessage.]	! !


!classDefinition: #Cart category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'gc 11/4/2019 19:16:56'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'gc 10/31/2019 21:00:38'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'gc 11/4/2019 20:16:42'!
total
	^items inject: 0 into: [:sum :item | sum + (catalog at: item) ].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
Object subclass: #Cashier
	instanceVariableNames: 'cart date creditCard salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'gc 11/4/2019 19:31:02'!
initializeWith: aCart on: aDate with: aCreditCard registeringOn: aSalesBook
	cart := aCart.
	date := aDate.
	creditCard := aCreditCard.
	salesBook := aSalesBook.! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'gc 11/4/2019 20:06:28'!
checkout
	| total |
	total _ cart total .
	salesBook addLast: total .
	^ total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'gc 11/4/2019 20:01:41'!
with: aCart on: aDate with: aCreditCard registeringOn: aSalesBook
	aCart isEmpty ifTrue: [
		^self error: self emptyCartErrorMessage 
	].
	(aCreditCard isExpiredAt: aDate) ifTrue: [
		^self error: self expiredCardErrorMessage
	].
	
	^self new initializeWith: aCart on: aDate with: aCreditCard registeringOn: aSalesBook ! !


!Cashier class methodsFor: 'error message' stamp: 'gc 10/31/2019 21:27:00'!
emptyCartErrorMessage
	^'No se puede hacer checkout de carritos vacios'! !

!Cashier class methodsFor: 'error message' stamp: 'gc 11/4/2019 19:39:56'!
expiredCardErrorMessage
	^'La tarjeta esta vencida'! !

!Cashier class methodsFor: 'error message' stamp: 'gc 10/31/2019 21:55:07'!
itemNotInCatalogErrorMessage
	^'No se puede hacer checkout de este carrito porque tiene elementos que no estan en el catalogo del cajero'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
Object subclass: #CreditCard
	instanceVariableNames: 'number name expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'gc 11/4/2019 19:37:35'!
initializeWith: aNumber for: aName expiresOn: anExpirationDate 
	number := aNumber.
	name := aName.
	expirationDate := anExpirationDate.! !


!CreditCard methodsFor: 'comparing' stamp: 'gc 11/4/2019 20:03:09'!
isExpiredAt: aDate 
	^expirationDate < aDate .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'gc 11/4/2019 21:27:47'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'gc 11/4/2019 20:56:56'!
with: aNumber for: aName expiresOn: anExpirationDate 
	((aNumber floorLog: 10) ~= 15) ifTrue: [^self error: self invalidNumberErrorMessage].
	((aName size) > 30) ifTrue: [^self error: self invalidNameErrorMessage ].
	^self new initializeWith: aNumber for: aName expiresOn: anExpirationDate. ! !


!CreditCard class methodsFor: 'error message' stamp: 'gc 11/4/2019 20:51:45'!
invalidNameErrorMessage
	^'El nombre es muy largo'! !

!CreditCard class methodsFor: 'error message' stamp: 'gc 11/4/2019 20:27:05'!
invalidNumberErrorMessage
	^'Numero invalido'! !
