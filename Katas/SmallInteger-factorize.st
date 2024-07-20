'From Cuis6.3 [latest update: #6169] on 9 May 2024 at 11:49:06 pm'!

!SmallInteger methodsFor: 'factorize' stamp: 'JP 5/9/2024 23:46:33'!
factorize
	|answer numberToFactorize|
	self=1 ifTrue:[^Bag new.].
	answer:=Bag new.
	numberToFactorize:=self.
	
	[numberToFactorize>1] whileTrue:[|listOfPossiblePrimes primeDivisor|
		"numberToFactorize isPrime ifTrue:[
			answer add:numberToFactorize.
			^answer.
			]."
		listOfPossiblePrimes:=Integer primesUpTo:numberToFactorize.
		primeDivisor:=listOfPossiblePrimes detect:[:prime| numberToFactorize isDivisibleBy: prime] ifNone:[
			answer add:numberToFactorize.
			^answer.].
		numberToFactorize:=numberToFactorize/primeDivisor.
		answer add:primeDivisor.
		].
	
	^answer.
	
	"|numberToFactorize powerOfTwo answer|
	self=1 ifTrue:[^Bag new.].
	(self=2 or: self=3) ifTrue:[^Bag with: self.].
	
	(self isDivisibleBy:2) ifTrue:[
	answer:=Bag new.
	powerOfTwo:=0.
	numberToFactorize:=self copy.
	[numberToFactorize>1] whileTrue:[
		numberToFactorize:=numberToFactorize/2.
		powerOfTwo:=powerOfTwo+1.].
	
	powerOfTwo timesRepeat:[answer add:2].
	
	^answer.].

	(self isDivisibleBy:3) ifTrue:[|powerOfThree|
	answer:=Bag new.
	powerOfThree:=0.
	numberToFactorize:=self copy.
	[numberToFactorize>1] whileTrue:[
		numberToFactorize:=numberToFactorize/3.
		powerOfThree:=powerOfThree+1.].
	
	powerOfThree timesRepeat:[answer add:3].
	
	^answer.]"
	! !
