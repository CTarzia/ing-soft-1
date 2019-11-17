!classDefinition: #CartTest category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'gc 11/11/2019 18:31:54'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			through: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'gc 11/11/2019 18:31:54'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'gc 11/11/2019 18:31:54'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				through: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'gc 11/11/2019 18:31:54'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'gc 11/11/2019 18:31:54'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'gc 11/11/2019 18:31:54'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InternalInterfaceTest category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
TestCase subclass: #InternalInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 18:41:08'!
debit: anAmount from: aCreditCard 
! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 19:45:53'!
setUp
	testObjectsFactory _ StoreTestObjectsFactory new.! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:53:27'!
test01CreateCartForAValidUserAndPasswordCreatesACart
	| internalInterface aUserName aPassword userList cartID |
	
	userList  _ testObjectsFactory defaultUserList .
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	self assert: (internalInterface hasACartWith: cartID ).
	self assert: aUserName equals: (internalInterface ownerOf: cartID).! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:53:27'!
test02CreateCartForAnInvalidUserDoesntCreateACart
	| internalInterface aUserName aPassword userList |
	
	userList  _ testObjectsFactory defaultUserList .
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	aUserName _ testObjectsFactory invalidUserOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .

	self
		should: [internalInterface createCartFor: aUserName with: aPassword .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidUserErrorMessage.
			self assert: internalInterface hasNoCarts ]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:53:27'!
test03CreateCartForValidUserAndInvalidPasswordDoesntCreateACart
	| internalInterface aUserName aPassword userList |
	
	userList  _ testObjectsFactory defaultUserList .
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory invalidPasswordOfUserOfTheStore .

	self
		should: [internalInterface createCartFor: aUserName with: aPassword .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidPasswordErrorMessage.
			self assert: internalInterface hasNoCarts ]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:53:27'!
test04DifferentCartsHaveDifferentIDs
	| internalInterface aUserName aPassword userList cartID1 cartID2 |
	
	userList  _ testObjectsFactory defaultUserList .
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID1 _ internalInterface createCartFor: aUserName with: aPassword .
	cartID2 _ internalInterface createCartFor: aUserName with: aPassword .
	self assert: (internalInterface hasACartWith: cartID1 ).
	self assert: (internalInterface hasACartWith: cartID2 ).
	self assert: aUserName equals: (internalInterface ownerOf: cartID1).
	self assert: aUserName equals: (internalInterface ownerOf: cartID2).
	self deny: cartID1 = cartID2.! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 21:15:37'!
test05CantAddToCartWithInvalidCartID
	| internalInterface userList cartID bookISBN |
	
	userList  _ testObjectsFactory defaultUserList .
	cartID _ testObjectsFactory invalidCartID.
	bookISBN _ testObjectsFactory validEditorialISBN.
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	self
		should: [ internalInterface addToCart: cartID book: bookISBN quantity: 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidCartIDErrorMessage.
		]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 21:06:04'!
test06CanAddToCartWithValidCartIDAndISBN
	| internalInterface userList cartID bookISBN aPassword aUserName |
	
	userList  _ testObjectsFactory defaultUserList .
	bookISBN _ testObjectsFactory validEditorialISBN.
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	
	internalInterface addToCart: cartID book: bookISBN quantity: 1.
	
	self assert: (internalInterface cart: cartID has: bookISBN ).! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 21:12:09'!
test07CantAddToCartWithInvalidISBN
	| internalInterface userList cartID bookISBN aPassword aUserName |
	
	userList  _ testObjectsFactory defaultUserList .
	bookISBN _ testObjectsFactory invalidEditorialISBN .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	
	self
		should: [internalInterface addToCart: cartID book: bookISBN quantity: 1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = (internalInterface getCartWith: cartID) invalidItemErrorMessage .
			]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 21:15:27'!
test08CantListCartWithInvalidCartID
	| internalInterface userList cartID |
	
	userList  _ testObjectsFactory defaultUserList .
	cartID _ testObjectsFactory invalidCartID.
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	self
		should: [ internalInterface listCart: cartID. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidCartIDErrorMessage. ]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 17:55:52'!
test09ListEmptyCartWithValidCartIDReturnsEmptyCollection
	| internalInterface userList cartID aPassword aUserName expectedListedCart |
	
	userList  _ testObjectsFactory defaultUserList .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	
	expectedListedCart _ Dictionary new.
	
	self assert: expectedListedCart equals: (internalInterface listCart: cartID ).! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 17:45:24'!
test10ListCartWithValidCartIDWorks
	| internalInterface userList cartID aPassword aUserName bookISBN expectedListedCart |
	
	userList  _ testObjectsFactory defaultUserList .
	bookISBN _ testObjectsFactory validEditorialISBN.
	
	cartID _ testObjectsFactory invalidCartID.
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	
	internalInterface addToCart: cartID book: bookISBN quantity: 1.
	
	expectedListedCart _ Dictionary newFrom: {bookISBN -> 1}.
	
	self assert: expectedListedCart equals: (internalInterface listCart: cartID ).! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 18:26:07'!
test11checkOutCartWithInvalidIDShouldFail
	| internalInterface userList cartID creditCard|
	
	userList  _ testObjectsFactory defaultUserList .
	cartID _ testObjectsFactory invalidCartID.
	creditCard _ testObjectsFactory notExpiredCreditCard .
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidCartIDErrorMessage. ]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 18:34:01'!
test12checkOutCartWithExpiredCardShouldFail
	| internalInterface userList cartID creditCard user password bookISBN |
	
	userList  _ testObjectsFactory defaultUserList .
	creditCard _ testObjectsFactory expiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	bookISBN _ testObjectsFactory validEditorialISBN .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	cartID _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cartID book: bookISBN quantity: 1.
	
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage . ]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 18:26:07'!
test13checkOutCartWithEmptyCartShouldFail
	| internalInterface userList cartID creditCard user password|
	
	userList  _ testObjectsFactory defaultUserList .
	creditCard _ testObjectsFactory notExpiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	cartID _ internalInterface createCartFor: user with: password .
	
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage . ]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 18:43:44'!
test14checkOutCartCorrectlyChecksOut
	| internalInterface userList cartID creditCard user password bookISBN total bookPrice|
	
	userList  _ testObjectsFactory defaultUserList .
	creditCard _ testObjectsFactory notExpiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	bookISBN _ testObjectsFactory validEditorialISBN .
	bookPrice _ testObjectsFactory itemSellByTheStorePrice .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	cartID _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cartID book: bookISBN quantity: 1.
	
	total _ internalInterface checkOutCart: cartID charging: creditCard through: self . 
	
	self assert: bookPrice equals: total.
 	self assert: (internalInterface lastRegisteredIs: total).
	
	! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 18:59:47'!
test15listPurchasesOfClientThatDidntBuyReturns0
	| internalInterface userList user password  listedPurchases purchasedAmount|
	
	userList  _ testObjectsFactory defaultUserList .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	listedPurchases _ internalInterface listPurchasesOf: user with: password.
	purchasedAmount _ internalInterface purchasedAmountOf: user with: password .
	
	self assert: listedPurchases isEmpty .
	self assert: purchasedAmount equals: 0.! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 20:01:00'!
test16listPurchasesOfInvalidClientFails
	| internalInterface userList user password  |
	
	userList  _ testObjectsFactory defaultUserList .
	user _ testObjectsFactory invalidUserOfTheStore .
	password _ testObjectsFactory invalidPasswordOfUserOfTheStore .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).

	self
		should: [internalInterface listPurchasesOf: user with: password. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = InternalInterface invalidUserErrorMessage . ].
! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 20:00:52'!
test17purchasedAmountOfInvalidClientFails
	| internalInterface userList user password  |
	
	userList  _ testObjectsFactory defaultUserList .
	user _ testObjectsFactory invalidUserOfTheStore .
	password _ testObjectsFactory invalidPasswordOfUserOfTheStore .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).

	self
		should: [internalInterface purchasedAmountOf: user with: password . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = InternalInterface invalidUserErrorMessage . ]! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 20:02:52'!
test18listPurchasesWithInvalidPasswordFails
	| internalInterface userList user password  |
	
	userList  _ testObjectsFactory defaultUserList .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory invalidPasswordOfUserOfTheStore .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).

	self
		should: [internalInterface listPurchasesOf: user with: password. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = InternalInterface invalidPasswordErrorMessage . ].
! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 20:03:49'!
test19purchasedAmountWithInvalidPasswordFails
	| internalInterface userList user password  |
	
	userList  _ testObjectsFactory defaultUserList .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory invalidPasswordOfUserOfTheStore .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).

	self
		should: [internalInterface purchasedAmountOf: user with: password. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = InternalInterface invalidPasswordErrorMessage . ].
! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/14/2019 20:06:20'!
test20listPurchasesOfClientThatBoughtReturnsPurchases
	| internalInterface userList user password cart1 cart2 book creditCard listedPurchases expectedListedPurchases|
	
	userList  _ testObjectsFactory defaultUserList .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	book _ testObjectsFactory validEditorialISBN .
	creditCard _ testObjectsFactory notExpiredCreditCard .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	cart1 _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cart1 book: book quantity: 1.
	internalInterface checkOutCart: cart1 charging: creditCard through: self.
	
	cart2 _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cart2 book: book quantity: 2.
	internalInterface checkOutCart: cart2 charging: creditCard through: self.
	
	listedPurchases _ internalInterface listPurchasesOf: user with: password.
	expectedListedPurchases _ Dictionary newFrom: {book -> 3}.
	
	self assert: expectedListedPurchases equals: listedPurchases.! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/14/2019 20:06:01'!
test21listPurchasedAmountOfClientThatBoughtReturnsTotal
	| internalInterface userList user password cart1 cart2 book creditCard total purchasedAmount |
	
	userList  _ testObjectsFactory defaultUserList .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	book _ testObjectsFactory validEditorialISBN .
	creditCard _ testObjectsFactory notExpiredCreditCard .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	
	cart1 _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cart1 book: book quantity: 1.
	total _ internalInterface checkOutCart: cart1 charging: creditCard through: self.
	
	cart2 _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cart2 book: book quantity: 2.
	total _ total + (internalInterface checkOutCart: cart2 charging: creditCard through: self).
	
	purchasedAmount _ internalInterface purchasedAmountOf: user with: password.
	
	self assert: total equals: purchasedAmount.! !

!InternalInterfaceTest methodsFor: 'as yet unclassified' stamp: 'gc 11/14/2019 20:19:44'!
test22CheckOutCart30MinAfterLastTransactionFails
	| internalInterface userList cartID creditCard user password|
	
	userList  _ testObjectsFactory defaultUserList .
	creditCard _ testObjectsFactory notExpiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog).
	cartID _ internalInterface createCartFor: user with: password .
	
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage . ]! !


!classDefinition: #Cart category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'gc 11/14/2019 19:53:34'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 17:52:37'!
list
	| listedItems |
	listedItems _ Dictionary new.
	(items asSet) collect: [:anItem | listedItems at: anItem put: (self occurrencesOf: anItem).].
	^listedItems .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'gc 11/11/2019 18:26:54'!
initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'gc 11/11/2019 18:31:54'!
toCheckout: aCart charging: aCreditCard through: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InternalInterface category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
Object subclass: #InternalInterface
	instanceVariableNames: 'userList cartOwners nextCartID catalog salesBook listedPurchases cartsAndOwners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalInterface methodsFor: 'testing' stamp: 'gc 11/14/2019 19:19:30'!
hasACartWith: aCartID 
	cartsAndOwners at: aCartID ifAbsent: [^false].
	^true
! !

!InternalInterface methodsFor: 'testing' stamp: 'gc 11/11/2019 20:51:55'!
hasNoCarts
	^cartsAndOwners isEmpty . ! !

!InternalInterface methodsFor: 'testing' stamp: 'gc 11/11/2019 20:53:20'!
ownerOf: aCartID 
	^(cartsAndOwners at: aCartID) at: 'owner'! !


!InternalInterface methodsFor: 'cart creation' stamp: 'gc 11/11/2019 20:55:40'!
createCartFor: aUser with: aPassword 
	| recordedPassword cartID cart cartData |
	recordedPassword _ userList at: aUser ifAbsent: [^self error: self class invalidUserErrorMessage].
	(recordedPassword = aPassword) ifFalse: [^self error: self class invalidPasswordErrorMessage].
	cartID _ nextCartID .
	nextCartID _ nextCartID + 1.
	"cartOwners at: cartID put: aUser ."
	cart _ Cart acceptingItemsOf: catalog.
	"carts at: cartID put: cart ."
	cartData _ Dictionary newFrom: {'owner'->aUser. 'cart'->cart}.
	cartsAndOwners at: cartID put: cartData.
	^cartID ! !


!InternalInterface methodsFor: 'initialization' stamp: 'gc 11/14/2019 19:23:46'!
initializeWithUserList: aUserList andCatalog: aCatalog  
	userList _ aUserList.
	cartsAndOwners _ Dictionary new.
	nextCartID _ 1.
	catalog _ aCatalog .
	salesBook _ OrderedCollection new.
	listedPurchases _ Dictionary new.! !


!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 20:56:36'!
addToCart: aCartID book: aBookISBN quantity: anAmount
	| cartData |
	cartData _ cartsAndOwners at: aCartID ifAbsent: [^self error: self class invalidCartIDErrorMessage .].
	(cartData at: 'cart') add: anAmount of: aBookISBN .	! !

!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/14/2019 19:50:24'!
addToListedPurchases: aCartID
	| cart cartData owner purchases list |
	cartData _ cartsAndOwners at: aCartID.
	cart _ cartData at: 'cart'.
	owner _ cartData at: 'owner'.
	purchases _ listedPurchases at: owner ifAbsent: [Dictionary new].
	list _ cart list.
	(list keys) collect: [:item | | amount | 
		amount _ purchases at: item ifAbsent: [0]. 
		purchases at: (item) put: (amount + (list at: item)) .
	].

	listedPurchases at: owner put: purchases .! !

!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 20:49:31'!
cart: aCartID has: aBookISBN
	^((cartsAndOwners at: aCartID ) at: 'cart') includes: aBookISBN .! !

!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/14/2019 19:21:52'!
checkOutCart: aCartID charging: aCreditCard through: aMerchantProcessor  
	| cartData cart cashier |
	cartData _ cartsAndOwners at: aCartID ifAbsent: [^self error: self class invalidCartIDErrorMessage] .
	cart _ cartData at: 'cart'.
	cashier _ Cashier toCheckout: cart charging: aCreditCard through: aMerchantProcessor on: (DateAndTime now) registeringOn: salesBook .
	self addToListedPurchases: aCartID.	
	^cashier checkOut ! !

!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 20:50:13'!
getCartWith: aCartID 
	^(cartsAndOwners at: aCartID) at: 'cart'.! !

!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 18:45:24'!
lastRegisteredIs: aTotal
	 ^(salesBook last total) = aTotal! !

!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/11/2019 20:57:11'!
listCart: aCartID 
	| cartData |
	cartData _ cartsAndOwners at: aCartID ifAbsent: [^self error: self class invalidCartIDErrorMessage] .
	^(cartData at: 'cart' ) list.
	! !

!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/14/2019 19:29:21'!
listPurchasesOf: aUser with: aPassword 
	| recordedPassword|
	
	recordedPassword _ userList at: aUser ifAbsent: [^self error: self class invalidUserErrorMessage].
	(recordedPassword = aPassword) ifFalse: [^self error: self class invalidPasswordErrorMessage].
	
	^listedPurchases at: aUser ifAbsent: [^Dictionary new]! !

!InternalInterface methodsFor: 'as yet unclassified' stamp: 'gc 11/14/2019 20:16:39'!
purchasedAmountOf: aUser with: aPassword 

	| recordedPassword purchases |
	recordedPassword _ userList at: aUser ifAbsent: [^self error: self class invalidUserErrorMessage].
	(recordedPassword = aPassword) ifFalse: [^self error: self class invalidPasswordErrorMessage].
	purchases _ self listPurchasesOf: aUser with: aPassword.
	^( purchases keys) inject: 0 into: [:sum :each | sum + ((catalog at: each) * (purchases at: each) )]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalInterface class' category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
InternalInterface class
	instanceVariableNames: ''!

!InternalInterface class methodsFor: 'instance creation' stamp: 'gc 11/7/2019 20:57:29'!
withUserList: aUserList andCatalog: aCatalog  
	^self new initializeWithUserList: aUserList andCatalog: aCatalog ! !


!InternalInterface class methodsFor: 'error message' stamp: 'gc 11/7/2019 20:11:37'!
invalidPasswordErrorMessage
	^'Contrasenia invalida'! !

!InternalInterface class methodsFor: 'error message' stamp: 'gc 11/7/2019 20:06:36'!
invalidUserErrorMessage
	^'Usuario invalido'! !


!InternalInterface class methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:39:08'!
invalidCartIDErrorMessage
	^'No hay un cart con ese ID'! !


!classDefinition: #Sale category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'gc 11/14/2019 20:34:27'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:33:50'!
defaultBookCatalog
	
	^ Dictionary new
		at: self validEditorialISBN put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 19:47:00'!
defaultUserList
	
	^ Dictionary new
		at: self userOfTheStore put: self passwordOfUserOfTheStore;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:28:32'!
invalidCartID
	^'-10'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:35:09'!
invalidEditorialISBN
	^ '000-3-16-148410-0'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 19:48:10'!
invalidPasswordOfUserOfTheStore
	^'an invalid password'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 19:47:57'!
invalidUserOfTheStore
	^'an invalid user'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 19:47:37'!
passwordOfUserOfTheStore
	^'a valid password'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 19:47:17'!
userOfTheStore
	^'a valid user'! !

!StoreTestObjectsFactory methodsFor: 'as yet unclassified' stamp: 'gc 11/7/2019 20:34:45'!
validEditorialISBN
	^ '978-3-16-148410-0'! !
