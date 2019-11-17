!classDefinition: #CartTest category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
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


!classDefinition: #InternalInterfaceTest category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
TestCase subclass: #InternalInterfaceTest
	instanceVariableNames: 'testObjectsFactory userList clock internalInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalInterfaceTest methodsFor: 'setUp' stamp: 'gc 11/17/2019 15:39:56'!
setUp
	testObjectsFactory _ StoreTestObjectsFactory new.
	userList  _ testObjectsFactory defaultUserList .
	clock _ FakeClock withCurrentTime: (testObjectsFactory today).
	internalInterface _ InternalInterface withUserList: userList andCatalog: (testObjectsFactory defaultBookCatalog) andClock: clock .! !


!InternalInterfaceTest methodsFor: 'merchant processor' stamp: 'gc 11/11/2019 18:41:08'!
debit: anAmount from: aCreditCard 
! !


!InternalInterfaceTest methodsFor: 'clock' stamp: 'gc 11/17/2019 15:45:57'!
advanceTime: anAmountOfTime
	clock advanceTime: anAmountOfTime .! !


!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test01CreateCartForAValidUserAndPasswordCreatesACart
	|  aUserName aPassword cartID |
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	self assert: (internalInterface hasACartWith: cartID ).
	self assert: aUserName equals: (internalInterface ownerOf: cartID).! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test02CreateCartForAnInvalidUserDoesntCreateACart
	|  aUserName aPassword  |
	
	aUserName _ testObjectsFactory invalidUserOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .

	self
		should: [internalInterface createCartFor: aUserName with: aPassword .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidUserErrorMessage.
			self assert: internalInterface hasNoCarts ]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test03CreateCartForValidUserAndInvalidPasswordDoesntCreateACart
	|  aUserName aPassword  |
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory invalidPasswordOfUserOfTheStore .

	self
		should: [internalInterface createCartFor: aUserName with: aPassword .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidPasswordErrorMessage.
			self assert: internalInterface hasNoCarts ]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test04DifferentCartsHaveDifferentIDs
	|  aUserName aPassword  cartID1 cartID2 |
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID1 _ internalInterface createCartFor: aUserName with: aPassword .
	cartID2 _ internalInterface createCartFor: aUserName with: aPassword .
	self assert: (internalInterface hasACartWith: cartID1 ).
	self assert: (internalInterface hasACartWith: cartID2 ).
	self assert: aUserName equals: (internalInterface ownerOf: cartID1).
	self assert: aUserName equals: (internalInterface ownerOf: cartID2).
	self deny: cartID1 = cartID2.! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:33:22'!
test05CantAddToCartWithInvalidCartID
	|  cartID bookISBN |
	
	cartID _ testObjectsFactory invalidCartID.
	bookISBN _ testObjectsFactory validEditorialISBN.
	
	self
		should: [ internalInterface addToCart: cartID book: bookISBN quantity: 1. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidCartIDErrorMessage.
			self assert: internalInterface hasNoCarts .
		]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test06CanAddToCartWithValidCartIDAndISBN
	|  cartID bookISBN aPassword aUserName |
	
	bookISBN _ testObjectsFactory validEditorialISBN.

	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	
	internalInterface addToCart: cartID book: bookISBN quantity: 1.
	
	self assert: (internalInterface cart: cartID has: bookISBN ).! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:36:07'!
test07CantAddToCartWithInvalidISBN
	|  cartID bookISBN aPassword aUserName |
	
	bookISBN _ testObjectsFactory invalidEditorialISBN .
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	
	self
		should: [internalInterface addToCart: cartID book: bookISBN quantity: 1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = (internalInterface getCartWith: cartID) invalidItemErrorMessage .
			self deny: (internalInterface cart: cartID has: bookISBN ).
			]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:36:33'!
test08CantListCartWithInvalidCartID
	|  cartID |
	
	cartID _ testObjectsFactory invalidCartID.

	self
		should: [ internalInterface listCart: cartID. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidCartIDErrorMessage. 
			]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test09ListEmptyCartWithValidCartIDReturnsEmptyCollection
	|  cartID aPassword aUserName expectedListedCart |
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	
	expectedListedCart _ Dictionary new.
	
	self assert: expectedListedCart equals: (internalInterface listCart: cartID ).! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test10ListCartWithValidCartIDWorks
	| cartID aPassword aUserName bookISBN expectedListedCart |
	
	bookISBN _ testObjectsFactory validEditorialISBN.
	
	cartID _ testObjectsFactory invalidCartID.
	
	aUserName _ testObjectsFactory userOfTheStore .
	aPassword _ testObjectsFactory passwordOfUserOfTheStore .
	cartID _ internalInterface createCartFor: aUserName with: aPassword .
	
	internalInterface addToCart: cartID book: bookISBN quantity: 1.
	
	expectedListedCart _ Dictionary newFrom: {bookISBN -> 1}.
	
	self assert: expectedListedCart equals: (internalInterface listCart: cartID ).! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:40:28'!
test11checkOutCartWithInvalidIDShouldFail
	| cartID creditCard|
	
	cartID _ testObjectsFactory invalidCartID.
	creditCard _ testObjectsFactory notExpiredCreditCard .
	
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = InternalInterface invalidCartIDErrorMessage. 
			self deny: (internalInterface hasRegisteredSales)
			]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:40:28'!
test12checkOutCartWithExpiredCardShouldFail
	| cartID creditCard user password bookISBN |
	
	creditCard _ testObjectsFactory expiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	bookISBN _ testObjectsFactory validEditorialISBN .
	
	cartID _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cartID book: bookISBN quantity: 1.
	
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage . 
			self deny: internalInterface hasRegisteredSales.
			]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:40:28'!
test13checkOutCartWithEmptyCartShouldFail
	| cartID creditCard user password|
	
	creditCard _ testObjectsFactory notExpiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	
	cartID _ internalInterface createCartFor: user with: password .
	
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage . 
			self deny: internalInterface hasRegisteredSales 
			]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test14checkOutCartCorrectlyChecksOut
	| cartID creditCard user password bookISBN total bookPrice|
	
	creditCard _ testObjectsFactory notExpiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	bookISBN _ testObjectsFactory validEditorialISBN .
	bookPrice _ testObjectsFactory itemSellByTheStorePrice .
	
	cartID _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cartID book: bookISBN quantity: 1.
	
	total _ internalInterface checkOutCart: cartID charging: creditCard through: self . 
	
	self assert: bookPrice equals: total.
 	self assert: (internalInterface lastRegisteredIs: total).
	
	! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test15listPurchasesOfClientThatDidntBuyReturns0
	| user password  listedPurchases purchasedAmount|
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	
	listedPurchases _ internalInterface listPurchasesOf: user with: password.
	purchasedAmount _ internalInterface purchasedAmountOf: user with: password .
	
	self assert: listedPurchases isEmpty .
	self assert: purchasedAmount equals: 0.! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:41:03'!
test16listPurchasesOfInvalidClientFails
	| user password  |
	
	user _ testObjectsFactory invalidUserOfTheStore .
	password _ testObjectsFactory invalidPasswordOfUserOfTheStore .
	
	self
		should: [internalInterface listPurchasesOf: user with: password. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = InternalInterface invalidUserErrorMessage .
		].
! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test17purchasedAmountOfInvalidClientFails
	| user password  |
	
	user _ testObjectsFactory invalidUserOfTheStore .
	password _ testObjectsFactory invalidPasswordOfUserOfTheStore .
	
	self
		should: [internalInterface purchasedAmountOf: user with: password . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = InternalInterface invalidUserErrorMessage . ]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test18listPurchasesWithInvalidPasswordFails
	| user password  |
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory invalidPasswordOfUserOfTheStore .
	
	self
		should: [internalInterface listPurchasesOf: user with: password. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = InternalInterface invalidPasswordErrorMessage . ].
! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test19purchasedAmountWithInvalidPasswordFails
	| user password  |
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory invalidPasswordOfUserOfTheStore .
	
	self
		should: [internalInterface purchasedAmountOf: user with: password. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
		self assert: anError messageText = InternalInterface invalidPasswordErrorMessage . ].
! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:02:23'!
test20listPurchasesOfClientThatBoughtReturnsPurchases
	| user password cart1 cart2 book creditCard listedPurchases expectedListedPurchases|
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	book _ testObjectsFactory validEditorialISBN .
	creditCard _ testObjectsFactory notExpiredCreditCard .
	
	cart1 _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cart1 book: book quantity: 1.
	internalInterface checkOutCart: cart1 charging: creditCard through: self.
	
	cart2 _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cart2 book: book quantity: 2.
	internalInterface checkOutCart: cart2 charging: creditCard through: self.
	
	listedPurchases _ internalInterface listPurchasesOf: user with: password.
	expectedListedPurchases _ Dictionary newFrom: {book -> 3}.
	
	self assert: expectedListedPurchases equals: listedPurchases.! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 15:56:58'!
test21purchasedAmountOfClientThatBoughtReturnsTotal
	| user password cart1 cart2 book creditCard total purchasedAmount |
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	book _ testObjectsFactory validEditorialISBN .
	creditCard _ testObjectsFactory notExpiredCreditCard .
	
	cart1 _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cart1 book: book quantity: 1.
	total _ internalInterface checkOutCart: cart1 charging: creditCard through: self.
	
	cart2 _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cart2 book: book quantity: 2.
	total _ total + (internalInterface checkOutCart: cart2 charging: creditCard through: self).
	
	purchasedAmount _ internalInterface purchasedAmountOf: user with: password.
	
	self assert: total equals: purchasedAmount.! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:43:07'!
test22CheckOutCart30MinAfterLastTransactionFails
	| cartID creditCard user password bookISBN |
	
	creditCard _ testObjectsFactory notExpiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	bookISBN _ testObjectsFactory validEditorialISBN .
	
	cartID _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cartID book: bookISBN quantity: 2.
	self advanceTime: (internalInterface expirationWindow).
	
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = CartInformation expiredCartErrorMessage. 
			self deny: internalInterface hasRegisteredSales .
			self deny: (internalInterface hasCheckedOut: cartID) .
			]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:47:22'!
test23AddToCart30MinAfterCreationFails
	| cartID user password bookISBN |
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	bookISBN _ testObjectsFactory validEditorialISBN .
	
	cartID _ internalInterface createCartFor: user with: password .
	self advanceTime: (internalInterface expirationWindow).
	
	self
		should: [ internalInterface addToCart: cartID book: bookISBN quantity: 2. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = CartInformation expiredCartErrorMessage. 
			self deny: (internalInterface cart: cartID has: bookISBN )
			]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:05:15'!
test24CanAddToCart15MinAfterLastTransactionAnd30MinAfterCreation
	| cartID user password bookISBN1 bookISBN2 |
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	bookISBN1 _ testObjectsFactory validEditorialISBN .
	bookISBN2 _ testObjectsFactory anotherValidEditorialISBN .
	
	cartID _ internalInterface createCartFor: user with: password .
	self advanceTime: ((internalInterface expirationWindow)/2).
	internalInterface addToCart: cartID book: bookISBN1 quantity: 2.
	self advanceTime: ((internalInterface expirationWindow)/2).
	internalInterface addToCart: cartID book: bookISBN2 quantity: 2.
	
	self assert: (internalInterface cart: cartID has: bookISBN2 ).
	
	
	! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:09:11'!
test25ListCart30MinAfterCreationFails
	| cartID user password |
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	
	cartID _ internalInterface createCartFor: user with: password .
	self advanceTime: (internalInterface expirationWindow).
	
	self
		should: [ internalInterface listCart: cartID]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = CartInformation expiredCartErrorMessage. ]! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:13:52'!
test26CanListCart15MinAfterLastTransactionAnd30MinAfterCreation
	| cartID user password firstListedCart secondListedCart |
	
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	
	cartID _ internalInterface createCartFor: user with: password .
	self advanceTime: ((internalInterface expirationWindow)/2).
	firstListedCart _ internalInterface listCart: cartID.
	self advanceTime: ((internalInterface expirationWindow)/2).
	secondListedCart _ internalInterface listCart: cartID.
	
	self assert: secondListedCart equals: firstListedCart 
	
	! !

!InternalInterfaceTest methodsFor: 'test' stamp: 'gc 11/17/2019 16:49:18'!
test27CantCheckOutTheSameCartTwice
	| cartID creditCard user password bookISBN |
	
	creditCard _ testObjectsFactory notExpiredCreditCard .
	user _ testObjectsFactory userOfTheStore .
	password _ testObjectsFactory passwordOfUserOfTheStore .
	bookISBN _ testObjectsFactory validEditorialISBN .
	
	cartID _ internalInterface createCartFor: user with: password .
	internalInterface addToCart: cartID book: bookISBN quantity: 2.
	internalInterface checkOutCart: cartID charging: creditCard through: self .
	self
		should: [ internalInterface checkOutCart: cartID charging: creditCard through: self . ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = CartInformation hasCheckedOutErrorMessage. 
			self assert: ((internalInterface salesBook size) = 1)
			]! !


!classDefinition: #Cart category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
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


!Cart methodsFor: 'list' stamp: 'gc 11/11/2019 17:52:37'!
list
	| listedItems |
	listedItems _ Dictionary new.
	(items asSet) collect: [:anItem | listedItems at: anItem put: (self occurrencesOf: anItem).].
	^listedItems .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartInformation category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
Object subclass: #CartInformation
	instanceVariableNames: 'owner cart lastUsedTime internalInterface hasCheckedOut'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartInformation methodsFor: 'assert' stamp: 'gc 11/17/2019 16:29:06'!
assertHasntCheckedOutYet
	^hasCheckedOut ifTrue: [^self error: self class hasCheckedOutErrorMessage]! !

!CartInformation methodsFor: 'assert' stamp: 'gc 11/17/2019 15:52:43'!
assertIsNotExpired
	((internalInterface now) - lastUsedTime ) >= (internalInterface expirationWindow ) ifTrue: [^self error: self class expiredCartErrorMessage]! !


!CartInformation methodsFor: 'initialization' stamp: 'gc 11/17/2019 16:29:44'!
initializeFor: aCart from: anOwner with: anInternalInterface
	cart _ aCart.
	owner _ anOwner .
	internalInterface _ anInternalInterface .
	hasCheckedOut _ false.
	self updateLastUsedTime .! !


!CartInformation methodsFor: 'observer' stamp: 'gc 11/17/2019 15:31:56'!
cart
	^cart! !

!CartInformation methodsFor: 'observer' stamp: 'gc 11/17/2019 16:44:17'!
hasCheckedOut
	^hasCheckedOut! !

!CartInformation methodsFor: 'observer' stamp: 'gc 11/17/2019 15:32:03'!
owner
	^owner! !


!CartInformation methodsFor: 'operation' stamp: 'gc 11/17/2019 16:15:09'!
add: anAmount of: aBookISBN
	cart add: anAmount of: aBookISBN .
	self updateLastUsedTime.! !

!CartInformation methodsFor: 'operation' stamp: 'gc 11/17/2019 16:30:37'!
checkOutCharging: aCreditCard through: aMerchantProcessor 
	| cashier total |
	self assertIsNotExpired.
	self assertHasntCheckedOutYet.
	cashier _ Cashier toCheckout: cart charging: aCreditCard through: aMerchantProcessor on: (DateAndTime now) registeringOn: (internalInterface salesBook).
	total _ cashier checkOut.
	hasCheckedOut _ true.
	^total ! !

!CartInformation methodsFor: 'operation' stamp: 'gc 11/17/2019 16:14:47'!
list
	self assertIsNotExpired .
	self updateLastUsedTime. 
	^cart list! !


!CartInformation methodsFor: 'query' stamp: 'gc 11/17/2019 15:41:16'!
includes: aBookISBN
	^cart includes: aBookISBN! !


!CartInformation methodsFor: 'time management' stamp: 'gc 11/17/2019 16:15:25'!
updateLastUsedTime
	lastUsedTime _ internalInterface now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartInformation class' category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
CartInformation class
	instanceVariableNames: ''!

!CartInformation class methodsFor: 'instance creation' stamp: 'gc 11/17/2019 15:14:57'!
for: aCart from: anOwner with: anInternalInterface
	^self new initializeFor: aCart from: anOwner with: anInternalInterface
	! !


!CartInformation class methodsFor: 'error message' stamp: 'gc 11/17/2019 15:55:40'!
expiredCartErrorMessage
	^'Este carrito esta vencido'! !

!CartInformation class methodsFor: 'error message' stamp: 'gc 11/17/2019 16:31:49'!
hasCheckedOutErrorMessage
	^'Este carrito ya hizo check out'! !


!classDefinition: #Cashier category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
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

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
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


!classDefinition: #CreditCard category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #FakeClock category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
Object subclass: #FakeClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakeClock methodsFor: 'initialization' stamp: 'gc 11/17/2019 15:37:17'!
initializeWithCurrentTime: aTime
	now _ aTime .! !


!FakeClock methodsFor: 'time management' stamp: 'gc 11/17/2019 15:53:32'!
advanceTime: anAmountOfTime 
	now _ now + anAmountOfTime! !

!FakeClock methodsFor: 'time management' stamp: 'gc 11/17/2019 15:37:37'!
now
	^now! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FakeClock class' category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
FakeClock class
	instanceVariableNames: ''!

!FakeClock class methodsFor: 'instance creation' stamp: 'gc 11/17/2019 15:36:42'!
withCurrentTime: aTime
	^self new initializeWithCurrentTime: aTime! !


!classDefinition: #InternalInterface category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
Object subclass: #InternalInterface
	instanceVariableNames: 'userList nextCartID catalog salesBook listedPurchases cartsInformation clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InternalInterface methodsFor: 'testing' stamp: 'gc 11/17/2019 15:19:37'!
hasACartWith: aCartID 
	cartsInformation at: aCartID ifAbsent: [^false].
	^true
! !

!InternalInterface methodsFor: 'testing' stamp: 'gc 11/17/2019 15:19:37'!
hasNoCarts
	^cartsInformation isEmpty . ! !

!InternalInterface methodsFor: 'testing' stamp: 'gc 11/17/2019 15:40:19'!
ownerOf: aCartID 
	^(cartsInformation at: aCartID) owner.! !


!InternalInterface methodsFor: 'cart creation' stamp: 'gc 11/17/2019 15:19:37'!
createCartFor: aUser with: aPassword 
	| recordedPassword cartID cart cartInformation |
	recordedPassword _ userList at: aUser ifAbsent: [^self error: self class invalidUserErrorMessage].
	(recordedPassword = aPassword) ifFalse: [^self error: self class invalidPasswordErrorMessage].
	cartID _ nextCartID .
	nextCartID _ nextCartID + 1.
	cart _ Cart acceptingItemsOf: catalog.
	
	cartInformation _ CartInformation for: cart from: aUser with: self.
	
	cartsInformation at: cartID put: cartInformation .
	^cartID ! !


!InternalInterface methodsFor: 'initialization' stamp: 'gc 11/17/2019 15:33:59'!
initializeWithUserList: aUserList andCatalog: aCatalog withClock: aClock   
	userList _ aUserList.
	cartsInformation _ Dictionary new.
	nextCartID _ 1.
	catalog _ aCatalog .
	salesBook _ OrderedCollection new.
	listedPurchases _ Dictionary new.
	clock _ aClock! !


!InternalInterface methodsFor: 'add to cart' stamp: 'gc 11/17/2019 16:06:45'!
addToCart: aCartID book: aBookISBN quantity: anAmount
	| cartInformation |
	cartInformation _ cartsInformation at: aCartID ifAbsent: [^self error: self class invalidCartIDErrorMessage .].
	cartInformation assertIsNotExpired .
	cartInformation add: anAmount of: aBookISBN .! !


!InternalInterface methodsFor: 'query' stamp: 'gc 11/17/2019 15:30:32'!
cart: aCartID has: aBookISBN
	^(cartsInformation at: aCartID ) includes: aBookISBN! !

!InternalInterface methodsFor: 'query' stamp: 'gc 11/17/2019 15:31:06'!
getCartWith: aCartID 
	^(cartsInformation at: aCartID) cart.! !

!InternalInterface methodsFor: 'query' stamp: 'gc 11/17/2019 16:45:19'!
hasCheckedOut: aCartID 
	^(cartsInformation at: aCartID) hasCheckedOut.! !

!InternalInterface methodsFor: 'query' stamp: 'gc 11/17/2019 16:40:28'!
hasRegisteredSales
	^salesBook isEmpty not! !

!InternalInterface methodsFor: 'query' stamp: 'gc 11/11/2019 18:45:24'!
lastRegisteredIs: aTotal
	 ^(salesBook last total) = aTotal! !

!InternalInterface methodsFor: 'query' stamp: 'gc 11/17/2019 16:31:08'!
salesBook
	^salesBook ! !


!InternalInterface methodsFor: 'time management' stamp: 'gc 11/17/2019 15:54:49'!
expirationWindow
	^30 minutes! !

!InternalInterface methodsFor: 'time management' stamp: 'gc 11/17/2019 15:34:18'!
now
	^clock now.! !


!InternalInterface methodsFor: 'list purchases' stamp: 'gc 11/17/2019 15:29:20'!
addToListedPurchases: aCartID
	| cart cartInformation owner purchases list |
	cartInformation _ cartsInformation at: aCartID.
	cart _ cartInformation cart.
	owner _ cartInformation owner.
	purchases _ listedPurchases at: owner ifAbsent: [Dictionary new].
	list _ cart list.
	(list keys) collect: [:item | | amount | 
		amount _ purchases at: item ifAbsent: [0]. 
		purchases at: (item) put: (amount + (list at: item)) .
	].

	listedPurchases at: owner put: purchases .! !

!InternalInterface methodsFor: 'list purchases' stamp: 'gc 11/14/2019 19:29:21'!
listPurchasesOf: aUser with: aPassword 
	| recordedPassword|
	
	recordedPassword _ userList at: aUser ifAbsent: [^self error: self class invalidUserErrorMessage].
	(recordedPassword = aPassword) ifFalse: [^self error: self class invalidPasswordErrorMessage].
	
	^listedPurchases at: aUser ifAbsent: [^Dictionary new]! !

!InternalInterface methodsFor: 'list purchases' stamp: 'gc 11/14/2019 20:16:39'!
purchasedAmountOf: aUser with: aPassword 

	| recordedPassword purchases |
	recordedPassword _ userList at: aUser ifAbsent: [^self error: self class invalidUserErrorMessage].
	(recordedPassword = aPassword) ifFalse: [^self error: self class invalidPasswordErrorMessage].
	purchases _ self listPurchasesOf: aUser with: aPassword.
	^( purchases keys) inject: 0 into: [:sum :each | sum + ((catalog at: each) * (purchases at: each) )]! !


!InternalInterface methodsFor: 'list cart' stamp: 'gc 11/17/2019 15:31:37'!
listCart: aCartID 
	| cartInformation |
	cartInformation _ cartsInformation at: aCartID ifAbsent: [^self error: self class invalidCartIDErrorMessage] .
	^cartInformation list.
	! !


!InternalInterface methodsFor: 'check out' stamp: 'gc 11/17/2019 16:26:51'!
checkOutCart: aCartID charging: aCreditCard through: aMerchantProcessor  
	| cartInformation total|
	cartInformation _ cartsInformation at: aCartID ifAbsent: [^self error: self class invalidCartIDErrorMessage] .
	total _ cartInformation checkOutCharging: aCreditCard through: aMerchantProcessor .
	self addToListedPurchases: aCartID.
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalInterface class' category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
InternalInterface class
	instanceVariableNames: ''!

!InternalInterface class methodsFor: 'instance creation' stamp: 'gc 11/17/2019 14:44:41'!
withUserList: aUserList andCatalog: aCatalog andClock: aClock   
	^self new initializeWithUserList: aUserList andCatalog: aCatalog withClock: aClock ! !


!InternalInterface class methodsFor: 'error message' stamp: 'gc 11/7/2019 20:39:08'!
invalidCartIDErrorMessage
	^'No hay un cart con ese ID'! !

!InternalInterface class methodsFor: 'error message' stamp: 'gc 11/7/2019 20:11:37'!
invalidPasswordErrorMessage
	^'Contrasenia invalida'! !

!InternalInterface class methodsFor: 'error message' stamp: 'gc 11/7/2019 20:06:36'!
invalidUserErrorMessage
	^'Usuario invalido'! !


!classDefinition: #Sale category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
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

!classDefinition: 'Sale class' category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'gc 11/17/2019 17:01:53'!
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

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'gc 11/7/2019 20:28:32'!
invalidCartID
	^'-10'! !


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


!StoreTestObjectsFactory methodsFor: 'ISBN' stamp: 'gc 11/17/2019 16:05:27'!
anotherValidEditorialISBN
	^ '978-3-16-148410-1'! !

!StoreTestObjectsFactory methodsFor: 'ISBN' stamp: 'gc 11/7/2019 20:35:09'!
invalidEditorialISBN
	^ '000-3-16-148410-0'! !

!StoreTestObjectsFactory methodsFor: 'ISBN' stamp: 'gc 11/7/2019 20:34:45'!
validEditorialISBN
	^ '978-3-16-148410-0'! !


!StoreTestObjectsFactory methodsFor: 'user and password' stamp: 'gc 11/7/2019 19:47:00'!
defaultUserList
	
	^ Dictionary new
		at: self userOfTheStore put: self passwordOfUserOfTheStore;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'user and password' stamp: 'gc 11/7/2019 19:48:10'!
invalidPasswordOfUserOfTheStore
	^'an invalid password'! !

!StoreTestObjectsFactory methodsFor: 'user and password' stamp: 'gc 11/7/2019 19:47:57'!
invalidUserOfTheStore
	^'an invalid user'! !

!StoreTestObjectsFactory methodsFor: 'user and password' stamp: 'gc 11/7/2019 19:47:37'!
passwordOfUserOfTheStore
	^'a valid password'! !

!StoreTestObjectsFactory methodsFor: 'user and password' stamp: 'gc 11/7/2019 19:47:17'!
userOfTheStore
	^'a valid user'! !


!StoreTestObjectsFactory methodsFor: 'catalog' stamp: 'gc 11/17/2019 16:05:58'!
defaultBookCatalog
	
	^ Dictionary new
		at: self validEditorialISBN put: self itemSellByTheStorePrice;
		at: self anotherValidEditorialISBN put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'catalog' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !
