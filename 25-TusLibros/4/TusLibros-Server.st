!classDefinition: #TusLibrosServerController category: #'TusLibros-Server'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'system webServer port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'NR 6/24/2019 06:51:52'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'NR 11/11/2019 15:54:12'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.
	! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'NR 11/11/2019 15:54:20'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !


!TusLibrosServerController methodsFor: 'initialization' stamp: 'gc 12/1/2019 17:11:33'!
initializeWith: aPortNumber
	
	| aCatalog aClock aMerchantProcessor aSalesBook aValidUsersAndPasswords |
	port := aPortNumber.
	
	aValidUsersAndPasswords _ self usersAndPasswords.
	aCatalog _ self catalog .
	aSalesBook _ OrderedCollection new.
	aMerchantProcessor _ self.
	aClock _ DateAndTime .
	
	system _ TusLibrosSystemFacade authenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	self addServiceCreateCart.
	self addServiceAddToCart.
	self addServiceRemoveFromCart.
	self addServiceListCart.
	self addServiceCheckoutCart.	
	self addServiceListPurchases.
	! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'NR 11/11/2019 17:19:18'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].
	
	! !


!TusLibrosServerController methodsFor: 'private' stamp: 'gc 12/1/2019 15:38:42'!
addServiceAddToCart

	^ webServer addService: '/addToCart' action:[:request | 
		|cartId bookIsbn bookQuantity responseAsJson |
		[
			cartId := (request fields at:'cartId') asInteger .
			bookIsbn := (request fields at:'bookIsbn') .
			bookQuantity := (request fields at:'bookQuantity') asInteger .
			system add: bookQuantity of: bookIsbn toCartIdentifiedAs: cartId .
			request send200Response: ( 'OK' asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]! !

!TusLibrosServerController methodsFor: 'private' stamp: 'gc 12/1/2019 14:24:58'!
addServiceCheckoutCart

	^ webServer addService: '/checkOutCart' action:[:request | 
		| cartId ticket responseAsJson|
		[
			cartId := (request fields at:'cartId') asInteger .
			ticket _ system checkOutCartIdentifiedAs: cartId withCreditCardNumbered: 4111111111111111 ownedBy: 'Pepe' expiringOn: ( Month month: (DateAndTime today) monthIndex year: (DateAndTime today yearNumber + 1)).
			responseAsJson := WebUtils jsonEncode: (ticket asArray ).
			request send200Response: (responseAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]! !

!TusLibrosServerController methodsFor: 'private' stamp: 'gc 12/1/2019 14:23:56'!
addServiceCreateCart

	^ webServer addService: '/createCart' action:[:request | |clientId password responseAsJson cartId |		
		[
		clientId := (request fields at:'clientId').
		password := (request fields at:'password').
		cartId _ system createCartFor: clientId authenticatedWith: password .
		responseAsJson := WebUtils jsonEncode: (cartId).
			request send200Response: (responseAsJson asUtf8) 
			contentType: 'application/json; charset=utf-8' do: [:resp | 
				resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]! !

!TusLibrosServerController methodsFor: 'private' stamp: 'gc 12/1/2019 17:12:46'!
addServiceListCart

	^ webServer addService: '/listCart' action:[:request | 
		| cartId listedCart responseAsJson|
		[
			cartId := (request fields at:'cartId') asInteger .
			listedCart _ system listCartIdentifiedAs: cartId .
			responseAsJson := WebUtils jsonEncode: (listedCart asArray ).
			request send200Response: (responseAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]! !

!TusLibrosServerController methodsFor: 'private' stamp: 'gc 12/1/2019 14:25:16'!
addServiceListPurchases

	^ webServer addService: '/listPurchases' action:[:request | 
		| clientId listedPurchases responseAsJson|
		[
			clientId := (request fields at:'clientId').
			listedPurchases _ system listPurchasesOf: clientId.
			responseAsJson := WebUtils jsonEncode: (listedPurchases ).
			request send200Response: (responseAsJson asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]! !

!TusLibrosServerController methodsFor: 'private' stamp: 'gc 12/1/2019 15:38:48'!
addServiceRemoveFromCart

	^ webServer addService: '/removeFromCart' action:[:request | 
		|cartId bookIsbn responseAsJson |
		[
			cartId := (request fields at:'cartId') asInteger .
			bookIsbn := (request fields at:'bookIsbn') .
			system remove: bookIsbn fromCartIdentifiedAs: cartId .
			request send200Response: ( 'OK' asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]! !


!TusLibrosServerController methodsFor: 'merchant processor protocol' stamp: 'gc 11/30/2019 19:45:13'!
debit: anAmount from: aCard
! !


!TusLibrosServerController methodsFor: 'database' stamp: 'gc 12/1/2019 15:38:31'!
catalog
	^ Dictionary new
		at: '1111' put: 10;
		at: '2222' put: 15;
		at: '3333' put: 50;
		at: '4444' put: 20;
		at: '5555' put: 15;
		yourself ! !

!TusLibrosServerController methodsFor: 'database' stamp: 'gc 12/1/2019 15:28:44'!
usersAndPasswords
	^Dictionary new
		at: 'user1' put: 'pass1';
		at: 'user2' put: 'pass2';
		at: 'user3' put: 'pass3';
		at: 'user4' put: 'pass4';
		at: 'user5' put: 'pass5';
		at: 'user6' put: 'pass6';
		at: 'user7' put: 'pass7';
		yourself! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Server'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'as yet unclassified' stamp: 'NR 11/11/2019 15:43:02'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !
