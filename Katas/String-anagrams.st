'From Cuis6.3 [latest update: #6169] on 9 May 2024 at 11:50:28 pm'!

!String methodsFor: 'cosa turbia falopa' stamp: 'JP 5/9/2024 22:13:15'!
anagrams
	|answer|
	self isEmpty ifTrue:[^Set with:self].
	answer:=Set new.
	self permutationsDo: [:permutations | answer add: permutations copy].
	^answer
	
	
	
	"|firstSwap secondSwap|
	(self isEmpty or: (self size=1)) ifTrue:[^Set with:self].
	(self size=2) ifTrue:[^Set with: self with: (self reversed)].
	firstSwap:=self copy.
	secondSwap:=self copy.
	​firstSwap swap:1 with:2.
	secondSwap swap:2 with:3.
	^Set with: self with: (self reversed) with: firstSwap with: (firstSwap reversed) with: secondSwap with: (secondSwap reversed)"
	
	! !
