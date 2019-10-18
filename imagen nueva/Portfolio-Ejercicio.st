!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 19:18:09'!
test08newPortfolioShouldBeEmpty

	| portfolio |
	
	portfolio _ Portfolio create.
	self assert: portfolio isEmpty.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 19:18:17'!
test09EmptyPortfolioShouldHaveNoTransactions

	| portfolio |
	
	portfolio _ Portfolio create.
	self assert: ((portfolio transactions) size) equals: 0.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 19:18:23'!
test10addOneAccountToPortfolio

	| portfolio account |
	
	portfolio _ Portfolio create.
	account := ReceptiveAccount new.
	portfolio addAccount: account.
	
	self assert: (portfolio contains: account ).
	self deny: portfolio isEmpty .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 19:53:48'!
test11addOneAccountWithOneTransactionToPortfolioShouldMakeBothTransactionsEqual
	| portfolio account |
	
	portfolio _ Portfolio create.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio addAccount: account.
	
	self assert: (portfolio contains: account ).
	self assert: (portfolio transactions) equals: (account transactions).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:30:09'!
test12addOneAccountToPortfolioAndShouldHaveNoTransactionsRegistered
	| portfolio account deposit |
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.
	deposit _  Deposit for: 100.
	
	portfolio addAccount: account.
	
	self assert: (portfolio contains: account ).
	self deny: (portfolio hasRegistered: deposit )! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:31:26'!
test13addOneAccountWithOneTransactionToPortfolioAndTransactionIsRegistered
	| portfolio account deposit |
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.
	
	deposit _ Deposit register: 100 on: account.
	
	portfolio addAccount: account.
	
	self assert: (portfolio contains: account ).
	self assert: (portfolio hasRegistered: deposit )! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:32:29'!
test14MakingTransactionInAccountInPortfolioShouldMakeBothTransactionsEqual
	| portfolio account deposit |
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.

	portfolio addAccount: account.
	
	deposit _ Deposit register: 100 on: account.
	
	self assert: (portfolio contains: account ).
	self assert: (portfolio transactions) equals: (account transactions).
	self assert: (portfolio hasRegistered: deposit ).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:33:40'!
test15AddAccountWithMultipleTransactionsToPortfolioShouldMakeBothTransactionsEqual
	| portfolio account withdraw deposit|
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.
	
	Deposit register: 200 on: account.
	withdraw _ Withdraw register: 50 on: account.
	Deposit register: 20 on: account.
	
	portfolio addAccount: account.
	
	Withdraw register: 150 on: account.
	deposit _ Deposit register: 80 on: account.
	Withdraw register: 30 on: account.
	
	self assert: (portfolio contains: account ).
	self assert: (portfolio transactions) equals: (account transactions).
	self assert: (portfolio hasRegistered: withdraw ).
	self assert: (portfolio hasRegistered: deposit ).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 21:07:14'!
test16AddMultipleAccountsWithMultipleTransactionsToPortfolioShouldMakeTransactionsEqual
	| portfolio account1 account2 account3 expectedAnswer |
	
	portfolio _ Portfolio create.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 20 on: account1.
	
	portfolio addAccount: account1.
	
	Withdraw register: 150 on: account2.
	Deposit register: 80 on: account2.
	Withdraw register: 30 on: account2.
	
	portfolio addAccount: account2.
	
	Withdraw register: 150 on: account3.
	Deposit register: 80 on: account3.
	Withdraw register: 30 on: account3.
	
	portfolio addAccount: account3.
	
	expectedAnswer _ Bag new.
	expectedAnswer addAll: account1 transactions.
	expectedAnswer addAll: account2 transactions.
	expectedAnswer addAll: account3 transactions.
	
	self assert: ((portfolio transactions) asBag) equals: expectedAnswer .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:02:59'!
test17EmptyPortfolioBalanceShouldBeZero
	| portfolio  |
	
	portfolio _ Portfolio create.
	
	self assert: (portfolio balance) equals: 0.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:04:39'!
test18PortfolioWithOneAccountShouldMakeBothBalancesEqual
	| portfolio account |
	
	portfolio _ Portfolio create.
	
	account := ReceptiveAccount new.
	
	Deposit register: 200 on: account.
	Withdraw register: 50 on: account.
	Deposit register: 20 on: account.
	
	portfolio addAccount: account.
	
	self assert: (portfolio balance) equals: (account balance).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:16:09'!
test19PortfolioWithManyAccountsShouldMakeBothBalancesEqual
	| portfolio account1 account2 account3 |
	
	portfolio _ Portfolio create.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 20 on: account1.
	
	portfolio addAccount: account1.
	
	Withdraw register: 150 on: account2.
	Deposit register: 80 on: account2.
	Withdraw register: 30 on: account2.
	
	portfolio addAccount: account2.
	
	Withdraw register: 150 on: account3.
	Deposit register: 80 on: account3.
	Withdraw register: 30 on: account3.
	
	portfolio addAccount: account3.
	
	self assert: (portfolio balance) equals: ((account1 balance)+(account2 balance)+(account3 balance)).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:13:50'!
test20AddEmptyPortfolioToEmptyPortfolioShouldntBeEmpty
	| portfolio1 portfolio2|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	
	portfolio1 addPortfolio: portfolio2 .
	
	self deny: (portfolio1 isEmpty ).
	self assert: (portfolio2 isEmpty ).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:20:02'!
test21PortfolioWithEmptyPortfolioBalanceShouldBeZero
	| portfolio1 portfolio2|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	
	portfolio1 addPortfolio: portfolio2 .
	
	self assert: (portfolio1 balance) equals: 0.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:40:40'!
test22PortfolioWithEmptyPortfolioHasNoTransactions
	| portfolio1 portfolio2|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	
	portfolio1 addPortfolio: portfolio2 .
	
	self assert: (portfolio1 transactions isEmpty) .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:40:52'!
test23PortfolioWithEmptyPortfolioHasNotRegisteredTransactions
	| portfolio1 portfolio2 deposit withdraw|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	deposit _  Deposit for: 100.
	withdraw _ Withdraw for: 100.
	
	portfolio1 addPortfolio: portfolio2 .
	
	self deny: (portfolio1 hasRegistered: deposit ) .
	self deny: (portfolio1 hasRegistered: withdraw ) .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 20:44:17'!
test24PortfolioWithAccountsWithTransactionsBalanceIsCorrect
	| portfolio1 portfolio2 account1 account2 account3|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio1 addPortfolio: portfolio2 .
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 20 on: account1.
	
	portfolio1 addAccount: account1.
	
	Withdraw register: 150 on: account2.
	Deposit register: 80 on: account2.
	Withdraw register: 30 on: account2.
	
	portfolio2 addAccount: account2.
	
	Withdraw register: 150 on: account3.
	Deposit register: 80 on: account3.
	Withdraw register: 30 on: account3.
	
	portfolio2 addAccount: account3.
	
	self assert: (portfolio1 balance) equals: ((account1 balance)+(account2 balance)+(account3 balance)).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 21:06:57'!
test25PortfolioWithAccountsWithLittleTransactionsTransactionsAreCorrect
	| portfolio1 portfolio2 account1 account2 expectedAnswer|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio1 addPortfolio: portfolio2 .
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	
	Deposit register: 200 on: account1.
	
	portfolio1 addAccount: account1.
	
	Withdraw register: 150 on: account2.
	
	portfolio2 addAccount: account2.
	expectedAnswer _ Bag new.
	expectedAnswer addAll: (account1 transactions ).
	expectedAnswer addAll: (account2 transactions ).

	self assert: ((portfolio1 transactions) asBag) equals: expectedAnswer.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/17/2019 21:09:18'!
test26PortfolioWithAccountsWithTransactionsTransactionsAreCorrect
	| portfolio1 portfolio2 account1 account2 account3 expectedAnswer |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio1 addPortfolio: portfolio2 .
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 20 on: account1.
	
	portfolio1 addAccount: account1.
	
	Withdraw register: 150 on: account2.
	Deposit register: 80 on: account2.
	Withdraw register: 30 on: account2.
	
	portfolio2 addAccount: account2.
	
	Withdraw register: 150 on: account3.
	Deposit register: 80 on: account3.
	Withdraw register: 30 on: account3.
	
	portfolio2 addAccount: account3.
	
	expectedAnswer _ Bag new.
	expectedAnswer addAll: (account1 transactions).
	expectedAnswer addAll: (account2 transactions).
	expectedAnswer addAll: (account3 transactions).
	
	self assert: (portfolio1 transactions) asBag equals: expectedAnswer .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/18/2019 16:14:46'!
test27CanAddAccountToTwoPortfoliosWithoutCommonParent
	| portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	portfolio3 _ Portfolio create.

	portfolio1 addPortfolio: portfolio2.
	portfolio3 addPortfolio: portfolio2 .
	
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account .
	portfolio3 addAccount: account .
	
	self assert: (portfolio1 contains: account ).
	self assert: (portfolio3 contains: account ).
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/18/2019 16:18:10'!
test28AddingPortfolioToPortfolioUpdatesParents
	| portfolio1 portfolio2 |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio1 addPortfolio: portfolio2.
	
	self assert: (portfolio1 contains: portfolio2 ).
	self assert: (portfolio2 parents size = 1 ).
	self assert: (portfolio2 parents includes: portfolio1 ).

	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/18/2019 16:38:15'!
test29CantAddAccountToPortfolioIfParentContainsIt
	| portfolio1 portfolio2  account |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio1 addPortfolio: portfolio2.
	
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account .

	self should: [portfolio2 addAccount: account .] 
	raise: Error 
	withMessageText: Portfolio accountAlreadyInTree .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/18/2019 17:08:57'!
test30CantAddPortfolioToPortfolioIfOneOfItsAccountsIsInTree
	| portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	portfolio3 _ Portfolio create.
	account _ ReceptiveAccount new.

	portfolio2 addPortfolio: portfolio3 .
	
	portfolio1 addAccount: account .
	portfolio2 addAccount: account .
	
	self should: [portfolio3 addPortfolio: portfolio1 .] 
	raise: Error 
	withMessageText: Portfolio portfolioWithAccountAlreadyInTree .
	
	
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'gc 10/18/2019 17:18:46'!
test31CantAddAccountToSamePortfolioTwice
	| portfolio account |
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.

	portfolio addAccount: account .
	
	self should: [portfolio addAccount: account .] 
	raise: Error 
	withMessageText: Portfolio accountAlreadyInPortfolio .
	
	
	! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'gc 10/17/2019 18:55:38'!
worth 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'gc 10/17/2019 18:55:29'!
worth

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'gc 10/17/2019 18:55:16'!
worth

	^-1*  value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Bank category: #'Portfolio-Ejercicio'!
Object subclass: #Bank
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Bank methodsFor: 'as yet unclassified' stamp: 'gc 10/17/2019 21:29:57'!
addAccount: aReceptiveAccount 
	^self subclassResponsibility ! !

!Bank methodsFor: 'as yet unclassified' stamp: 'gc 10/17/2019 21:30:04'!
addPortfolio: aPortfolio 
	^self subclassResponsibility ! !

!Bank methodsFor: 'as yet unclassified' stamp: 'gc 10/17/2019 21:30:11'!
initialize
	^self subclassResponsibility ! !

!Bank methodsFor: 'as yet unclassified' stamp: 'gc 10/17/2019 21:30:16'!
isEmpty
	^self subclassResponsibility ! !


!Bank methodsFor: 'observer' stamp: 'gc 10/17/2019 21:30:22'!
balance
	^self subclassResponsibility ! !

!Bank methodsFor: 'observer' stamp: 'gc 10/17/2019 21:30:27'!
contains: aReceptiveAccount 
	^self subclassResponsibility ! !

!Bank methodsFor: 'observer' stamp: 'gc 10/17/2019 21:30:32'!
hasRegistered: aTransaction 
	^self subclassResponsibility ! !

!Bank methodsFor: 'observer' stamp: 'gc 10/17/2019 21:30:38'!
transactions
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bank class' category: #'Portfolio-Ejercicio'!
Bank class
	instanceVariableNames: ''!

!Bank class methodsFor: 'as yet unclassified' stamp: 'gc 10/17/2019 21:28:10'!
create
	^Portfolio initialize new! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Bank subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 17:22:31'!
addAccount: aReceptiveAccount 
	(self contains: aReceptiveAccount) ifTrue: [self error: self class accountAlreadyInPortfolio ].
	(parents inject: false into: [:isContained :accountOrPortfolio | isContained or: (accountOrPortfolio hasCommonElementsWith: aReceptiveAccount ).]) ifTrue: [^self error: Portfolio accountAlreadyInTree ].
	accountsAndPortfolios addLast: aReceptiveAccount .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 16:19:01'!
addParent: aPortfolio 
	parents addLast: aPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 17:11:44'!
addPortfolio: aPortfolio 
	(parents inject: false into: [:isContained :accountOrPortfolio | isContained or: (accountOrPortfolio hasCommonElementsWith: aPortfolio ).]) ifTrue: [^self error: Portfolio portfolioWithAccountAlreadyInTree ].
	accountsAndPortfolios addLast: aPortfolio.
	aPortfolio addParent: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 16:18:28'!
initialize
	accountsAndPortfolios _ OrderedCollection new.
	parents _ OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'gc 10/17/2019 20:12:22'!
isEmpty
	^accountsAndPortfolios isEmpty ! !


!Portfolio methodsFor: 'observer' stamp: 'gc 10/17/2019 20:12:22'!
balance
	
	^accountsAndPortfolios inject: 0 into: [:totalBalance :account | totalBalance + (account balance)]! !

!Portfolio methodsFor: 'observer' stamp: 'gc 10/18/2019 17:25:00'!
contains: anAccountOrPortfolio 
	^accountsAndPortfolios inject: false into: [:isContained :accountOrPortfolio | isContained or: [accountOrPortfolio contains: anAccountOrPortfolio ]]! !

!Portfolio methodsFor: 'observer' stamp: 'gc 10/18/2019 17:11:44'!
hasCommonElementsWith: aPortfolioOrAccount 
	^aPortfolioOrAccount isIncludedIn: accountsAndPortfolios.! !

!Portfolio methodsFor: 'observer' stamp: 'gc 10/17/2019 20:37:20'!
hasRegistered: aTransaction 
	^accountsAndPortfolios inject: false into: [:hasRegistered :accountOrPortfolio | hasRegistered or: [accountOrPortfolio hasRegistered: aTransaction]]! !

!Portfolio methodsFor: 'observer' stamp: 'gc 10/18/2019 17:02:38'!
isIncludedIn: aListOfAccountsAndPortfolios 
	^accountsAndPortfolios inject: false into: [:isIncluded :accountOrPortfolio | isIncluded or: [aListOfAccountsAndPortfolios includes: accountOrPortfolio ]]! !

!Portfolio methodsFor: 'observer' stamp: 'gc 10/18/2019 16:17:52'!
parents
	^parents! !

!Portfolio methodsFor: 'observer' stamp: 'gc 10/17/2019 21:02:31'!
transactions
	| transactions |
	transactions _ OrderedCollection  new.
	
	^accountsAndPortfolios inject: transactions into: [:total :account | total addAll: (account transactions). total].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 17:20:11'!
accountAlreadyInPortfolio
	^'Ese portfolio ya tiene esa cuenta'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 16:25:11'!
accountAlreadyInTree
	^'Esa cuenta ya la contiene un portfolio de distinta jerarquia'.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'gc 10/17/2019 19:17:44'!
create
	^Portfolio initialize new! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 16:46:03'!
portfolioWithAccountAlreadyInTree
	^'Ese portfolio tiene una cuenta que ya la contiene un portfolio de distinta jerarquia'.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Bank subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'gc 10/17/2019 18:56:04'!
balance

	^transactions sum: [ :aTransaction | aTransaction worth ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 16:35:39'!
contains: aReceptiveAccount 
	^self == aReceptiveAccount .! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'gc 10/18/2019 17:00:39'!
isIncludedIn: aListOfAccountsAndPortfolios 
	^aListOfAccountsAndPortfolios includes: self .! !
