!classDefinition: #CoffeeShopTest category: #'IngSof1-2019-2C-1Parcial'!
TestCase subclass: #CoffeeShopTest
	instanceVariableNames: 'billGates adaLovelace alanKay salesSystem combo1 combo2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopTest methodsFor: 'setUp/tearDown' stamp: 'gez 9/23/2019 19:08:11'!
setUp

	adaLovelace := CoffeeShopGoldCustomer named: 'Ada Lovelace'.
	alanKay := CoffeeShopSilverCustomer named: 'Alan Kay'.
	billGates := CoffeeShopNormalCustomer named: 'Bill Gates'.
	combo1 := Combo1 new.
	combo2 := Combo2 new.! !


!CoffeeShopTest methodsFor: 'test objects' stamp: 'gez 9/23/2019 19:07:43'!
combo1

	^combo1! !

!CoffeeShopTest methodsFor: 'test objects' stamp: 'gez 9/23/2019 19:07:50'!
combo2

	^combo2! !


!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'HAW 9/22/2019 21:41:51'!
test01ThereAreNoSalesWhenSalesSystemIsCreated

	salesSystem := CoffeeShopSalesSystem new.

	self assert: (salesSystem salesMadeTo: adaLovelace) isEmpty! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'gez 9/23/2019 17:21:37'!
test02CanQuerySalesByCustomer

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	
	self assertSaleOf: self combo1 wasRegisteredOn: salesSystem to: adaLovelace .! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'gez 9/23/2019 17:22:43'!
test03SalesAreDistinguishedByCustomer

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo2.
	
	self assertSaleOf: self combo1 wasRegisteredOn: salesSystem to: adaLovelace .
	self assertSaleOf: self combo2 wasRegisteredOn: salesSystem to: alanKay .! !


!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:41:51'!
test04VolumeSoldToCustomerIsZeroWhenCustomerHasNoSaleRegistered

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 0*milliliter equals: volumeSoldToCustomer! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:46:19'!
test05VolumeIs_250_WhenOnlyCombo1WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 250*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:46:07'!
test06VolumeIs_100_WhenOnlyCombo2WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 100*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:46:41'!
test07VolumeSoldToCustomerIsTheSumOfAllSoldProducts

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: (250*milliliter)+(100*milliliter) equals: volumeSoldToCustomer ! !


!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:48:39'!
test08NoRewardExpectedWhenCustomerHasNotBuyAnything

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem rewardOf: adaLovelace ifNone: [ ^self ].
	
	self failWith: 'No reward expected when customer has not buy anything'! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'gez 9/23/2019 19:38:51'!
test09GoldCustomerGetsRewardedWithOneCombo2With50PercentItsPriceWhenRule1Holds

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerMultipleSalesTo: adaLovelace of: (OrderedCollection with: self combo1 with: self combo2) .

	self assertCombo2RewardOf: 60*peso on: salesSystem wasMadeTo: adaLovelace .! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'gez 9/23/2019 19:39:01'!
test10SilverCustomerGetsRewardedWithOneCombo2With75PercentItsPriceWhenRule1Holds

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerMultipleSalesTo: alanKay of: (OrderedCollection with: self combo1 with: self combo2) .

	self assertCombo2RewardOf: 120*3/4*peso on: salesSystem wasMadeTo: alanKay .! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'gez 9/23/2019 19:38:34'!
test11NormalCustomerGetsRewardedWithOneCombo2With90PercentItsPriceWhenRule1Holds

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerMultipleSalesTo: billGates of: (OrderedCollection with: self combo1 with: self combo2) .

	self assertCombo2RewardOf:  120*9/10*peso on: salesSystem  wasMadeTo: billGates .! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'gez 9/23/2019 19:42:08'!
test12GoldCustomerGetsRewardedWithOneCombo1At75PesosWhenRule2Holds

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerMultipleSalesTo: adaLovelace of: (OrderedCollection with: self combo1 with: self combo1 with: self combo2 ) .
	
	self assertCombo1RewardOf:  75*peso on: salesSystem  wasMadeTo: adaLovelace .! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'gez 9/23/2019 19:41:41'!
test13SilverCustomerGetsRewardedWithOneCombo1At83PesosWhenRule2Holds

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerMultipleSalesTo: alanKay of: (OrderedCollection with: self combo1 with: self combo1 with: self combo2 ) .

	self assertCombo1RewardOf:  83*peso on: salesSystem  wasMadeTo: alanKay .! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'gez 9/23/2019 19:41:55'!
test14NormalCustomerGetsRewardedWithOneCombo1At97PesosWhenRule2Holds

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerMultipleSalesTo: billGates of: (OrderedCollection with: self combo1 with: self combo1 with: self combo2 ) .
	
	self assertCombo1RewardOf:  97*peso on: salesSystem  wasMadeTo: billGates .! !


!CoffeeShopTest methodsFor: 'assertions' stamp: 'gez 9/23/2019 17:36:04'!
assertCombo1RewardOf: aPrice on: aSalesSystem wasMadeTo: aCustomer
	| aCustomerReward |

	aCustomerReward := aSalesSystem rewardOf: aCustomer ifNone: [ self fail ].

	self assert: 2 equals: aCustomerReward quantity.
	self assert: aCustomerReward isForCombo1.
	self assert: aPrice equals: aCustomerReward price.
! !

!CoffeeShopTest methodsFor: 'assertions' stamp: 'gez 9/23/2019 17:33:22'!
assertCombo2RewardOf: aPrice on: aSalesSystem wasMadeTo: aCustomer
	| aCustomerReward |

	aCustomerReward := aSalesSystem rewardOf: aCustomer ifNone: [ self fail ].

	self assert: 1 equals: aCustomerReward quantity.
	self assert: aCustomerReward isForCombo2.
	self assert: aPrice equals: aCustomerReward price.
! !

!CoffeeShopTest methodsFor: 'assertions' stamp: 'gez 9/23/2019 17:24:05'!
assertSaleOf: someProduct wasRegisteredOn: aSalesSystem to: aCustomer
	| salesToCustomer |

	salesToCustomer := aSalesSystem salesMadeTo: aCustomer .
	self assert: 1 equals: salesToCustomer size.
	self assert: 1 equals: (salesToCustomer count: [ :aProduct | aProduct = someProduct ])! !


!classDefinition: #CoffeeShopCustomer category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopCustomer
	instanceVariableNames: 'name type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!


!CoffeeShopCustomer methodsFor: 'initialization' stamp: 'gez 9/23/2019 18:26:01'!
initializeNamed: aName
	name := aName ! !


!CoffeeShopCustomer methodsFor: 'printing' stamp: 'HAW 9/22/2019 18:57:07'!
printOn: aStream

	aStream
		nextPutAll: 'Customer named ';
		nextPutAll: name! !


!CoffeeShopCustomer methodsFor: 'reward' stamp: 'gez 9/23/2019 18:26:51'!
getRewardPriceFor: aRewardRule
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopCustomer class' category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomer class
	instanceVariableNames: ''!

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'gez 9/23/2019 18:37:41'!
named: aName 

	^self new initializeNamed: aName! !


!classDefinition: #CoffeeShopGoldCustomer category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomer subclass: #CoffeeShopGoldCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopGoldCustomer methodsFor: 'reward' stamp: 'gez 9/23/2019 18:27:38'!
getRewardPriceFor: aRewardRule
	
	^aRewardRule getPriceForGoldCustomer	! !


!classDefinition: #CoffeeShopNormalCustomer category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomer subclass: #CoffeeShopNormalCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopNormalCustomer methodsFor: 'reward' stamp: 'gez 9/23/2019 18:28:04'!
getRewardPriceFor: aRewardRule
	
	^aRewardRule getPriceForNormalCustomer! !


!classDefinition: #CoffeeShopSilverCustomer category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomer subclass: #CoffeeShopSilverCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopSilverCustomer methodsFor: 'reward' stamp: 'gez 9/23/2019 18:28:13'!
getRewardPriceFor: aRewardRule
	
	^aRewardRule getPriceForSilverCustomer! !


!classDefinition: #CoffeeShopProduct category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopProduct
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopProduct methodsFor: 'product volume' stamp: 'gez 9/23/2019 19:19:07'!
volume
	^self subclassResponsibility ! !


!CoffeeShopProduct methodsFor: 'testing' stamp: 'gez 9/23/2019 19:44:55'!
isCombo1
	^self subclassResponsibility ! !

!CoffeeShopProduct methodsFor: 'testing' stamp: 'gez 9/23/2019 19:45:45'!
isCombo2
	^self subclassResponsibility ! !


!CoffeeShopProduct methodsFor: 'product price' stamp: 'gez 9/23/2019 19:18:31'!
price
	^self subclassResponsibility ! !


!classDefinition: #Combo1 category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopProduct subclass: #Combo1
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!Combo1 methodsFor: 'product volume' stamp: 'gez 9/23/2019 19:19:44'!
volume
	^250*milliliter ! !


!Combo1 methodsFor: 'testing' stamp: 'gez 9/23/2019 19:44:55'!
isCombo1
	^true! !

!Combo1 methodsFor: 'testing' stamp: 'gez 9/23/2019 19:45:45'!
isCombo2
	^false! !


!Combo1 methodsFor: 'product price' stamp: 'gez 9/23/2019 19:21:30'!
price
	^150 * peso! !


!classDefinition: #Combo2 category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopProduct subclass: #Combo2
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!Combo2 methodsFor: 'product volume' stamp: 'gez 9/23/2019 19:20:13'!
volume
	^100*milliliter ! !


!Combo2 methodsFor: 'testing' stamp: 'gez 9/23/2019 19:44:55'!
isCombo1
	^false! !

!Combo2 methodsFor: 'testing' stamp: 'gez 9/23/2019 19:45:45'!
isCombo2
	^true! !


!Combo2 methodsFor: 'product price' stamp: 'gez 9/23/2019 19:21:40'!
price
	^120 * peso! !


!classDefinition: #CoffeeShopReward category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopReward
	instanceVariableNames: 'price quantity product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopReward methodsFor: 'accessing' stamp: 'HAW 9/20/2019 17:54:42'!
price

	^price! !

!CoffeeShopReward methodsFor: 'accessing' stamp: 'HAW 9/21/2019 16:31:13'!
quantity

	^quantity ! !


!CoffeeShopReward methodsFor: 'initialization' stamp: 'HAW 9/22/2019 19:08:08'!
initializeOf: aProduct at: aPrice quantity: aQuantity

	product := aProduct.
	price := aPrice.
	quantity := aQuantity
	! !


!CoffeeShopReward methodsFor: 'testing' stamp: 'gez 9/23/2019 19:44:24'!
isForCombo1
	
	^product isCombo1! !

!CoffeeShopReward methodsFor: 'testing' stamp: 'gez 9/23/2019 19:44:15'!
isForCombo2
	
	^product isCombo2 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopReward class' category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopReward class
	instanceVariableNames: ''!

!CoffeeShopReward class methodsFor: 'instance creation' stamp: 'HAW 9/20/2019 17:53:14'!
of: aComboType at: aPrice quantity: aQuantity

	^self new initializeOf: aComboType at: aPrice quantity: aQuantity
! !


!classDefinition: #CoffeeShopSalesSystem category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopSalesSystem
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopSalesSystem methodsFor: 'product volume' stamp: 'gez 9/23/2019 19:23:42'!
volumeOf: aProduct

	^aProduct volume 
	! !


!CoffeeShopSalesSystem methodsFor: 'initialization' stamp: 'HAW 9/20/2019 17:17:34'!
initialize

	sales := Dictionary new! !


!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'gez 9/23/2019 19:50:28'!
registerMultipleSalesTo: aCustomer of: aProductsList

	| salesToCustomer |

	salesToCustomer := sales at: aCustomer ifAbsentPut: [ OrderedCollection new ].
	salesToCustomer addAll: aProductsList ! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'gez 9/23/2019 19:08:51'!
registerSaleTo: aCustomer of: aProduct

	| salesToCustomer |

	salesToCustomer := sales at: aCustomer ifAbsentPut: [ OrderedCollection new ].
	salesToCustomer add: aProduct! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'HAW 9/20/2019 17:24:49'!
salesMadeTo: aCustomer

	^sales at: aCustomer ifAbsent: [ #() ]! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'HAW 9/22/2019 19:51:19'!
volumeSoldTo: aCustomer

	 ^(self salesMadeTo: aCustomer) sum: [ :aProduct | self volumeOf: aProduct ] ifEmpty: [ 0*milliliter ]! !


!CoffeeShopSalesSystem methodsFor: 'rewarding' stamp: 'HAW 9/22/2019 19:53:42'!
rewardOf: aCustomer ifNone: noneBlock 

	| salesToCustomer volumeSoldToCustomer rewardRule |

	salesToCustomer := self salesMadeTo: aCustomer.
	volumeSoldToCustomer := self volumeSoldTo: aCustomer.
	
	rewardRule := RewardRule for: volumeSoldToCustomer ifNone: [^noneBlock value].
	^rewardRule createRewardFor: aCustomer.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopSalesSystem class' category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopSalesSystem class
	instanceVariableNames: ''!

!CoffeeShopSalesSystem class methodsFor: 'initialization' stamp: 'HAW 9/23/2019 08:50:03'!
initialize

	Smalltalk at: #milliliter put: (BaseUnit named: 'milliliter')! !


!classDefinition: #RewardRule category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #RewardRule
	instanceVariableNames: 'product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 19:03:50'!
createRewardFor: aCustomer 
	
	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:51:26'!
productQuantity

	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:51:33'!
rewardedProduct

	self subclassResponsibility ! !


!RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:28:56'!
getPriceForGoldCustomer
	^self subclassResponsibility ! !

!RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:29:00'!
getPriceForNormalCustomer
	^self subclassResponsibility ! !

!RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:28:49'!
getPriceForSilverCustomer
	^self subclassResponsibility ! !

!RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 19:24:00'!
priceOf: aProduct

	^aProduct price! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RewardRule class' category: #'IngSof1-2019-2C-1Parcial'!
RewardRule class
	instanceVariableNames: ''!

!RewardRule class methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:53:22'!
isFor: volumeSoldToCustomer 
		
	self subclassResponsibility ! !


!RewardRule class methodsFor: 'instance creation' stamp: 'HAW 9/22/2019 19:53:42'!
for: volumeSoldToCustomer ifNone: aNoneBlock

	^self subclasses 
		detect: [ :aRuleClass | aRuleClass isFor: volumeSoldToCustomer ] 
		ifFound: [ :aRuleClass | aRuleClass new ]
		ifNone: aNoneBlock ! !


!classDefinition: #Combo1RewardRule category: #'IngSof1-2019-2C-1Parcial'!
RewardRule subclass: #Combo1RewardRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'gez 9/23/2019 18:39:23'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	
	price := aCustomer getRewardPriceFor: self.
	
	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 19:54:35'!
productQuantity
	
	^2! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'gez 9/23/2019 19:10:49'!
rewardedProduct
	
	^Combo1 new! !


!Combo1RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:30:23'!
getPriceForGoldCustomer
	^ 75*peso! !

!Combo1RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:30:54'!
getPriceForNormalCustomer
	^ 97*peso! !

!Combo1RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:29:56'!
getPriceForSilverCustomer
	^ 83*peso ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo1RewardRule class' category: #'IngSof1-2019-2C-1Parcial'!
Combo1RewardRule class
	instanceVariableNames: ''!

!Combo1RewardRule class methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer > (500*milliliter)! !


!classDefinition: #Combo2RewardRule category: #'IngSof1-2019-2C-1Parcial'!
RewardRule subclass: #Combo2RewardRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'gez 9/23/2019 18:39:43'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	
	price := aCustomer getRewardPriceFor: self.

	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:23:07'!
productQuantity

	^1! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'gez 9/23/2019 19:10:41'!
rewardedProduct
	
	^Combo2 new! !


!Combo2RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:32:55'!
getPriceForGoldCustomer

	^ (self priceOf: product)/2! !

!Combo2RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:34:39'!
getPriceForNormalCustomer

	^ (self priceOf: product)*9/10 ! !

!Combo2RewardRule methodsFor: 'product price' stamp: 'gez 9/23/2019 18:34:24'!
getPriceForSilverCustomer

	^ (self priceOf: product)*3/4! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo2RewardRule class' category: #'IngSof1-2019-2C-1Parcial'!
Combo2RewardRule class
	instanceVariableNames: ''!

!Combo2RewardRule class methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer between: 300*milliliter and: 500*milliliter
	! !

CoffeeShopSalesSystem initialize!