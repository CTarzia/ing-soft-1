!classDefinition: #AccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #AccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTest methodsFor: 'receptiveAccount balance' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!AccountTest methodsFor: 'receptiveAccount balance' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!AccountTest methodsFor: 'receptiveAccount balance' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !


!AccountTest methodsFor: 'receptiveAccount transaction' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!AccountTest methodsFor: 'receptiveAccount transaction' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!AccountTest methodsFor: 'receptiveAccount transaction' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!AccountTest methodsFor: 'receptiveAccount transaction' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!AccountTest methodsFor: 'basic portfolio' stamp: 'gc 10/17/2019 19:18:09'!
test08newPortfolioShouldBeEmpty

	| portfolio |
	
	portfolio _ Portfolio create.
	self assert: portfolio isEmpty.! !

!AccountTest methodsFor: 'basic portfolio' stamp: 'gc 10/17/2019 19:18:23'!
test10addOneAccountToPortfolio

	| portfolio account |
	
	portfolio _ Portfolio create.
	account := ReceptiveAccount new.
	portfolio addAccount: account.
	
	self assert: (portfolio contains: account ).
	self deny: portfolio isEmpty .! !

!AccountTest methodsFor: 'basic portfolio' stamp: 'gc 10/19/2019 23:29:03'!
test20AddPortfolioToPortfolioShouldntBeEmpty
	| portfolio1 portfolio2|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	
	portfolio1 addPortfolio: portfolio2 .
	
	self deny: (portfolio1 isEmpty ).
	self assert: (portfolio2 isEmpty ).! !

!AccountTest methodsFor: 'basic portfolio' stamp: 'gc 10/17/2019 20:40:52'!
test23PortfolioWithEmptyPortfolioHasNotRegisteredTransactions
	| portfolio1 portfolio2 deposit withdraw|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	deposit _  Deposit for: 100.
	withdraw _ Withdraw for: 100.
	
	portfolio1 addPortfolio: portfolio2 .
	
	self deny: (portfolio1 hasRegistered: deposit ) .
	self deny: (portfolio1 hasRegistered: withdraw ) .! !

!AccountTest methodsFor: 'basic portfolio' stamp: 'gc 10/19/2019 20:54:35'!
test33AccountNotInPortfolioIsntContainedInPortfolio
	| portfolio account1 account2 |
	
	portfolio _ Portfolio create.
	
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	portfolio addAccount: account1.

	self deny: (portfolio contains: account2).! !

!AccountTest methodsFor: 'basic portfolio' stamp: 'gc 10/19/2019 21:00:28'!
test34PortfolioAddedToPortfolioShouldBeContainedInIt
	| portfolio1 portfolio2 |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	
	portfolio1 addPortfolio: portfolio2.

	self assert: (portfolio1 contains: portfolio2 ).! !

!AccountTest methodsFor: 'basic portfolio' stamp: 'gc 10/19/2019 22:28:29'!
test35PortfolioNotInPortfolioIsntContainedInPortfolio
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	portfolio3 _ Portfolio create.
	
	portfolio1 addPortfolio: portfolio2.

	self deny: (portfolio1 contains: portfolio3 ).! !


!AccountTest methodsFor: 'portfolio balance' stamp: 'gc 10/17/2019 20:02:59'!
test17EmptyPortfolioBalanceShouldBeZero
	| portfolio  |
	
	portfolio _ Portfolio create.
	
	self assert: (portfolio balance) equals: 0.
! !

!AccountTest methodsFor: 'portfolio balance' stamp: 'gc 10/17/2019 20:04:39'!
test18PortfolioWithOneAccountShouldMakeBothBalancesEqual
	| portfolio account |
	
	portfolio _ Portfolio create.
	
	account := ReceptiveAccount new.
	
	Deposit register: 200 on: account.
	Withdraw register: 50 on: account.
	Deposit register: 20 on: account.
	
	portfolio addAccount: account.
	
	self assert: (portfolio balance) equals: (account balance).! !

!AccountTest methodsFor: 'portfolio balance' stamp: 'gc 10/17/2019 20:16:09'!
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

!AccountTest methodsFor: 'portfolio balance' stamp: 'gc 10/17/2019 20:20:02'!
test21PortfolioWithEmptyPortfolioBalanceShouldBeZero
	| portfolio1 portfolio2|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	
	portfolio1 addPortfolio: portfolio2 .
	
	self assert: (portfolio1 balance) equals: 0.! !

!AccountTest methodsFor: 'portfolio balance' stamp: 'gc 10/17/2019 20:44:17'!
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


!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 19:18:17'!
test09EmptyPortfolioShouldHaveNoTransactions

	| portfolio |
	
	portfolio _ Portfolio create.
	self assert: ((portfolio transactions) size) equals: 0.! !

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 19:53:48'!
test11addOneAccountWithOneTransactionToPortfolioShouldMakeBothTransactionsEqual
	| portfolio account |
	
	portfolio _ Portfolio create.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio addAccount: account.
	
	self assert: (portfolio contains: account ).
	self assert: (portfolio transactions) equals: (account transactions).! !

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 20:30:09'!
test12addOneAccountToPortfolioAndShouldHaveNoTransactionsRegistered
	| portfolio account deposit |
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.
	deposit _  Deposit for: 100.
	
	portfolio addAccount: account.
	
	self assert: (portfolio contains: account ).
	self deny: (portfolio hasRegistered: deposit )! !

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 20:31:26'!
test13addOneAccountWithOneTransactionToPortfolioAndTransactionIsRegistered
	| portfolio account deposit |
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.
	
	deposit _ Deposit register: 100 on: account.
	
	portfolio addAccount: account.
	
	self assert: (portfolio contains: account ).
	self assert: (portfolio hasRegistered: deposit )! !

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 20:32:29'!
test14MakingTransactionInAccountInPortfolioShouldMakeBothTransactionsEqual
	| portfolio account deposit |
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.

	portfolio addAccount: account.
	
	deposit _ Deposit register: 100 on: account.
	
	self assert: (portfolio contains: account ).
	self assert: (portfolio transactions) equals: (account transactions).
	self assert: (portfolio hasRegistered: deposit ).! !

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 20:33:40'!
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

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 21:07:14'!
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

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 20:40:40'!
test22PortfolioWithEmptyPortfolioHasNoTransactions
	| portfolio1 portfolio2|
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.
	
	portfolio1 addPortfolio: portfolio2 .
	
	self assert: (portfolio1 transactions isEmpty) .! !

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 21:06:57'!
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

!AccountTest methodsFor: 'portfolio transaction' stamp: 'gc 10/17/2019 21:09:18'!
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


!AccountTest methodsFor: 'portfolio add' stamp: 'gc 10/18/2019 16:14:46'!
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

!AccountTest methodsFor: 'portfolio add' stamp: 'gc 10/18/2019 16:18:10'!
test28AddingPortfolioToPortfolioUpdatesParents
	| portfolio1 portfolio2 |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio1 addPortfolio: portfolio2.
	
	self assert: (portfolio1 contains: portfolio2 ).
	self assert: (portfolio2 parents size = 1 ).
	self assert: (portfolio2 parents includes: portfolio1 ).

	
	! !

!AccountTest methodsFor: 'portfolio add' stamp: 'gc 10/19/2019 21:53:13'!
test29CantAddAccountToPortfolioIfParentContainsIt
	| portfolio1 portfolio2  account |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio1 addPortfolio: portfolio2.
	
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account .

	self should: [portfolio2 addAccount: account .] 
	raise: Error 
	withMessageText: Account accountCantBeAdded .! !

!AccountTest methodsFor: 'portfolio add' stamp: 'gc 10/19/2019 21:53:24'!
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
	withMessageText: Account accountCantBeAdded .
	
	
	! !

!AccountTest methodsFor: 'portfolio add' stamp: 'gc 10/19/2019 21:53:38'!
test31CantAddAccountToSamePortfolioTwice
	| portfolio account |
	
	portfolio _ Portfolio create.
	account _ ReceptiveAccount new.

	portfolio addAccount: account .
	
	self should: [portfolio addAccount: account .] 
	raise: Error 
	withMessageText: Account accountCantBeAdded .
	
	
	! !

!AccountTest methodsFor: 'portfolio add' stamp: 'gc 10/19/2019 21:53:45'!
test32CantAddAccountToPortfolioIfChildContainsIt
	| portfolio1 portfolio2  account |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio2 addPortfolio: portfolio1.
	
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account .

	self should: [portfolio2 addAccount: account .] 
	raise: Error 
	withMessageText: Account accountCantBeAdded .! !

!AccountTest methodsFor: 'portfolio add' stamp: 'gc 10/19/2019 22:49:39'!
test36CantAddAccountToPortfolioIfParentContainsIt
	| portfolio1 portfolio2  account |
	
	portfolio1 _ Portfolio create.
	portfolio2 _ Portfolio create.

	portfolio2 addPortfolio: portfolio1.
	
	account := ReceptiveAccount new.
	
	portfolio2 addAccount: account .

	self should: [portfolio1 addAccount: account .] 
	raise: Error 
	withMessageText: Account accountCantBeAdded .! !

!AccountTest methodsFor: 'portfolio add' stamp: 'gc 10/19/2019 22:52:37'!
test37CantAddPortfolioToSelf
	| portfolio |
	
	portfolio _ Portfolio create.

	self should: [portfolio addPortfolio: portfolio.] 
	raise: Error 
	withMessageText: Account accountCantBeAdded .! !


!classDefinition: #Account category: #'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'initialization' stamp: 'gc 10/17/2019 21:30:11'!
initialize
	^self subclassResponsibility ! !


!Account methodsFor: 'testing' stamp: 'gc 10/17/2019 21:30:32'!
hasRegistered: aTransaction 
	^self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'gc 10/17/2019 21:30:16'!
isEmpty
	^self subclassResponsibility ! !


!Account methodsFor: 'add' stamp: 'gc 10/19/2019 23:13:53'!
addAccount: aReceptiveAccount  
	^self subclassResponsibility ! !

!Account methodsFor: 'add' stamp: 'gc 10/19/2019 23:12:36'!
addParent: aPortfolio 
	^self subclassResponsibility ! !

!Account methodsFor: 'add' stamp: 'gc 10/17/2019 21:30:04'!
addPortfolio: aPortfolio 
	^self subclassResponsibility ! !


!Account methodsFor: 'verification' stamp: 'gc 10/19/2019 23:13:11'!
accountAlreadyInTree: anAccount 
	^self subclassResponsibility ! !

!Account methodsFor: 'verification' stamp: 'gc 10/19/2019 23:14:14'!
accountsInTree
	^self subclassResponsibility ! !

!Account methodsFor: 'verification' stamp: 'gc 10/19/2019 23:14:29'!
assertCanBeAdded: anAccount 
	^self subclassResponsibility ! !

!Account methodsFor: 'verification' stamp: 'gc 10/19/2019 23:14:37'!
contains: anAccount  
	^self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'gc 10/17/2019 21:30:22'!
balance
	^self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'gc 10/19/2019 23:15:56'!
register: aTransaction
	^self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'gc 10/17/2019 21:30:38'!
transactions
	^self subclassResponsibility ! !


!Account methodsFor: 'get' stamp: 'gc 10/19/2019 23:15:12'!
accounts
	^self subclassResponsibility ! !

!Account methodsFor: 'get' stamp: 'gc 10/19/2019 23:15:16'!
parents
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #'Portfolio-Ejercicio'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'gc 10/19/2019 21:52:39'!
create
	^self subclassResponsibility ! !


!Account class methodsFor: 'error message' stamp: 'gc 10/19/2019 22:55:29'!
accountCantBeAdded
	^'Esa cuenta esta repetida en la jerarquia y no se puede agregar'.! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'parents accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'gc 10/19/2019 21:40:25'!
initialize
	accounts _ OrderedCollection new.
	parents _ OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'gc 10/19/2019 22:11:24'!
hasRegistered: aTransaction 
	^accounts anySatisfy: [:accountOrPortfolio | accountOrPortfolio hasRegistered: aTransaction]! !

!Portfolio methodsFor: 'testing' stamp: 'gc 10/19/2019 21:40:39'!
isEmpty
	^accounts isEmpty ! !


!Portfolio methodsFor: 'add' stamp: 'gc 10/19/2019 21:44:00'!
addAccount: aReceptiveAccount 
	self assertCanBeAdded: aReceptiveAccount .
	"
	(self contains: aReceptiveAccount) ifTrue: [self error: self class accountAlreadyInPortfolio ].
	(parents inject: false into: [:isContained :accountOrPortfolio | isContained or: (accountOrPortfolio hasCommonElementsWith: aReceptiveAccount ).]) ifTrue: [^self error: Portfolio accountAlreadyInTree ].
	"
	accounts addLast: aReceptiveAccount .! !

!Portfolio methodsFor: 'add' stamp: 'gc 10/18/2019 16:19:01'!
addParent: aPortfolio 
	parents addLast: aPortfolio.! !

!Portfolio methodsFor: 'add' stamp: 'gc 10/19/2019 22:10:10'!
addPortfolio: aPortfolio 
	"
	(parents inject: false into: [:isContained :accountOrPortfolio | isContained or: (accountOrPortfolio hasCommonElementsWith: aPortfolio ).]) ifTrue: [^self error: Account accountCantBeAdded ].
	"
	self assertCanBeAdded: aPortfolio .
	accounts addLast: aPortfolio.
	aPortfolio addParent: self.! !


!Portfolio methodsFor: 'verification' stamp: 'gc 10/19/2019 22:03:37'!
accountAlreadyInTree: anAccount 
	| accountsInTree |
	
	accountsInTree _ self accountsInTree.
	
	^accountsInTree anySatisfy: [:anAccountInHierarchy | anAccountInHierarchy contains: anAccount ]! !

!Portfolio methodsFor: 'verification' stamp: 'gc 10/19/2019 22:33:37'!
accountsInTree
	| accountsInTree |
	
	accountsInTree _ Set new.
	parents do: [:aParent | 
		accountsInTree addAll: (aParent accountsInTree ). 
		accountsInTree add: aParent 
		].
	accountsInTree add: self.
	^accountsInTree ! !

!Portfolio methodsFor: 'verification' stamp: 'gc 10/19/2019 21:54:25'!
assertCanBeAdded: anAccount 
	(self accountAlreadyInTree: anAccount ) ifTrue: [^self error: Account accountCantBeAdded ]! !

!Portfolio methodsFor: 'verification' stamp: 'gc 10/19/2019 22:09:27'!
contains: anAccount
	^(anAccount = self) or: [accounts anySatisfy: [:anAccountInSelf | (anAccount contains: anAccountInSelf ) or: [anAccountInSelf contains: anAccount ]]]
! !


!Portfolio methodsFor: 'balance' stamp: 'gc 10/19/2019 22:10:24'!
balance
	^accounts inject: 0 into: [:totalBalance :account | totalBalance + (account balance)]! !


!Portfolio methodsFor: 'transactions' stamp: 'gc 10/19/2019 21:40:49'!
transactions
	| transactions |
	transactions _ OrderedCollection  new.
	
	^accounts inject: transactions into: [:total :account | total addAll: (account transactions). total].! !


!Portfolio methodsFor: 'get' stamp: 'gc 10/19/2019 21:39:19'!
accounts
	^accounts! !

!Portfolio methodsFor: 'get' stamp: 'gc 10/18/2019 16:17:52'!
parents
	^parents! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'gc 10/17/2019 19:17:44'!
create
	^Portfolio initialize new! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'verification' stamp: 'gc 10/19/2019 22:18:59'!
contains: anAccount
	^self = anAccount.! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'gc 10/19/2019 23:17:18'!
initializeFor: aValue

	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'gc 10/19/2019 23:17:23'!
value 

	^self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'gc 10/19/2019 23:17:27'!
worth 

	^self subclassResponsibility ! !

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
