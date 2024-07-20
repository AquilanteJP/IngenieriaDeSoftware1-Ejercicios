'From Cuis6.3 [latest update: #6350] on 19 July 2024 at 9:47:13 pm'!
!classDefinition: #RomanConverter category: #TDDBabyStepsGameRomanNumerals!
Object subclass: #RomanConverter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameRomanNumerals'!

!RomanConverter methodsFor: 'as yet unclassified' stamp: 'JP 7/2/2024 21:47:11'!
assertIsGreaterThanZero: anArabicNumber

	^ (anArabicNumber > 0) ifFalse: [self error:'Less than 1 numbers cannot be converted to romans']! !

!RomanConverter methodsFor: 'as yet unclassified' stamp: 'JP 7/2/2024 21:49:20'!
assertIsLessThanFourThousand: anArabicNumber

	^ (anArabicNumber < 4000) ifFalse:[self error:'Greater than 3999 numbers cannot be converted to romans']! !

!RomanConverter methodsFor: 'as yet unclassified' stamp: 'JP 7/2/2024 21:45:48'!
assertIsNumeric: anArabicNumber

	^ (anArabicNumber isNumber) ifFalse:[self error:'Arabig number must be numeric']! !

!RomanConverter methodsFor: 'as yet unclassified' stamp: 'JP 7/2/2024 21:38:42'!
convertHundredsToRoman: centenas onStream: numberStream

	((centenas > 0) and: (centenas < 4)) ifTrue:[
		centenas timesRepeat: [numberStream nextPut:$C].
		].
	(centenas = 4) ifTrue: [numberStream nextPut:$C.numberStream nextPut:$D.].
	((centenas >= 5) and: (centenas < 9)) ifTrue:[
		numberStream nextPut:$D.
		(centenas-5) timesRepeat: [numberStream nextPut:$C].
		].
	(centenas = 9) ifTrue: [numberStream nextPut:$C.numberStream nextPut:$M.]! !

!RomanConverter methodsFor: 'as yet unclassified' stamp: 'JP 7/2/2024 21:34:57'!
convertTensToRoman: decenas onStream: numberStream

	((decenas> 0) and: (decenas < 4)) ifTrue:[
		decenas timesRepeat: [numberStream nextPut:$X].
		].
	(decenas = 4) ifTrue: [numberStream nextPut:$X.numberStream nextPut:$L.].
	((decenas >= 5) and: (decenas < 9)) ifTrue:[
		numberStream nextPut:$L.
		(decenas-5) timesRepeat: [numberStream nextPut:$X].
		].
	(decenas = 9) ifTrue: [numberStream nextPut:$X.numberStream nextPut:$C.]! !

!RomanConverter methodsFor: 'as yet unclassified' stamp: 'JP 7/2/2024 21:44:20'!
convertThousandsToRoman: miles onStream: numberStream

	((miles > 0) and: (miles < 4)) ifTrue:[
		miles timesRepeat: [numberStream nextPut:$M].
		].
	"(miles = 4) ifTrue: [numberStream nextPut:$C.numberStream nextPut:$.]."
	"((miles >= 5) and: (miles < 9)) ifTrue:[
		numberStream nextPut:$D.
		(miles-5) timesRepeat: [numberStream nextPut:$C].
		].
	(miles = 9) ifTrue: [numberStream nextPut:$C.numberStream nextPut:$M.]"! !

!RomanConverter methodsFor: 'as yet unclassified' stamp: 'JP 7/2/2024 21:31:21'!
convertUnitsToRoman: unidades onStream: numberStream

	((unidades > 0) and: (unidades < 4)) ifTrue:[
		unidades timesRepeat: [numberStream nextPut:$I].
		].
	(unidades = 4) ifTrue: [numberStream nextPut:$I.numberStream nextPut:$V.].
	((unidades >= 5) and: (unidades < 9)) ifTrue:[
		numberStream nextPut:$V.
		(unidades-5) timesRepeat: [numberStream nextPut:$I].
		].
	(unidades = 9) ifTrue: [numberStream nextPut:$I.numberStream nextPut:$X.]! !

!RomanConverter methodsFor: 'as yet unclassified' stamp: 'JP 7/2/2024 21:49:20'!
toRoman: anArabicNumber
	|numberStream unidades decenas centenas miles|
	
	self assertIsNumeric: anArabicNumber.
	self assertIsGreaterThanZero: anArabicNumber.
	self assertIsLessThanFourThousand: anArabicNumber.
	
	numberStream:=String new writeStream.
	
	miles:=(anArabicNumber // 10 // 10 // 10) \\ 10.
	self convertThousandsToRoman: miles onStream: numberStream.
	
	centenas:=(anArabicNumber // 10 // 10) \\ 10.
	self convertHundredsToRoman: centenas onStream: numberStream.
	
	decenas:=(anArabicNumber // 10) \\ 10.
	self convertTensToRoman: decenas onStream: numberStream.
	
	unidades:=anArabicNumber \\ 10.
	self convertUnitsToRoman: unidades onStream: numberStream.
	
	^(numberStream contents).
	
	! !
