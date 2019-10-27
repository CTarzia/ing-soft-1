!classDefinition: #AccountSummaryTest category: #'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 12:52:11'!
test01SummaryForAccountWithoutTransactionsIsBalance0
	| account accountSummary |
	account _ ReceptiveAccount new.
	accountSummary _ (AccountSummary for: account) value.
	self assert: 1 equals: (accountSummary size).
	self assert: 'Balance = 0' equals: (accountSummary at: 1).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 12:52:48'!
test02SummaryShowsRecieve
	| account1 account2 accountSummary |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	AccountTransfer register: 50 from: account2 to: account1 .
	
	accountSummary _ (AccountSummary for: account1) value.
	self assert: 2 equals: (accountSummary size).
	self assert: 'Entrada por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Balance = 50' equals: (accountSummary at: 2).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 12:53:01'!
test03SummaryShowsSend
	| account1 account2 accountSummary |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	AccountTransfer register: 50 from: account1 to: account2 .
	
	accountSummary _ (AccountSummary for: account1) value.
	self assert: 2 equals: (accountSummary size).
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Balance = -50' equals: (accountSummary at: 2).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 12:53:06'!
test04SummaryShowsDeposit
	| account1 accountSummary |
	account1 _ ReceptiveAccount new.
	
	Deposit register: 50 on: account1 .
	
	accountSummary _ (AccountSummary for: account1) value.
	self assert: 2 equals: (accountSummary size).
	self assert: 'Deposito por 50' equals: (accountSummary at: 1).
	self assert: 'Balance = 50' equals: (accountSummary at: 2).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 12:53:13'!
test05SummaryShowsWithdraw
	| account1 accountSummary |
	account1 _ ReceptiveAccount new.
	
	Withdraw register: 50 on: account1 .
	
	accountSummary _ (AccountSummary for: account1) value.
	self assert: 2 equals: (accountSummary size).
	self assert: 'Extraccion por 50' equals: (accountSummary at: 1).
	self assert: 'Balance = -50' equals: (accountSummary at: 2).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 12:53:25'!
test06SummaryShowsAllTransactionsInOrder
	| account1 account2 accountSummary |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	AccountTransfer register: 50 from: account2 to: account1 .
	AccountTransfer register: 50 from: account1 to: account2 .
	Deposit register: 50 on: account1 .
	Withdraw register: 50 on: account1 .
	
	accountSummary _ (AccountSummary for: account1) value.
	self assert: 5 equals: (accountSummary size).
	self assert: 'Entrada por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 2).
	self assert: 'Deposito por 50' equals: (accountSummary at: 3).
	self assert: 'Extraccion por 50' equals: (accountSummary at: 4).
	self assert: 'Balance = 0' equals: (accountSummary at: 5).
	! !

!AccountSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 12:53:35'!
test07SummaryShowsAllTransactionsInOrderInPortfolioWithOneAccount
	| account1 account2 portfolio accountSummary |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	portfolio add: account1 .
	
	AccountTransfer register: 50 from: account2 to: account1 .
	AccountTransfer register: 50 from: account1 to: account2 .
	Deposit register: 50 on: account1 .
	Withdraw register: 50 on: account1 .
	
	accountSummary _ (AccountSummary for: portfolio ) value.
	self assert: 5 equals: (accountSummary size).
	self assert: 'Entrada por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 2).
	self assert: 'Deposito por 50' equals: (accountSummary at: 3).
	self assert: 'Extraccion por 50' equals: (accountSummary at: 4).
	self assert: 'Balance = 0' equals: (accountSummary at: 5).
	! !

!AccountSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 12:53:46'!
test08SummaryShowsAllTransactionsInOrderInPortfolioWithManyAccounts
	| account1 account2 portfolio accountSummary |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	portfolio add: account1 .
	portfolio add: account2 .
	
	AccountTransfer register: 50 from: account2 to: account1 .
	AccountTransfer register: 50 from: account1 to: account2 .
	Deposit register: 50 on: account1 .
	Withdraw register: 50 on: account1 .
	
	accountSummary _ (AccountSummary for: portfolio ) value.
	self assert: 7 equals: (accountSummary size).
	self assert: 'Entrada por transferencia de 50' equals: (accountSummary at: 1).
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 2).
	self assert: 'Deposito por 50' equals: (accountSummary at: 3).
	self assert: 'Extraccion por 50' equals: (accountSummary at: 4).
	self assert: 'Salida por transferencia de 50' equals: (accountSummary at: 5).
	self assert: 'Entrada por transferencia de 50' equals: (accountSummary at: 6).
	self assert: 'Balance = 0' equals: (accountSummary at: 7).
	! !


!classDefinition: #AccountTransferTest category: #'Portfolio-Solucion'!
TestCase subclass: #AccountTransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransferTest methodsFor: 'test' stamp: 'gc 10/26/2019 12:53:35'!
test01TotalBalanceBetweenAccountsAfterTransferIsTheSameAsBefore
	| account1 account2 totalBalanceBeforeTransfer totalBalanceAfterTransfer |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	
	totalBalanceBeforeTransfer _ account1 balance + account2 balance.
	
	AccountTransfer register: 50 from: account1 to: account2.
	
	totalBalanceAfterTransfer _ account1 balance + account2 balance.
	
	self assert: totalBalanceBeforeTransfer equals: totalBalanceAfterTransfer .
	
	! !

!AccountTransferTest methodsFor: 'test' stamp: 'gc 10/26/2019 12:53:35'!
test02TransferAffectsBalanceFromSenderAndReciever
	| account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	
	AccountTransfer register: 50 from: account1 to: account2.

	self assert: (account1 balance) equals: 50 .
	self assert: (account2 balance) equals: 150 .
	! !

!AccountTransferTest methodsFor: 'test' stamp: 'gc 10/26/2019 12:53:35'!
test03ManyTransfersAffectsBalanceFromSenderAndReciever
	| account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	Deposit register: 200 on: account2.
	
	AccountTransfer register: 50 from: account1 to: account2.
	AccountTransfer register: 50 from: account1 to: account2.
	AccountTransfer register: 50 from: account1 to: account2.
	AccountTransfer register: 50 from: account1 to: account2.

	self assert: (account1 balance) equals: 0 .
	self assert: (account2 balance) equals: 400 .
	! !

!AccountTransferTest methodsFor: 'test' stamp: 'gc 10/26/2019 12:53:35'!
test04PortfolioBalanceAfterTransferBetweenAccountsInItIsTheSameAsBefore
	| account1 account2 portfolio totalBalanceBeforeTransfer totalBalanceAfterTransfer |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	portfolio add: account1 .
	portfolio add: account2 .
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	
	totalBalanceBeforeTransfer _ portfolio balance.
	
	AccountTransfer register: 50 from: account1 to: account2.
	
	totalBalanceAfterTransfer _ portfolio balance.
	
	self assert: totalBalanceBeforeTransfer equals: totalBalanceAfterTransfer .
	
	! !

!AccountTransferTest methodsFor: 'test' stamp: 'gc 10/26/2019 12:53:35'!
test05TransferBetweenAccountsInDifferentPortfolioLevelsAffectsBalanceCorrectly
	| account1 account2 portfolio1 portfolio2 totalBalanceBeforeTransfer totalBalanceAfterTransfer |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio1 _ Portfolio new.
	portfolio2 _ Portfolio new.
	
	portfolio1 add: account1 .
	portfolio2 add: account2.
	portfolio1 add: portfolio2.
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	
	totalBalanceBeforeTransfer _ portfolio1 balance.
	
	AccountTransfer register: 50 from: account1 to: account2.
	
	totalBalanceAfterTransfer _ portfolio1 balance.
	
	self assert: totalBalanceBeforeTransfer equals: totalBalanceAfterTransfer .
	self assert: 200 equals: (portfolio1 balance).
	self assert: 150 equals: (portfolio2 balance).
	! !

!AccountTransferTest methodsFor: 'test' stamp: 'gc 10/26/2019 12:53:35'!
test06CantTransferToTheSameAccount
	| account1  |
	account1 _ ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	
	self 
		should: [  AccountTransfer register: 50 from: account1 to: account1 .  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: AccountTransfer canNotTransferToSelfErrorMessage equals: anError messageText.
			self deny: account1 hasTransfered .]! !

!AccountTransferTest methodsFor: 'test' stamp: 'gc 10/26/2019 12:53:35'!
test07CantTransferZero
	| account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	self 
		should: [  AccountTransfer register: 0 from: account1 to: account2 .  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: AccountTransfer canNotTransferZeroErrorMessage equals: anError messageText.
			self deny: account1 hasTransfered .
			self deny: account2 hasTransfered .
			]! !

!AccountTransferTest methodsFor: 'test' stamp: 'gc 10/26/2019 15:30:19'!
test09CantTransferNegativeAmount
	| account1 account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	self 
		should: [  AccountTransfer register: -10 from: account1 to: account2 .  ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: AccountTransfer canNotTransferNegativeAmountErrorMessage equals: anError messageText.
			self deny: account1 hasTransfered .
			self deny: account2 hasTransfered .
			]! !


!classDefinition: #PortfolioSummaryTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 13:45:17'!
test01EmptyPortfolioSummaryReturnsNameOfPortfolio
	|portfolio summary|
	portfolio _ Portfolio withName: 'mi portfolio'.
	
	summary _ (PortfolioSummary for: portfolio) value .
	
	self assert: 2 equals: summary size.
	self assert: 'mi portfolio' equals: (summary at: 1).
	self assert: '	','Balance = 0' equals: (summary at: 2).! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 13:45:28'!
test02PortfolioWithEmptyAccountSummaryReturnsNamesAndBalances
	|portfolio account summary|
	portfolio _ Portfolio withName: 'mi portfolio'.
	account _ ReceptiveAccount withName: 'mi cuenta'.
	
	portfolio add: account .
	
	summary _ (PortfolioSummary for: portfolio) value .
	
	self assert: 4 equals: summary size.
	self assert: 'mi portfolio' equals: (summary at: 1).
	self assert: '	','mi cuenta' equals: (summary at: 2).
	self assert: '	','	','Balance = 0' equals: (summary at: 3).
	self assert: '	','Balance = 0' equals: (summary at: 4).! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 13:45:58'!
test03PortfolioWithEmptyPortfolioSummaryReturnsNamesAndBalances
	|portfolio1 portfolio2 summary|
	portfolio1 _ Portfolio withName: 'mi portfolio 1'.
	portfolio2 _ ReceptiveAccount withName: 'mi portfolio 2'.
	
	portfolio1 add: portfolio2 .
	
	summary _ (PortfolioSummary for: portfolio1) value .
	
	self assert: 4 equals: summary size.
	self assert: 'mi portfolio 1' equals: (summary at: 1).
	self assert: '	','mi portfolio 2' equals: (summary at: 2).
	self assert: '	','	','Balance = 0' equals: (summary at: 3).
	self assert: '	','Balance = 0' equals: (summary at: 4).! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 13:46:27'!
test04PortfolioWithPortfoliosAndAccountsSummaryReturnsNamesAndBalances
	|portfolio1 portfolio2 account1 account2  summary|
	portfolio1 _ Portfolio withName: 'mi portfolio 1'.
	portfolio2 _ Portfolio withName: 'mi portfolio 2'.
	account1 _ ReceptiveAccount withName: 'mi cuenta 1'.	
	account2 _ ReceptiveAccount withName: 'mi cuenta 2'.
	
	portfolio1 add: portfolio2 .
	portfolio1 add: account1 .
	portfolio2 add: account2 .
	
	summary _ (PortfolioSummary for: portfolio1) value .
	
	self assert: 8 equals: summary size.
	self assert: 'mi portfolio 1' equals: (summary at: 1).
	self assert: '	','mi portfolio 2' equals: (summary at: 2).
	self assert: '	','	','mi cuenta 2' equals: (summary at: 3).
	self assert: '	','	','	','Balance = 0' equals: (summary at: 4).
	self assert: '	','	','Balance = 0' equals: (summary at: 5).
	self assert: '	','mi cuenta 1' equals: (summary at: 6).
	self assert: '	','	','Balance = 0' equals: (summary at: 7).
	self assert: '	','Balance = 0' equals: (summary at: 8).! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 14:37:21'!
test05PortfolioWithPortfoliosAndAccountsAndTransactionsSummaryReturnsNamesAndBalancesAndTransactions
	|portfolio1 portfolio2 account1 account2  summary |
	portfolio1 _ Portfolio withName: 'mi portfolio 1'.
	portfolio2 _ Portfolio withName: 'mi portfolio 2'.
	account1 _ ReceptiveAccount withName: 'mi cuenta 1'.	
	account2 _ ReceptiveAccount withName: 'mi cuenta 2'.
	
	Deposit register: 100 on: account1 .
	Withdraw register: 50 on: account2 .
	AccountTransfer register: 75 from: account1 to: account2 .
	
	portfolio1 add: portfolio2 .
	portfolio1 add: account1 .
	portfolio2 add: account2 .
	
	summary _ (PortfolioSummary for: portfolio1) value .
	
	self assert: 12 equals: summary size.
	self assert: 'mi portfolio 1' equals: (summary at: 1).
	self assert: '	','mi portfolio 2' equals: (summary at: 2).
	self assert: '	','	','mi cuenta 2' equals: (summary at: 3).
	self assert: '	','	','	','Extraccion por 50' equals: (summary at: 4).
	self assert:  '	','	','	','Entrada por transferencia de 75' equals: (summary at: 5).
	self assert:  '	','	','	','Balance = 25' equals: (summary at: 6).
	self assert: '	','	','Balance = 25' equals: (summary at: 7).
	self assert: '	','mi cuenta 1' equals: (summary at: 8).
	self assert: '	','	','Deposito por 100' equals: (summary at: 9).
	self assert: '	','	','Salida por transferencia de 75' equals: (summary at: 10).
	self assert: '	','	','Balance = 25' equals: (summary at: 11).
	self assert: '	','Balance = 50' equals: (summary at: 12).! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 14:39:52'!
test06PortfolioTreeStructureNeedsPortfolioWithName
	|portfolio1 |
	portfolio1 _ Portfolio new.
	
	self 
		should: [  (PortfolioSummary for: portfolio1) value . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PortfolioReport canNotPrintAccountWithoutNameErrorMessage equals: anError messageText.
			]
	! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'gc 10/27/2019 14:40:36'!
test07PortfolioTreeStructureNeedsAccountsWithNames
	|portfolio account |
	portfolio _ Portfolio withName: 'mi portfolio'.
	account _ ReceptiveAccount new.
	portfolio add: account .
	
	self 
		should: [  (PortfolioSummary for: portfolio) value . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PortfolioReport canNotPrintAccountWithoutNameErrorMessage equals: anError messageText.
			]
	! !


!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!classDefinition: #TransferNetTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:54:53'!
test01RATransferNetReturnsZeroInAccountWithoutTransfersOrTransactions
	| account1  |
	account1 _ ReceptiveAccount new.

	self assert: 0 equals: (TransferNet for: account1 ) value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:05'!
test02RATransferNetReturnsZeroInAccountWithoutTransfersWithTransactions
	| account1  |
	account1 _ ReceptiveAccount new.
	Deposit register: 200 on: account1.

	self assert: 0 equals:  (TransferNet for: account1 ) value .! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:12'!
test03RATransferNetReturnsBalanceInAccountWithTransfersWithoutTransactions
	| account1  account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	AccountTransfer register: 50 from: account1 to: account2 .
	
	self assert: account1 balance equals:  (TransferNet for: account1 ) value .
	self assert: account2 balance equals:  (TransferNet for: account2 )  value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:18'!
test04RATransferNetReturnsNetTransfersInAccountWithTransfersWithTransactions
	| account1  account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	
	AccountTransfer register: 50 from: account1 to: account2 .
	
	self assert: -50 equals:  (TransferNet for: account1 ) value .
	self assert: 50 equals:  (TransferNet for: account2 )  value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:24'!
test05RATransferNetReturnsNetTransfersInAccountsWithManyTransfersAndTransactions
	| account1  account2  |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	Withdraw register: 25 on: account1.
	Withdraw register: 25 on: account2.
	
	AccountTransfer register: 50 from: account1 to: account2 .
	
	AccountTransfer register: 25 from: account2 to: account1 .
	
	self assert: -25 equals:  (TransferNet for: account1 ) value .
	self assert: 25 equals:  (TransferNet for: account2 )  value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:34'!
test06PortfolioTransferNetReturnsZeroInPortfolioWithoutAccounts
	| portfolio  |
	portfolio _ Portfolio new.

	self assert: 0 equals:  (TransferNet for: portfolio ) value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:40'!
test07PortfolioTransferNetReturnsZeroInPortfolioWithoutTransfersOrTransactions
	| portfolio account1 |
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.

	portfolio add: account1 .
	
	self assert: 0 equals:  (TransferNet for: portfolio ) value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:46'!
test08PortfolioTransferNetReturnsZeroInPortfolioWithoutTransfersWithTransactions
	| portfolio account1  |
	portfolio _ Portfolio new.
	account1 _ ReceptiveAccount new.
	
	Deposit register: 200 on: account1.
	
	portfolio add: account1 .
	
	self assert: 0 equals: (TransferNet for: portfolio ) value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:51'!
test09PortfolioTransferNetReturnsBalanceInPortfolioWithTransfersWithoutTransactions
	| portfolio account1  account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	portfolio add: account1 .
	
	AccountTransfer register: 50 from: account1 to: account2 .
	
	self assert: portfolio balance equals: (TransferNet for: portfolio ) value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:56:56'!
test10PortfolioTransferNetReturnsZeroInPortfolioWithTransfersWithinItself
	| portfolio account1  account2 |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	portfolio add: account1 .
	portfolio add: account2.
	
	AccountTransfer register: 50 from: account1 to: account2 .
	
	self assert: 0 equals: (TransferNet for: portfolio ) value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:57:01'!
test11PortfolioTransferNetReturnsNetTransfersInAccountWithTransfersWithTransactions
	| account1  account2 portfolio |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	portfolio add: account1.
		
	AccountTransfer register: 50 from: account1 to: account2 .
	
	self assert: -50 equals: (TransferNet for: portfolio ) value.! !

!TransferNetTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:57:06'!
test12PortfolioTransferNetReturnsNetTransfersInPortfolioWithManyTransfersAndTransactions
	| account1  account2 portfolio |
	account1 _ ReceptiveAccount new.
	account2 _ ReceptiveAccount new.
	portfolio _ Portfolio new.
	portfolio add: account1 .
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2.
	Withdraw register: 25 on: account1.
	Withdraw register: 25 on: account2.
	
	AccountTransfer register: 50 from: account1 to: account2 .
	
	AccountTransfer register: 25 from: account2 to: account1 .
	
	self assert: -25 equals: (TransferNet for: portfolio ) value.! !


!classDefinition: #TreeStructureTest category: #'Portfolio-Solucion'!
TestCase subclass: #TreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructureTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:57:37'!
test01EmptyPortfolioTreeStructureReturnsNameOfPortfolio
	|portfolio treeStructure|
	portfolio _ Portfolio withName: 'mi portfolio'.
	
	treeStructure _ (TreeStructure for: portfolio) value .
	
	self assert: 1 equals: treeStructure size.
	self assert: 'mi portfolio' equals: (treeStructure at: 1).
	! !

!TreeStructureTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:57:52'!
test02PortfolioTreeStructureWithOneAccountHasCorrectIndentation
	|portfolio account  treeStructure|
	portfolio _ Portfolio withName: 'mi portfolio'.
	account _ ReceptiveAccount withName: 'mi cuenta'.
	portfolio add: account .
	
	treeStructure _ (TreeStructure for: portfolio) value .
	
	self assert: 2 equals: treeStructure size.
	self assert: 'mi portfolio' equals: (treeStructure at: 1).
	self assert: '	','mi cuenta' equals: (treeStructure at: 2).
	! !

!TreeStructureTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:58:56'!
test03PortfolioTreeStructureWithOnePortfolioHasCorrectIndentation
	|portfolio1 portfolio2  treeStructure|
	portfolio1 _ Portfolio withName: 'mi portfolio 1'.
	portfolio2 _ Portfolio withName: 'mi portfolio 2'.
	portfolio1 add: portfolio2 .
	
	treeStructure _ (TreeStructure for: portfolio1) value .
	
	self assert: 2 equals: treeStructure size.
	self assert: 'mi portfolio 1' equals: (treeStructure at: 1).
	self assert: '	','mi portfolio 2' equals: (treeStructure at: 2).
	! !

!TreeStructureTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:59:12'!
test04PortfolioTreeStructureWithPortfoliosAndAccountsHasCorrectIndentation
	|portfolio1 portfolio2 account1 account2  treeStructure|
	portfolio1 _ Portfolio withName: 'mi portfolio 1'.
	portfolio2 _ Portfolio withName: 'mi portfolio 2'.
	account1 _ ReceptiveAccount withName: 'mi cuenta 1'.	
	account2 _ ReceptiveAccount withName: 'mi cuenta 2'.
	
	portfolio1 add: portfolio2 .
	portfolio1 add: account1 .
	portfolio2 add: account2 .
	
	treeStructure _ (TreeStructure for: portfolio1) value .
	
	self assert: 4 equals: treeStructure size.
	self assert: 'mi portfolio 1' equals: (treeStructure at: 1).
	self assert: '	','mi portfolio 2' equals: (treeStructure at: 2).
	self assert: '	','	','mi cuenta 2' equals: (treeStructure at: 3).
	self assert: '	','mi cuenta 1' equals: (treeStructure at: 4).
	! !

!TreeStructureTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:59:27'!
test05PortfolioTreeStructureNeedsPortfolioWithName
	|portfolio1 |
	portfolio1 _ Portfolio new.
	
	self 
		should: [  (TreeStructure for: portfolio1) value . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PortfolioReport canNotPrintAccountWithoutNameErrorMessage equals: anError messageText.
			]
	! !

!TreeStructureTest methodsFor: 'tests' stamp: 'gc 10/27/2019 12:59:43'!
test06PortfolioTreeStructureNeedsAccountsWithNames
	|portfolio account |
	portfolio _ Portfolio withName: 'mi portfolio'.
	account _ ReceptiveAccount new.
	portfolio add: account .
	
	self 
		should: [  (TreeStructure for: portfolio) value . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PortfolioReport canNotPrintAccountWithoutNameErrorMessage equals: anError messageText.
			]
	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'report' stamp: 'gc 10/26/2019 14:32:29'!
updateReport: aReport
	^self subclassResponsibility ! !


!Account methodsFor: 'name' stamp: 'gc 10/27/2019 15:08:38'!
name
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 11:23:56'!
withName: aString 
	self subclassResponsibility .! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'gc 10/27/2019 11:50:38'!
accounts
	^accounts ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'gc 10/27/2019 12:34:52'!
initialize
	name := 0.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'gc 10/27/2019 10:36:47'!
initializeWithName: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName .! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'report' stamp: 'gc 10/27/2019 11:47:43'!
updateReport: aReport
	aReport updateReportWithPortfolio: self.! !


!Portfolio methodsFor: 'name' stamp: 'gc 10/27/2019 10:50:59'!
name
	^name ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 10:36:12'!
withName: aName 
	^self new initializeWithName: aName 
	! !


!Portfolio class methodsFor: 'error message' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'gc 10/27/2019 12:42:26'!
initialize

	super initialize.
	name := 0.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'gc 10/27/2019 11:25:26'!
initializeWithName: aName

	super initialize.
	transactions := OrderedCollection new.
	name := aName .! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'gc 10/26/2019 12:44:24'!
register: aTransaction
	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'gc 10/26/2019 12:46:57'!
balance
	
	^ transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 14:26:41'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'gc 10/26/2019 14:22:25'!
hasTransfered
	^transactions 
		anySatisfy: [ :aTransaction |
			aTransaction isTransfer
		].! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'gc 10/27/2019 11:31:04'!
updateReport: aReport
	aReport updateReportWithAccount: self.
	^transactions do: [ :aTransaction | (aTransaction updateReport: aReport )] ! !


!ReceptiveAccount methodsFor: 'name' stamp: 'gc 10/27/2019 11:42:03'!
name
	^name ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 11:24:50'!
withName: aName 
	^self new initializeWithName: aName ! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'NR 10/17/2019 03:44:38'!
initializeFor: aValue

	value := aValue ! !

!AccountTransaction methodsFor: 'value' stamp: 'NR 10/17/2019 03:43:52'!
value

	^ value! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'gc 10/26/2019 14:32:29'!
updateReport: aReport
	^self subclassResponsibility ! !


!AccountTransaction methodsFor: 'register' stamp: 'gc 10/21/2019 21:06:32'!
registerTo: aReceptiveAccount
	^self subclassResponsibility ! !


!AccountTransaction methodsFor: 'transfer' stamp: 'gc 10/27/2019 16:18:18'!
isTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 14:27:17'!
for: aValue

	^ self new initializeFor: aValue! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 15:16:21'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction
! !


!classDefinition: #AccountTransfer category: #'Portfolio-Solucion'!
AccountTransaction subclass: #AccountTransfer
	instanceVariableNames: 'sender reciever'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransfer methodsFor: 'value' stamp: 'gc 10/26/2019 12:27:29'!
value
	^value ! !


!AccountTransfer methodsFor: 'report' stamp: 'gc 10/26/2019 14:32:29'!
updateReport: aReport
	^self subclassResponsibility ! !


!AccountTransfer methodsFor: 'register' stamp: 'gc 10/26/2019 12:27:17'!
registerTo: aReceptiveAccount
	^self subclassResponsibility ! !


!AccountTransfer methodsFor: 'balance' stamp: 'gc 10/26/2019 12:26:26'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransfer methodsFor: 'initialization' stamp: 'gc 10/26/2019 12:26:46'!
for: aValue from: aSendingAccount to: aRecievingAccount.
	value _ aValue .
	sender _ aSendingAccount .
	reciever _ aRecievingAccount .
	! !

!AccountTransfer methodsFor: 'initialization' stamp: 'gc 10/27/2019 15:06:41'!
initializeFor: aValue
	value _ aValue .! !


!AccountTransfer methodsFor: 'transfer' stamp: 'gc 10/26/2019 14:23:43'!
isTransfer 
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransfer class' category: #'Portfolio-Solucion'!
AccountTransfer class
	instanceVariableNames: ''!

!AccountTransfer class methodsFor: 'instance creation' stamp: 'gc 10/26/2019 12:29:06'!
for: aValue
	^self new initializeFor: aValue! !

!AccountTransfer class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 15:02:27'!
register: aValue from: aSendingAccount to: aRecievingAccount 
	
	| transfer transferRecieve transferSend|
	
	aSendingAccount = aRecievingAccount ifTrue: [^self error: AccountTransfer canNotTransferToSelfErrorMessage].
	
	0 = aValue ifTrue: [^self error: AccountTransfer canNotTransferZeroErrorMessage].
	
	0 > aValue ifTrue: [^self error: AccountTransfer canNotTransferNegativeAmountErrorMessage ].
	
	transfer := self new for: aValue from: aSendingAccount to: aRecievingAccount.
	
	transferRecieve _ Recieve for: transfer.
	transferSend _ Send for: transfer.
	
	aSendingAccount register: transferSend.
	aRecievingAccount register: transferRecieve.
	
	^ transfer 
! !


!AccountTransfer class methodsFor: 'error message' stamp: 'gc 10/26/2019 12:28:15'!
canNotTransferNegativeAmountErrorMessage
	^'No se puede transferir un valor negativo.'.! !

!AccountTransfer class methodsFor: 'error message' stamp: 'gc 10/26/2019 12:28:31'!
canNotTransferToSelfErrorMessage
	^'No se puede transferir dinero a si mismo'.! !

!AccountTransfer class methodsFor: 'error message' stamp: 'gc 10/26/2019 12:28:49'!
canNotTransferZeroErrorMessage
	^'No se puede transferir un valor de cero.'.! !


!classDefinition: #Recieve category: #'Portfolio-Solucion'!
AccountTransfer subclass: #Recieve
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Recieve methodsFor: 'report' stamp: 'gc 10/26/2019 15:12:25'!
updateReport: aReport
	^aReport updateReportWithRecieve: self.! !


!Recieve methodsFor: 'balance' stamp: 'gc 10/26/2019 12:24:41'!
affectBalance: aBalance

	^aBalance + (transfer value) ! !


!Recieve methodsFor: 'value' stamp: 'gc 10/26/2019 15:11:35'!
value
	^transfer value! !


!Recieve methodsFor: 'transfer' stamp: 'gc 10/26/2019 14:23:57'!
isTransfer 
	^true! !


!Recieve methodsFor: 'initialization' stamp: 'gc 10/26/2019 12:25:14'!
initializeFor: aTransfer 
	transfer _ aTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Recieve class' category: #'Portfolio-Solucion'!
Recieve class
	instanceVariableNames: ''!

!Recieve class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 15:01:57'!
for: aTransfer
	^self new initializeFor: aTransfer ! !


!classDefinition: #Send category: #'Portfolio-Solucion'!
AccountTransfer subclass: #Send
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Send methodsFor: 'transfer' stamp: 'gc 10/26/2019 14:24:05'!
isTransfer 
	^true! !


!Send methodsFor: 'value' stamp: 'gc 10/26/2019 17:04:31'!
value
	^ transfer value! !


!Send methodsFor: 'report' stamp: 'gc 10/26/2019 15:12:44'!
updateReport: aReport
	^aReport updateReportWithSend: self.! !


!Send methodsFor: 'initialization' stamp: 'gc 10/26/2019 12:25:55'!
initializeFor: aTransfer 
	transfer _ aTransfer ! !


!Send methodsFor: 'balance' stamp: 'gc 10/26/2019 12:25:39'!
affectBalance: aBalance

	^aBalance - (transfer value) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Send class' category: #'Portfolio-Solucion'!
Send class
	instanceVariableNames: ''!

!Send class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 15:02:07'!
for: aTransfer
	^self new initializeFor: aTransfer ! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'report' stamp: 'gc 10/26/2019 15:13:09'!
updateReport: aReport
	^aReport updateReportWithDeposit: self.! !


!Deposit methodsFor: 'transfer' stamp: 'gc 10/26/2019 14:24:55'!
isTransfer 
	^false! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'report' stamp: 'gc 10/26/2019 15:13:23'!
updateReport: aReport
	^aReport updateReportWithWithdraw: self.! !


!Withdraw methodsFor: 'transfer' stamp: 'gc 10/26/2019 14:25:02'!
isTransfer 
	^false! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'register' stamp: 'gc 10/21/2019 21:08:29'!
registerTo: aReceptiveAccount
	aReceptiveAccount registerTransaction: self.! !


!classDefinition: #PortfolioReport category: #'Portfolio-Solucion'!
Object subclass: #PortfolioReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReport methodsFor: 'value' stamp: 'gc 10/27/2019 16:29:12'!
value
	^self subclassResponsibility ! !


!PortfolioReport methodsFor: 'initialization' stamp: 'gc 10/27/2019 16:28:31'!
initializeFor: aPorfolio
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReport class' category: #'Portfolio-Solucion'!
PortfolioReport class
	instanceVariableNames: ''!

!PortfolioReport class methodsFor: 'error message' stamp: 'gc 10/27/2019 12:36:25'!
canNotPrintAccountWithoutNameErrorMessage
	^'No se puede imprimir portfolios o cuentas sin nombre'! !


!classDefinition: #PortfolioSummary category: #'Portfolio-Solucion'!
PortfolioReport subclass: #PortfolioSummary
	instanceVariableNames: 'portfolio portfolioSummary indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummary methodsFor: 'initialization' stamp: 'gc 10/27/2019 13:25:05'!
initializeFor: aPortfolio
	portfolio _ aPortfolio .
	portfolioSummary _ OrderedCollection new.
	indentation _ ''.
	
	! !


!PortfolioSummary methodsFor: 'value' stamp: 'gc 10/27/2019 13:25:15'!
value
	portfolio updateReport: self.
	
	^portfolioSummary 
! !


!PortfolioSummary methodsFor: 'update report' stamp: 'gc 10/27/2019 14:37:42'!
updateReportWithAccount: anAccount 
	|accountSummary|
	anAccount name = 0 ifTrue: [^ self error: PortfolioReport canNotPrintAccountWithoutNameErrorMessage].
	accountSummary _(AccountSummary for: anAccount ) value.
	portfolioSummary add: (indentation , (anAccount name)).
	indentation _ indentation , '	'.
	accountSummary do: [:aLine | portfolioSummary add: (indentation , aLine)].
	indentation _ indentation allButLast ! !

!PortfolioSummary methodsFor: 'update report' stamp: 'gc 10/27/2019 13:42:21'!
updateReportWithDeposit: aDeposit 
	! !

!PortfolioSummary methodsFor: 'update report' stamp: 'gc 10/27/2019 14:37:53'!
updateReportWithPortfolio: aPortfolio 
	aPortfolio name = 0 ifTrue: [^ self error: PortfolioReport canNotPrintAccountWithoutNameErrorMessage].
	portfolioSummary add: (indentation , (aPortfolio name)).
	indentation _ indentation , '	'.
	aPortfolio accounts do: [ :anAccount | (anAccount updateReport: self )] .
	portfolioSummary add: (indentation, 'Balance = ', (aPortfolio balance asString )).
	indentation _ indentation allButLast .
! !

!PortfolioSummary methodsFor: 'update report' stamp: 'gc 10/27/2019 13:42:12'!
updateReportWithRecieve: aRecieve 
	! !

!PortfolioSummary methodsFor: 'update report' stamp: 'gc 10/27/2019 13:42:38'!
updateReportWithSend: aSend 
	! !

!PortfolioSummary methodsFor: 'update report' stamp: 'gc 10/27/2019 13:41:57'!
updateReportWithWithdraw: aWithdraw 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioSummary class' category: #'Portfolio-Solucion'!
PortfolioSummary class
	instanceVariableNames: ''!

!PortfolioSummary class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 12:49:39'!
for: aPortfolio 
	^self new initializeFor: aPortfolio.! !


!classDefinition: #TreeStructure category: #'Portfolio-Solucion'!
PortfolioReport subclass: #TreeStructure
	instanceVariableNames: 'portfolio treeStructure indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructure methodsFor: 'value' stamp: 'gc 10/27/2019 12:51:56'!
value
	portfolio updateReport: self.
	
	^treeStructure 
! !


!TreeStructure methodsFor: 'initialization' stamp: 'gc 10/27/2019 12:55:26'!
initializeFor: aPortfolio
	portfolio _ aPortfolio .
	treeStructure _ OrderedCollection new.
	indentation _ ''.
	! !


!TreeStructure methodsFor: 'update report' stamp: 'gc 10/27/2019 12:42:47'!
updateReportWithAccount: anAccount
	anAccount name = 0 ifTrue: [^ self error: PortfolioReport canNotPrintAccountWithoutNameErrorMessage].
	treeStructure add: (indentation , (anAccount name)).! !

!TreeStructure methodsFor: 'update report' stamp: 'gc 10/27/2019 12:38:27'!
updateReportWithPortfolio: aPortfolio 
	aPortfolio name = 0 ifTrue: [^ self error: PortfolioReport canNotPrintAccountWithoutNameErrorMessage].
	treeStructure add: (indentation , (aPortfolio name)).
	indentation _ indentation , '	'.
	aPortfolio accounts do: [ :anAccount | (anAccount updateReport: self )] .
	indentation _ indentation allButLast .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreeStructure class' category: #'Portfolio-Solucion'!
TreeStructure class
	instanceVariableNames: ''!

!TreeStructure class methodsFor: 'instance creation' stamp: 'gc 10/27/2019 12:49:31'!
for: aPortfolio 
	^self new initializeFor: aPortfolio .! !


!classDefinition: #TransactionReport category: #'Portfolio-Solucion'!
Object subclass: #TransactionReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #AccountSummary category: #'Portfolio-Solucion'!
TransactionReport subclass: #AccountSummary
	instanceVariableNames: 'account accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'value' stamp: 'gc 10/27/2019 12:51:09'!
value
	account updateReport: self.
	
	accountSummary add: ('Balance = ',(account balance) asString ).
	
	^accountSummary 
! !


!AccountSummary methodsFor: 'initialization' stamp: 'gc 10/27/2019 12:50:57'!
initializeFor: anAccount

	account _ anAccount .
	accountSummary _ OrderedCollection new.
	
! !


!AccountSummary methodsFor: 'update report' stamp: 'gc 10/27/2019 12:19:58'!
updateReportWithAccount: aReceptiveAccount ! !

!AccountSummary methodsFor: 'update report' stamp: 'gc 10/26/2019 17:09:42'!
updateReportWithDeposit: aDeposit 
	accountSummary add: ('Deposito por ', (aDeposit value ) asString )! !

!AccountSummary methodsFor: 'update report' stamp: 'gc 10/27/2019 12:20:48'!
updateReportWithPortfolio: aPortfolio 
	aPortfolio accounts do: [ :anAccount | (anAccount updateReport: self )] ! !

!AccountSummary methodsFor: 'update report' stamp: 'gc 10/26/2019 17:02:00'!
updateReportWithRecieve: aRecieve 
	accountSummary add: ('Entrada por transferencia de ', (aRecieve value ) asString )! !

!AccountSummary methodsFor: 'update report' stamp: 'gc 10/26/2019 17:04:10'!
updateReportWithSend: aSend 
	accountSummary add: ('Salida por transferencia de ', (aSend value ) asString )! !

!AccountSummary methodsFor: 'update report' stamp: 'gc 10/26/2019 17:09:07'!
updateReportWithWithdraw: aWithdraw 
	accountSummary add: ('Extraccion por ', (aWithdraw value ) asString )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'gc 10/26/2019 16:16:45'!
for: anAccount
	^self new initializeFor: anAccount .! !


!classDefinition: #TransferNet category: #'Portfolio-Solucion'!
TransactionReport subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'gc 10/27/2019 12:55:09'!
initializeFor: anAccount

	account _ anAccount .
	transferNet _ 0.
! !


!TransferNet methodsFor: 'value' stamp: 'gc 10/27/2019 12:51:27'!
value
	account updateReport: self.
	
	^transferNet 
! !


!TransferNet methodsFor: 'update report' stamp: 'gc 10/27/2019 11:48:55'!
updateReportWithAccount: aReceptiveAccount ! !

!TransferNet methodsFor: 'update report' stamp: 'gc 10/26/2019 14:40:26'!
updateReportWithDeposit: aDeposit! !

!TransferNet methodsFor: 'update report' stamp: 'gc 10/27/2019 11:53:15'!
updateReportWithPortfolio: aPortfolio 
	^ aPortfolio accounts do: [ :anAccount | (anAccount updateReport: self  )] ! !

!TransferNet methodsFor: 'update report' stamp: 'gc 10/26/2019 15:39:14'!
updateReportWithRecieve: aRecieve
	transferNet _ transferNet + (aRecieve value)! !

!TransferNet methodsFor: 'update report' stamp: 'gc 10/26/2019 17:04:49'!
updateReportWithSend: aSend
	transferNet _ transferNet - (aSend value)! !

!TransferNet methodsFor: 'update report' stamp: 'gc 10/26/2019 14:12:37'!
updateReportWithWithdraw: aWithdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: #'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'gc 10/26/2019 13:39:16'!
for: anAccount
	^self new initializeFor: anAccount .! !
