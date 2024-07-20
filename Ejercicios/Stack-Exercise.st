!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'JP 4/21/2024 19:43:53'!
initialize
	contents:=OrderedCollection new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:04:26'!
isEmpty
	
	^(self state) isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:05:52'!
pop
	
	^(self state) pop.
	"|mostRecent|
	(self isEmpty)ifTrue:[self error: OOStack stackEmptyErrorDescription].
	
	mostRecent:=contents at:1.
	contents removeFirst.
	^mostRecent."! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:06:17'!
push: elementToPush 
	
	^(self state) push: elementToPush.

	"mostRecent := elementToPush.
	contents addFirst: elementToPush."! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:06:45'!
size
	^(self state) size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 23:58:43'!
state
	|currentState|
	currentState:=((OOStackState allSubclasses select:[
		:aSubclass | aSubclass identifyOwnStack: contents]) at:1) new.
	currentState viewStack:contents.
	^currentState
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:07:04'!
top
	^(self state) top.
	
	"(self isEmpty = true) ifTrue: [
		self error: OOStack stackEmptyErrorDescription ].
	^contents at: 1."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:04:47'!
isEmpty
	self subclassResponsibility  ! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'JP 4/23/2024 15:59:36'!
pop
	self subclassResponsibility  ! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:16:48'!
push: anElementToPush
	contents addFirst:anElementToPush. ! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 15:28:24'!
size
	^contents size. ! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'JP 4/23/2024 16:00:10'!
top
	self subclassResponsibility  ! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 23:57:28'!
viewStack: stackContents
	contents:=stackContents! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:09:59'!
identifyOwnStack: contentsOfAStack
	self subclassResponsibility  ! !


!classDefinition: #OOStackStateEmpty category: #'Stack-Exercise'!
OOStackState subclass: #OOStackStateEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:04:57'!
isEmpty
	^true.! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 15:25:41'!
pop
	^self error: OOStack stackEmptyErrorDescription! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 15:33:01'!
top
	^self error: OOStack stackEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateEmpty class' category: #'Stack-Exercise'!
OOStackStateEmpty class
	instanceVariableNames: ''!

!OOStackStateEmpty class methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:10:27'!
identifyOwnStack: contentsOfAStack
	^contentsOfAStack size=0.! !


!classDefinition: #OOStackStateNonEmpty category: #'Stack-Exercise'!
OOStackState subclass: #OOStackStateNonEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateNonEmpty methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:05:15'!
isEmpty
	^false.! !

!OOStackStateNonEmpty methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 15:32:53'!
pop
	| mostRecent |
	mostRecent:=self top.
	contents removeFirst.
	^mostRecent.! !

!OOStackStateNonEmpty methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 15:32:42'!
top
	^contents at:1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateNonEmpty class' category: #'Stack-Exercise'!
OOStackStateNonEmpty class
	instanceVariableNames: ''!

!OOStackStateNonEmpty class methodsFor: 'as yet unclassified' stamp: 'JP 4/24/2024 17:10:53'!
identifyOwnStack: contentsOfAStack
	^(contentsOfAStack size=0) not.! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'storageStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'JP 4/25/2024 00:31:56'!
add:aSentence
	storageStack add:aSentence.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'JP 4/25/2024 15:57:15'!
findSentencesWithPrefix:aPrefix
	|answer stackToUnstack currentSentence|
	answer:=OrderedCollection new.
	stackToUnstack:=storageStack.
	(stackToUnstack size) timesRepeat: 
		[currentSentence:=stackToUnstack pop.
		 (currentSentence is: aPrefix substringAt: 1) 
			ifTrue:[answer add:currentSentence].
		].
	^answer. 
	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'JP 4/25/2024 00:31:45'!
initialize
	storageStack:=OOStack new.! !
