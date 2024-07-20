!classDefinition: #CartTest category: #'TusLibros-Ejercicio'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 01:57:25'!
test01EmptyCartHasNoBooks
	|carrito isbn1 catalogo |
	
	isbn1:='0-7645-2641-3'.
	catalogo:=BookCatalog withBooks: (OrderedCollection with:isbn1).
	carrito := Cart forUserID:1 withPassword:'password' fromCatalog:catalogo.
	
	self assert: (carrito listSize = 0).
	self deny: (carrito hasBook:isbn1).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 01:57:25'!
test02CartAddsABookCorrectly
	|carrito isbn1 catalogo |
	
	isbn1:='0-7645-2641-3'.
	catalogo:=BookCatalog withBooks: (OrderedCollection with:isbn1).
	
	carrito := Cart forUserID:1 withPassword:'password' fromCatalog:catalogo.
	carrito addToCart:isbn1 amount:1.
	
	self assert: (carrito listSize = 1).
	self assert: (carrito hasBook:isbn1).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 02:02:17'!
test03CartAddsMultipleBooksCorrectly
	|carrito isbn1 isbn2 catalogo |
	
	isbn1:='0-7645-2641-3'.
	isbn2:='0-7645-2641-4'.
	catalogo:=BookCatalog withBooks: (OrderedCollection with:isbn1 with:isbn2).
	carrito := Cart forUserID:1 withPassword:'password' fromCatalog:catalogo.
	carrito addToCart:isbn1 amount:1.
	carrito addToCart: isbn2 amount:10.
	
	self assert: (carrito listSize = 11).
	self assert: (carrito hasBook:isbn1 withAmount:1).
	self assert: (carrito hasBook:isbn2 withAmount:10).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 02:02:41'!
test04CannotAddZeroBooks
	|carrito isbn1 catalogo |
	
	isbn1:='0-7645-2641-3'.
	catalogo:=BookCatalog withBooks: (OrderedCollection with:isbn1).
	carrito := Cart forUserID:1 withPassword:'password' fromCatalog:catalogo.
	
	self 
		should: [ carrito addToCart:isbn1 amount:0.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart canNotAddZeroBooksErrorMessage equals: anError messageText.
			self assert: carrito listSize = 0.
			]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 01:57:25'!
test05CannotAddABookThatDoesntBelongToCatalog
	|carrito catalogo isbn1 isbn2|
	
	isbn1:='0-7645-2641-3'.
	isbn2:='0-7645-2641-4'.
	catalogo:=BookCatalog withBooks: (OrderedCollection with:isbn1).
	carrito := Cart forUserID:1 withPassword:'password' fromCatalog:catalogo.
	
	self 
		should: [ carrito addToCart:isbn2 amount:1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Cart canNotAddBookOffCatalogueErrorMessage equals: anError messageText.
			self assert: carrito listSize = 0.
			]! !


!classDefinition: #BookCatalog category: #'TusLibros-Ejercicio'!
Object subclass: #BookCatalog
	instanceVariableNames: 'listOfBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!BookCatalog methodsFor: 'initialization' stamp: 'JP 6/3/2024 01:59:12'!
hasBook:anISBN
	^listOfBooks includes:anISBN.! !

!BookCatalog methodsFor: 'initialization' stamp: 'JP 6/3/2024 01:58:24'!
with:aListOfISBN
	listOfBooks:=aListOfISBN.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookCatalog class' category: #'TusLibros-Ejercicio'!
BookCatalog class
	instanceVariableNames: ''!

!BookCatalog class methodsFor: 'as yet unclassified' stamp: 'JP 6/3/2024 02:00:34'!
withBooks:aListOfISBN
	^self new with:aListOfISBN
	! !


!classDefinition: #Cart category: #'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'userID list catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'initialization' stamp: 'JP 6/3/2024 01:12:56'!
initializeForUserID: anUserId withPassword: theirCorrespondingPassword 
	userID := anUserId.
	list:= OrderedCollection new.
	! !

!Cart methodsFor: 'initialization' stamp: 'JP 6/3/2024 01:44:32'!
initializeForUserID: anUserID withPassword: theirCorrespondingPassword fromCatalog: aCatalog 
	userID := anUserID.
	catalog := aCatalog.
	list:= OrderedCollection new.! !


!Cart methodsFor: 'interface' stamp: 'JP 6/3/2024 01:45:33'!
addToCart: anISBNNumber  amount: aBookAmount
	self assertBookIsOnSale: anISBNNumber.
	self assertAmountIsNotZero:aBookAmount.
	aBookAmount timesRepeat:[list add:anISBNNumber].! !


!Cart methodsFor: 'testing' stamp: 'JP 6/3/2024 01:55:27'!
assertAmountIsNotZero: aBookAmount 
	(aBookAmount=0) ifTrue:[self error: self class canNotAddZeroBooksErrorMessage].! !

!Cart methodsFor: 'testing' stamp: 'JP 6/3/2024 02:03:04'!
assertBookIsOnSale: anISBNNumber 
	(catalog hasBook:anISBNNumber) ifFalse:[self error:self class canNotAddBookOffCatalogueErrorMessage].! !

!Cart methodsFor: 'testing' stamp: 'JP 6/2/2024 23:18:20'!
hasBook: isbn1 
	^list includes:isbn1.! !

!Cart methodsFor: 'testing' stamp: 'JP 6/2/2024 23:48:57'!
hasBook: anISBN withAmount: anAmount
	^(list occurrencesOf:anISBN) = anAmount.! !

!Cart methodsFor: 'testing' stamp: 'JP 6/2/2024 22:54:06'!
listSize
	^list size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'JP 6/3/2024 00:33:17'!
canNotAddZeroBooksErrorMessage
	'Cannot add an amount of books that is less than one.'! !

!Cart class methodsFor: 'instance creation' stamp: 'JP 6/2/2024 22:47:23'!
forUserID: anUserID withPassword: theirCorrespondingPassword 
	^self new initializeForUserID: anUserID  withPassword: theirCorrespondingPassword! !

!Cart class methodsFor: 'instance creation' stamp: 'JP 6/3/2024 01:41:27'!
forUserID: anUserID withPassword: theirCorrespondingPassword fromCatalog: aCatalog
	^self new initializeForUserID: anUserID  withPassword: theirCorrespondingPassword fromCatalog: aCatalog! !


!Cart class methodsFor: 'errors' stamp: 'JP 6/3/2024 01:53:53'!
canNotAddBookOffCatalogueErrorMessage
	'Cannot add book that is not part of the stores catalog.'! !
