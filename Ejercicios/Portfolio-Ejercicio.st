!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 15:14:53'!
test01EmptyPortfolioHasBalanceZero
	
	"|portfolio|
	
	portfolio := Portfolio new.
	
	self assert:0 equals: portfolio balance.  "
	self assert: 0 equals: Portfolio new balance
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 23:16:39'!
test02PortfolioWithAccountThatHasDepositReportsItInBalance
	
	|portfolio account|
	
	account := ReceptiveAccount new.
	portfolio := Portfolio initializePortfolioWith:account.
	
	Deposit register: 100 on: account.
	
	self assert: 100 equals: portfolio balance.  
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 23:17:03'!
test03PortfolioWithAccountThatHasTwoDepositsReportsIThemInBalance
	
	|portfolio account|
	account := ReceptiveAccount new.
	portfolio := Portfolio initializePortfolioWith:account.
	
	Deposit register: 100 on: account.
	Deposit register: 30 on: account.
	
	"portfolio addAccount:account."
	
	self assert: 130 equals: portfolio balance.  
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 23:20:51'!
test04PortfolioWithTwoAccountWithBalancesCalculatesThemCorrectly
	
	|portfolio account1 account2|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio initializePortfolioWith:account1 with:account2.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	self assert: 50 equals: portfolio balance.  
	
	Deposit register: 420 on: account2.
	Withdraw register: 69 on: account2.
	self assert: 401 equals: portfolio balance.  
 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 13:24:20'!
test05PortfolioWithNoAccountsHasNoRegisteredTransaction
	
	|portfolio|
	
	portfolio := Portfolio initializePortfolio.
	
	self deny: (portfolio hasRegistered: (Deposit for: 100))
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 23:26:35'!
test06BalanceOfPortfolioIsCalculatedRecursively
	
	|normalPortfolio composedPortfolio account1 account2 composedPortfolioDeposit simplePortfolioDeposit |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	normalPortfolio := Portfolio initializePortfolioWith:account1.
	composedPortfolio := Portfolio initializePortfolioWith:account2 with:normalPortfolio.
	
	simplePortfolioDeposit:=Deposit register:100 on: account1.
	composedPortfolioDeposit:=Deposit register:69 on: account2.
	
	self assert: 100 equals: normalPortfolio balance.
	
	self assert: 169 equals: composedPortfolio balance.
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/27/2024 02:35:55'!
test07PortfolioWithActiveAccountHasARegisteredTransaction
	
	|portfolio account deposit|
	
	account := ReceptiveAccount new.
	portfolio := Portfolio initializePortfolioWith:account.
	deposit := ​Deposit register: 100 on: account.
	
	self assert: (portfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/27/2024 02:35:46'!
test08PortfolioWithActiveAccountsHasARegisteredTransaction
	
	|portfolio account1 account2 deposit|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio := Portfolio initializePortfolioWith:account1 with:account2.
	deposit := ​Withdraw register: 100 on: account2.
	
	self assert: (portfolio hasRegistered: deposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 23:45:01'!
test09PortfolioWithInactiveAccountHasNoRegisteredTransaction
	
	|portfolio account|
	
	account := ReceptiveAccount new.
	portfolio := Portfolio initializePortfolioWith:account.
	
	self deny: (portfolio hasRegistered: (Deposit for: 100))
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/27/2024 02:35:17'!
test10PortfolioChecksRegisteredAccountsRecursively
	
	|normalPortfolio composedPortfolio account1 account2 composedPortfolioDeposit simplePortfolioDeposit composedPortfolioTransactions |
	
	account1 := ReceptiveAccount new.
	normalPortfolio := Portfolio initializePortfolioWith:account1.
	account2 := ReceptiveAccount new.
	composedPortfolio := Portfolio initializePortfolioWith:normalPortfolio with: account2.
	
	simplePortfolioDeposit:=Deposit register:100 on: account1.
	composedPortfolioDeposit:=Deposit register:69 on: account2.
	
	composedPortfolioTransactions:=composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	
	"self assert: (composedPortfolio hasRegistered:simplePortfolioDeposit)."
	
	"self assert: (composedPortfolio hasRegistered:composedPortfolioDeposit)."
	
	self assert: (composedPortfolioTransactions includes:simplePortfolioDeposit).
	
	self assert: (composedPortfolioTransactions includes:composedPortfolioDeposit)
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/27/2024 02:39:06'!
test11PortfolioCannotIncludeTheSameAccountMoreThanOnce
	
	|portfolio account|
	
	account := ReceptiveAccount new.
	portfolio := Portfolio initializePortfolioWith:account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'JP 5/27/2024 15:48:15'!
test12PortfolioCannotIncludeAccountOfItsPortfolios
	
	|normalPortfolio composedPortfolio account|
	
	account := ReceptiveAccount new.
	normalPortfolio := Portfolio initializePortfolioWith:account.
	composedPortfolio := Portfolio initializePortfolioWith:account.
	
	self 
		should: [ composedPortfolio add: normalPortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			"self assert: 1 equals: composedPortfolio accountsSize."
			"self assert: (composedPortfolio accountsIncludes: account)" ]
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'JP 5/23/2024 22:54:31'!
balance
	^accounts sum:[:aPortfolioAccount | aPortfolioAccount balance] ifEmpty:[^0].
	
	! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'JP 5/23/2024 21:40:00'!
addAccount: account 
	accounts add: account.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 14:47:21'!
hasRegistered: aTransaction
	^accounts anySatisfy:[:aPortfolioAccount | aPortfolioAccount hasRegistered:aTransaction].
	! !


!Portfolio methodsFor: 'initialization' stamp: 'JP 5/24/2024 22:26:09'!
initialize
	accounts:=OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'JP 5/23/2024 21:46:32'!
openPortfolio
	accounts:=OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'JP 5/24/2024 15:01:10'!
openPortfolioWith:aPortfolioAccount
	accounts:=OrderedCollection new.
	accounts add: aPortfolioAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'JP 5/24/2024 23:22:33'!
openPortfolioWith: account1 with: account2 
	accounts:=OrderedCollection new.
	accounts add: account1.
	accounts add: account2.! !


!Portfolio methodsFor: 'testing' stamp: 'JP 5/27/2024 02:53:54'!
accountsIncludes: account 
	^accounts includes: account.! !

!Portfolio methodsFor: 'testing' stamp: 'JP 5/27/2024 02:53:35'!
accountsSize
	^accounts size.! !


!Portfolio methodsFor: 'transactions' stamp: 'JP 5/27/2024 02:18:26'!
transactions
	|transactions|
	
	transactions:=OrderedCollection new.
	accounts do:[:aPortfolioAccount| transactions:=transactions union: (aPortfolioAccount transactions)].
	^transactions! !


!Portfolio methodsFor: 'accounts' stamp: 'JP 5/27/2024 14:44:24'!
add: account 
	((self accountsIncludes:account) or:(accounts anySatisfy:[:aPortfolioAccount|aPortfolioAccount accountsIncludes:account])) 
		ifTrue:[self error: self class canNotAddAccountErrorMessage].
	accounts add:account.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JP 5/27/2024 02:53:16'!
canNotAddAccountErrorMessage
	^'Cannot add an account that already belongs to a portfolio.'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JP 5/23/2024 21:46:02'!
initializePortfolio
	^self new openPortfolio! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'JP 5/24/2024 15:00:13'!
initializePortfolioWith: aPortfolioAccount
	^self new openPortfolioWith: aPortfolioAccount! !


!Portfolio class methodsFor: 'instance creation' stamp: 'JP 5/24/2024 23:21:38'!
initializePortfolioWith: account1 with: account2 
	"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"
	^self new openPortfolioWith: account1 with: account2 ! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'JP 5/27/2024 14:43:01'!
accountsIncludes: anAccount

	^self = anAccount.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'JP 5/23/2024 17:42:26'!
balance
	|totalDeposits totalWithdrawals|
	
	totalDeposits:= self totalDeposits.
	totalWithdrawals:= self totalWithdrawals.
	^totalDeposits-totalWithdrawals! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'JP 5/23/2024 17:42:13'!
totalDeposits

	^ transactions sum:[:aTransaction | (aTransaction isMemberOf: Deposit) 
			ifTrue:[aTransaction value] 
			ifFalse:[0]] 
		ifEmpty:[0]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'JP 5/23/2024 17:42:26'!
totalWithdrawals

	^ transactions sum:[:aTransaction | (aTransaction isMemberOf: Withdraw) 
			ifTrue:[(aTransaction value)] 
			ifFalse:[0]] 
		ifEmpty:[0]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
