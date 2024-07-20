!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'JP 6/4/2024 18:17:16'!
defaultCatalog
	
	^ Dictionary new add: self itemSellByTheStore->10;yourself.
	"^ Array with: self itemSellByTheStore"! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JP 6/4/2024 18:17:40'!
defaultCatalog
	
	^ Dictionary new add: 'PrideAndPrejudiceAndZombies'->10;yourself.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 21:26:31'!
futureDate

	^ Date year:2030 month:#December day:1! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 21:21:38'!
itemSoldByStore

	^ 'PrideAndPrejudiceAndZombies'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 21:59:04'!
pastDate

	^ Date year:2000 month:#December day:1! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 21:59:23'!
presentDate

	^ Date year:2024 month:#December day:1! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JP 6/4/2024 17:26:05'!
test01CartMustNotBeEmpty

	|carrito catalogo tarjeta|
	
	catalogo:= self defaultCatalog.
	carrito:= Cart acceptingItemsOf: catalogo.
	tarjeta:= Card withLimit:100 andExpirationDate: (self futureDate).
	
	self
		should: [Cashier checksOut:carrito with:tarjeta onTheDay: self presentDate]
		raise: Error-MessageNotUnderstood
		withExceptionDo:[:anError|
			self assert: anError messageText = 'Cart is empty.'.
			self assert: (tarjeta hasRemainingMoney:100).
		]
	
	
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JP 6/4/2024 17:26:33'!
test02CardMustNotBeExpired

	|carrito catalogo tarjeta|
	
	catalogo:= self defaultCatalog.
	carrito:= Cart acceptingItemsOf: catalogo.
	carrito add: self itemSoldByStore.
	tarjeta:= Card withLimit:100 andExpirationDate: (self pastDate).
	
	
	self
		should: [Cashier checksOut:carrito with:tarjeta onTheDay: self presentDate]
		raise: Error-MessageNotUnderstood
		withExceptionDo:[:anError|
			self assert: anError messageText = 'Card has expired.'.
			self assert: (tarjeta hasRemainingMoney:100).
		]
	
	
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'JP 6/5/2024 01:01:23'!
test03PurchaseWithCardIsDoneSuccessfully

	|carrito catalogo tarjeta cajero procesadorMercante|
	
	catalogo:= self defaultCatalog.
	
	carrito:= Cart acceptingItemsOf: catalogo.
	carrito add: self itemSoldByStore.
	
	tarjeta:= Card withLimit:100 andExpirationDate: (self pastDate).
	
	cajero:= Cashier checksOut:carrito with:tarjeta onTheDay: self presentDate.
	
	procesadorMercante:= SimulatedMerchantProcessorModelFace processesTransactionOf:cajero.
	
	! !


!classDefinition: #Card category: #TusLibros!
Object subclass: #Card
	instanceVariableNames: 'expirationDate remainingMoney presentDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Card methodsFor: 'initialization' stamp: 'JP 6/3/2024 21:55:50'!
initializeWithLimit: aMoneyAmount andExpirationDate: aDate 
	remainingMoney := aMoneyAmount.
	expirationDate := aDate.! !

!Card methodsFor: 'initialization' stamp: 'JP 6/3/2024 22:02:42'!
initializeWithLimit: aMoneyAmount andExpirationDate: anExpirationDate atPresentDate: aPresentDate
	remainingMoney := aMoneyAmount.
	expirationDate := anExpirationDate.
	presentDate := aPresentDate.! !


!Card methodsFor: 'queries' stamp: 'JP 6/5/2024 02:12:17'!
remainingMoney
	^remainingMoney! !


!Card methodsFor: 'testing' stamp: 'JP 6/4/2024 17:30:32'!
expirationDate
	^expirationDate! !

!Card methodsFor: 'testing' stamp: 'JP 6/3/2024 21:55:29'!
hasRemainingMoney: anAmount
	^remainingMoney=anAmount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #TusLibros!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'instance creation' stamp: 'JP 6/3/2024 21:51:08'!
withLimit: aMoneyAmount andExpirationDate: aDate
	^self new initializeWithLimit: aMoneyAmount andExpirationDate: aDate! !


!classDefinition: #Cart category: #TusLibros!
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


!Cart methodsFor: 'assertions' stamp: 'JP 6/4/2024 18:16:11'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'JP 6/5/2024 01:45:32'!
totalPrice
	^items sum:[:anItem|catalog at:anItem]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart card presentDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'queries' stamp: 'JP 6/5/2024 02:09:51'!
card
	^card! !


!Cashier methodsFor: 'initialization' stamp: 'JP 6/4/2024 17:24:05'!
initializeChecksOut: carrito with: tarjeta onTheDay: presentDay 
	cart := carrito.
	card:= tarjeta.
	presentDate := presentDay.! !

!Cashier methodsFor: 'initialization' stamp: 'JP 6/5/2024 01:45:46'!
totalPrice
	^cart totalPrice! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'JP 6/3/2024 22:00:50'!
checksOut: aCart with: aCard
	(aCart isEmpty) ifTrue:[self error:'Cart is empty.'].
	(aCard hasExpired) ifTrue:[self error:'Card has expired.'].
	
	^self new initializeChecksOut: aCart with: aCard ! !

!Cashier class methodsFor: 'instance creation' stamp: 'JP 6/4/2024 17:32:18'!
checksOut: aCart with: aCard onTheDay: presentDay 
	(aCart isEmpty) ifTrue:[self error:'Cart is empty.'].
	(self hasCard: aCard expiredBy: presentDay) ifTrue:[self error:'Card has expired.'].

	^self new initializeChecksOut: aCart with: aCard onTheDay: presentDay ! !

!Cashier class methodsFor: 'instance creation' stamp: 'JP 6/4/2024 17:31:56'!
hasCard: aCard expiredBy: presentDay

	^ aCard expirationDate < presentDay! !


!classDefinition: #SimulatedMerchantProcessorModelFace category: #TusLibros!
Object subclass: #SimulatedMerchantProcessorModelFace
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimulatedMerchantProcessorModelFace class' category: #TusLibros!
SimulatedMerchantProcessorModelFace class
	instanceVariableNames: ''!

!SimulatedMerchantProcessorModelFace class methodsFor: 'as yet unclassified' stamp: 'JP 6/5/2024 02:13:47'!
processesTransactionOf:aCashier
	|card|
	card:=aCashier card.
	"(card remainingMoney < aCashier totalPriceInCart) ifTrue:[^self error:'Insufficient funds.']"
	
	! !
