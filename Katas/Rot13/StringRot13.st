'From Cuis6.3 [latest update: #6169] on 6 May 2024 at 12:59:25 am'!
!classDefinition: #String category: #'Kernel-Text'!
CharacterSequence variableByteSubclass: #String
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Kernel-Text'!
!String commentStamp: 'jmv 12/7/2022 09:34:19' prior: 0!
A String is an indexed collection of Characters. In Cuis, Characters are represented in the Latin-9 (ISO 8859-15) encoding. Each character takes 1 byte.

String support a vast array of useful methods, which can best be learned by browsing and trying out examples as you find them in the code.

Here are a few useful methods to look at...
	String match:
	String contractTo:

String also inherits many useful methods from its hierarchy, such as
	SequenceableCollection ,
	SequenceableCollection copyReplaceAll:with:

See UnicodeString.!


!String methodsFor: 'accessing' stamp: 'jmv 9/2/2016 11:03:45'!
at: index 
	"Primitive. Answer the Character stored in the field of the receiver
	indexed by the argument. Fail if the index argument is not an Integer or
	is out of bounds. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 63>
	^Character numericValue: (super at: index)! !

!String methodsFor: 'accessing' stamp: 'jmv 6/6/2022 10:40:54'!
at: index put: aCharacter 
	"Primitive. Store the Character in the field of the receiver indicated by
	the index. Fail if the index is not an Integer or is out of bounds, or if
	the argument is not a Character. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 64>
	aCharacter isCharacter
		ifTrue: [	
			(aCharacter is: #Character)
				ifFalse: [
					aCharacter asCharacter
						ifNotNil: [ :ch | ^self at: index put: ch ]
						ifNil: [self error: 'String only store code points in the ISO 8859-15 set']]
				ifTrue: [
					index isInteger
						ifTrue: [self errorSubscriptBounds: index]
						ifFalse: [self errorNonIntegerIndex]]]
		ifFalse: [self error: 'Strings only store Characters']! !

!String methodsFor: 'accessing' stamp: 'jmv 4/26/2022 15:36:45'!
byteSize
	^self size! !

!String methodsFor: 'accessing' stamp: 'jmv 12/7/2022 09:34:40'!
findString: subString startingAt: start
	"Answer the index of subString within the receiver, starting at start. If 
	the receiver does not contain subString, answer 0."

	"An ASCII UnicodeString is has same bytes as its String equivalent"
	(subString isUnicodeString and: [subString isAscii]) ifTrue: [
		^ String findString: subString bytes in: self startingAt: start ].
	"Do conversions if needed"
	subString isByteString ifFalse: [
		^ self asUnicodeString findString: subString startingAt: start ].
	"Quick primitive if both String"
	^ String findString: subString in: self startingAt: start! !

!String methodsFor: 'accessing' stamp: 'jmv 12/7/2022 09:34:43'!
findStringCaseInsensitive: subString startingAt: start
	"Answer the index in this String at which the substring key first occurs, at or beyond start.
	If no match is found, zero will be returned."

	"An ASCII UnicodeString is has same bytes as its String equivalent"
	(subString isUnicodeString and: [ subString isAscii ]) ifTrue: [
		^String findStringIgnoreCase: subString bytes in: self startingAt: start ].
	"Do conversions if needed"
	subString isByteString ifFalse: [
		^self asUnicodeString findStringCaseInsensitive: subString startingAt: start ].
	"Quick primitive if both String"
	^String findStringIgnoreCase: subString in: self startingAt: start! !

!String methodsFor: 'accessing' stamp: 'jmv 9/11/2023 17:58:09'!
indexOf: aCharacter startingAt: start ifAbsent: aBlock
	| ans |
	aCharacter isCharacter ifFalse: [ ^ aBlock value ].
	ans := ByteArray indexOfByte: aCharacter iso8859s15Code inBytes: self startingAt: start.
	^ans = 0
		ifTrue: [ aBlock value ]
		ifFalse: [ ans ]! !

!String methodsFor: 'accessing' stamp: 'jmv 9/11/2023 13:16:35'!
indexOfAnyOf: aCharacterSet  startingAt: start ifAbsent: aBlock
	"returns the index of the first character in the given set, starting from start"

	| answer |
	answer := ByteArray findFirstInBytes: self inSet: aCharacterSet byteArrayMap startingAt: start.

	^answer = 0 
		ifTrue: [ aBlock value ]
		ifFalse: [ answer]! !

!String methodsFor: 'accessing' stamp: 'jmv 4/28/2022 15:10:55'!
isLastLineSeparator
	^self last isLineSeparator! !

!String methodsFor: 'accessing' stamp: 'jmv 4/28/2022 15:51:10'!
isLastSeparator
	^self last isSeparator! !

!String methodsFor: 'accessing' stamp: 'jmv 6/26/2022 15:00:38'!
lineIndicesDo: aBlock
	"execute aBlock with 3 arguments for each line:
	- start index of line
	- end index of line without line delimiter
	- end index of line including line delimiter(s) CR, LF or CRLF"

	String string: self lineIndicesDo: aBlock! !

!String methodsFor: 'accessing' stamp: 'jmv 1/13/2017 09:58:04'!
replaceFrom: start to: stop with: replacement startingAt: repStart 
	"Primitive. This destructively replaces elements from start to stop in the receiver starting at index, repStart, in the collection, replacement. Answer the receiver. Range checks are performed in the primitive only. Optional. See Object documentation whatIsAPrimitive."

	<primitive: 105 error: ec>
	super replaceFrom: start to: stop with: replacement startingAt: repStart! !

!String methodsFor: 'accessing' stamp: 'ST-80 5/31/1983 9:10:35'!
size
	"Answer the number of indexable fields in the receiver. This value is the 
	same as the largest legal subscript. Primitive is specified here to override 
	SequenceableCollection size. Essential. See Object documentation 
	whatIsAPrimitive. "

	<primitive: 62>
	^self basicSize! !


!String methodsFor: 'comparing' stamp: 'jmv 6/28/2022 12:49:45'!
< aString
	"Answer whether the receiver sorts before aString.
	The collation order is case sensitive."

	"Any object is equal to itself"
	self == aString ifTrue: [ ^ false ].

	"Let them handle us"
	aString isByteString ifFalse: [ ^aString > self ].

	^ (String compare: self with: aString) = 1! !

!String methodsFor: 'comparing' stamp: 'jmv 6/28/2022 12:49:40'!
<= aString
	"Answer whether the receiver sorts before or equal to aString.
	The collation order is case sensitive."

	"Any object is equal to itself"
	self == aString ifTrue: [ ^ true ].

	"Let them handle us"
	aString isByteString ifFalse: [ ^aString >= self ].

	^ (String compare: self with: aString) <= 2! !

!String methodsFor: 'comparing' stamp: 'jmv 12/7/2022 09:07:39'!
= aString
	"Answer whether the receiver sorts equally as aString.
	This means same characters in same order.
	Argument could be instance of String, Symbol, Text, UnicodeString, UnicodeSymbol."

	"Any object is equal to itself"
	self == aString ifTrue: [ ^ true ].

	"If argument is not a kind of String or Symbol, maybe it is a Text?"
	aString isString ifFalse: [
		(aString is: #Text) ifTrue: [ ^ self = aString string ].
		^ false].

	self size = aString size ifFalse: [
		^false ].

	self hash = aString hash ifFalse: [
		^false ].

	"Let them handle us"
	aString isByteString ifFalse: [
		^aString = self ].

	^String is: self equalTo: aString.! !

!String methodsFor: 'comparing' stamp: 'jmv 6/28/2022 12:49:26'!
> aString
	"Answer whether the receiver sorts after aString.
	The collation order is case sensitive."

	"Any object is equal to itself"
	self == aString ifTrue: [ ^ false ].

	"Let them handle us"
	aString isByteString ifFalse: [ ^aString < self ].

	^ (String compare: self with: aString) = 3! !

!String methodsFor: 'comparing' stamp: 'jmv 6/28/2022 12:49:21'!
>= aString
	"Answer whether the receiver sorts after or equal to aString.
	The collation order is case sensitive."

	"Any object is equal to itself"
	self == aString ifTrue: [ ^ true ].

	"Let them handle us"
	aString isByteString ifFalse: [ ^aString <= self ].

	^ (String compare: self with: aString) >= 2! !

!String methodsFor: 'comparing' stamp: 'jmv 12/7/2022 09:34:37'!
caseInsensitiveLessOrEqual: aString
	"Answer whether the receiver sorts before or equal to aString.
	The collation order is case insensitive."

	"An ASCII UnicodeString is has same bytes as its String equivalent"
	(aString isUnicodeString and: [ aString isAscii ]) ifTrue: [
		^(String compareIgnoreCase: self with: aString bytes) <= 2 ].
	"Do conversions if needed"
	aString isByteString ifFalse: [
		^self asUnicodeString caseInsensitiveLessOrEqual: aString ].
	"Quick primitive if both String"
	^ (String compareIgnoreCase: self with: aString) <= 2! !

!String methodsFor: 'comparing' stamp: 'jmv 9/5/2016 21:14:24'!
crc16
	"Compute a 16 bit cyclic redundancy check."

	| crc |
	crc := 0.
	self do: [:c |
		crc := (crc bitShift: -8) bitXor: (
		 #(	16r0000	16rC0C1	16rC181	16r0140	16rC301	16r03C0	16r0280	16rC241
			16rC601	16r06C0	16r0780	16rC741	16r0500	16rC5C1	16rC481	16r0440
			16rCC01	16r0CC0	16r0D80	16rCD41	16r0F00	16rCFC1	16rCE81	16r0E40
			16r0A00	16rCAC1	16rCB81	16r0B40	16rC901	16r09C0	16r0880	16rC841
			16rD801	16r18C0	16r1980	16rD941	16r1B00	16rDBC1	16rDA81	16r1A40
			16r1E00	16rDEC1	16rDF81	16r1F40	16rDD01	16r1DC0	16r1C80	16rDC41
			16r1400	16rD4C1	16rD581	16r1540	16rD701	16r17C0	16r1680	16rD641
			16rD201	16r12C0	16r1380	16rD341	16r1100	16rD1C1	16rD081	16r1040
			16rF001	16r30C0	16r3180	16rF141	16r3300	16rF3C1	16rF281	16r3240
			16r3600	16rF6C1	16rF781	16r3740	16rF501	16r35C0	16r3480	16rF441
			16r3C00	16rFCC1	16rFD81	16r3D40	16rFF01	16r3FC0	16r3E80	16rFE41
			16rFA01	16r3AC0	16r3B80	16rFB41	16r3900	16rF9C1	16rF881	16r3840
			16r2800	16rE8C1	16rE981	16r2940	16rEB01	16r2BC0	16r2A80	16rEA41
			16rEE01	16r2EC0	16r2F80	16rEF41	16r2D00	16rEDC1	16rEC81	16r2C40
			16rE401	16r24C0	16r2580	16rE541	16r2700	16rE7C1	16rE681	16r2640
			16r2200	16rE2C1	16rE381	16r2340	16rE101	16r21C0	16r2080	16rE041
			16rA001	16r60C0	16r6180	16rA141	16r6300	16rA3C1	16rA281	16r6240
			16r6600	16rA6C1	16rA781	16r6740	16rA501	16r65C0	16r6480	16rA441
			16r6C00	16rACC1	16rAD81	16r6D40	16rAF01	16r6FC0	16r6E80	16rAE41
			16rAA01	16r6AC0	16r6B80	16rAB41	16r6900	16rA9C1	16rA881	16r6840
			16r7800	16rB8C1	16rB981	16r7940	16rBB01	16r7BC0	16r7A80	16rBA41
			16rBE01	16r7EC0	16r7F80	16rBF41	16r7D00	16rBDC1	16rBC81	16r7C40
			16rB401	16r74C0	16r7580	16rB541	16r7700	16rB7C1	16rB681	16r7640
			16r7200	16rB2C1	16rB381	16r7340	16rB101	16r71C0	16r7080	16rB041
			16r5000	16r90C1	16r9181	16r5140	16r9301	16r53C0	16r5280	16r9241
			16r9601	16r56C0	16r5780	16r9741	16r5500	16r95C1	16r9481	16r5440
			16r9C01	16r5CC0	16r5D80	16r9D41	16r5F00	16r9FC1	16r9E81	16r5E40
			16r5A00	16r9AC1	16r9B81	16r5B40	16r9901	16r59C0	16r5880	16r9841
			16r8801	16r48C0	16r4980	16r8941	16r4B00	16r8BC1	16r8A81	16r4A40
			16r4E00	16r8EC1	16r8F81	16r4F40	16r8D01	16r4DC0	16r4C80	16r8C41
			16r4400	16r84C1	16r8581	16r4540	16r8701	16r47C0	16r4680	16r8641
			16r8201	16r42C0	16r4380	16r8341	16r4100	16r81C1	16r8081	16r4040)
			 at: ((crc bitXor: c numericValue) bitAnd: 16rFF) + 1) ].
	^crc! !

!String methodsFor: 'comparing' stamp: 'jmv 12/7/2022 09:07:58'!
hash
	"#hash is implemented, because #= is implemented.
	Note: #hash must be the same for String, Symbol, UnicodeString, UnicodeSymbol and Text
	if they hold same Characters."

	self size >  ByteArray minSizeForHashQuick ifTrue: [
		^ self hashQuick: String hash ].
	^ByteArray
		hashBytes: self
		startingWith: String hash! !

!String methodsFor: 'comparing' stamp: 'jmv 12/7/2022 09:16:38'!
is: subString substringAt: index
	"Answer whether the receiver includes aString as a subcollection at position index.
	The comparison is case-sensitive."

	| sequenceSize subStringBytes |
	index < 1 ifTrue: [ ^false ].
	sequenceSize := subString size.
	sequenceSize = 0 ifTrue: [ ^true].
	self size - index + 1 < sequenceSize ifTrue: [ ^false ].

	"The following method uses a suboptimal algorithm (brute force pattern matching with O(n^2) worst case runtime), but the primitive in C is so fast (assuming large alphabets), that it's still worth using it instead of linear time pure smalltalk implementation. There are some obvious cases when the brute force algorithm is suboptimal, e.g. when the first elements don't match, so let's compare them here before using the primitive."
	(self at: index) = (subString at: 1) ifFalse: [ ^false ].
	sequenceSize = 1 ifTrue: [ ^true ].
	(self at: index+sequenceSize-1) = (subString at: sequenceSize) ifFalse: [ ^false ].
	sequenceSize = 2 ifTrue: [ ^true ].
	(subString isAscii not and: [self isAscii]) ifTrue: [ ^false ].

	"Try to find arguments for the primitive in #findString:in:startingAt: cheaply"
	subStringBytes := nil.
	subString isByteString ifTrue: [
		subStringBytes := subString ].
	(subString isUnicodeString and: [ subString isAscii ]) ifTrue: [
		"Can use #bytes, because it has just ASCII bytes"
		subStringBytes := subString bytes ].
	subStringBytes ifNotNil: [
		^(String findString: subStringBytes in: self startingAt: index) = index ].

	"Do it in Smalltalk. Most likely cheaper than converting argument to String"
	^super is: subString substringAt: index! !

!String methodsFor: 'comparing' stamp: 'jmv 12/7/2022 09:34:51'!
sameAs: aString
	"Answer whether the receiver sorts equal to aString. The 
	collation sequence is ascii with case differences ignored."

	"An ASCII UnicodeString is has same bytes as its String equivalent"
	(aString isUnicodeString and: [aString isAscii]) ifTrue: [
		^ (String compareIgnoreCase: self with: aString bytes) = 2 ].

	"Let them handle us"
	aString isByteString ifFalse: [ ^aString sameAs: self ].

	^ (String compareIgnoreCase: self with: aString) = 2! !


!String methodsFor: 'copying' stamp: 'KenD 9/4/2016 16:50:54'!
, aStringOrText
	^ aStringOrText appendToString: self! !

!String methodsFor: 'copying' stamp: 'KenD 9/4/2016 16:21:53'!
appendToString: aString

	| stringSize |
	stringSize := aString size.
	^ aString copyReplaceFrom: stringSize + 1
		 	    to: stringSize
		   	    with: self! !

!String methodsFor: 'copying' stamp: 'jmv 4/16/2023 17:37:20'!
copyReplaceFrom: start to: stop with: replacementCollection 
	"Answer a copy of the receiver satisfying the following conditions: 
	+ stop is less than start, then this is an insertion; stop should be exactly start-1, 
	+ start = 1 means insert before the first character,
	+ start = size+1 means append after last character. 
	+ Otherwise, this is a replacement; start and stop have to be within the receiver's bounds."

	| rep |
	rep := replacementCollection string.
	rep isUnicodeString ifTrue: [
		^self asUnicodeString copyReplaceFrom: start to: stop with: rep  ].
	^super copyReplaceFrom: start to: stop with: rep.! !

!String methodsFor: 'copying' stamp: 'jmv 12/20/2022 14:25:31'!
copyWith: newElement
	newElement isUnicodeCodePoint ifTrue: [
		^self asUnicodeString copyWith: newElement ].
	^super copyWith: newElement! !


!String methodsFor: 'converting' stamp: 'jmv 5/21/2022 21:26:19'!
asByteString
	"Answer an instance of the Byte oriented String class"
	^self! !

!String methodsFor: 'converting' stamp: 'jmv 7/6/2023 11:10:37'!
asByteStringIfAscii
	"Answer an instance of the Byte oriented String class"
	^self! !

!String methodsFor: 'converting' stamp: 'jmv 12/6/2022 17:30:57'!
asCodePoints
	"Convert the given string to UTF-32 from the internal encoding: ISO Latin 9 (ISO 8859-15).
	Answer a WordArray."

	| inStream nextChar codePoint |
	^WordArray streamContents: [ :outStream |
		inStream := self readStream.
		[ inStream atEnd ] whileFalse: [
			nextChar := inStream next.
			codePoint := nextChar codePoint.
			outStream nextPut: codePoint ]]! !

!String methodsFor: 'converting' stamp: 'jmv 6/13/2022 16:55:56'!
asHex

	^String streamContents: [ :strm |
		self do: [ :ch | strm nextPutAll: ch hex ] separatedBy: [ strm space ]].! !

!String methodsFor: 'converting' stamp: 'jmv 6/10/2022 14:39:20'!
asLowercase
	"Answer a String made up from the receiver whose characters are all 
	lowercase."

	^ self copy asPlainString translateToLowercase! !

!String methodsFor: 'converting' stamp: 'jmv 4/21/2022 14:44:01'!
asUppercase
	"Answer a String made up from the receiver whose characters are all 
	uppercase."

	^self copy asPlainString translateToUppercase! !

!String methodsFor: 'converting' stamp: 'jmv 10/26/2022 15:49:03'!
asUtf8Bytes
	"Convert the given string to UTF-8 from the internal encoding: ISO Latin 9 (ISO 8859-15)
	Answer a ByteArray with a valid UTF-8 sequence."

	| inStream nextChar codePoint |
	"Fast lane."
	self isAscii ifTrue: [ ^self asByteArray ].

	"Need to do UTF-8 encoding."
	^ByteArray streamContents: [ :outStream |
		inStream := self readStream.
		[ inStream atEnd ] whileFalse: [
			nextChar := inStream next.
			codePoint := nextChar codePoint.
			Character
				evaluate: [ :byte | outStream nextPut: byte ]
				withUtf8BytesOfUnicodeCodePoint: codePoint ]]! !

!String methodsFor: 'converting' stamp: 'jmv 6/10/2022 12:21:55'!
asUtf8BytesOrByteString
	"Similar to #asUtf8Bytes.
	May answer an instance of String as an optimization.
	See senders"

	| inStream nextChar codePoint |
	"Fast lane."
	self isAscii ifTrue: [ ^self ].

	"Need to do UTF-8 encoding."
	^ByteArray streamContents: [ :outStream |
		inStream := self readStream.
		[ inStream atEnd ] whileFalse: [
			nextChar := inStream next.
			codePoint := nextChar codePoint.
			Character
				evaluate: [ :byte | outStream nextPut: byte ]
				withUtf8BytesOfUnicodeCodePoint: codePoint ]]! !

!String methodsFor: 'converting' stamp: 'jmv 1/19/2023 13:04:56'!
asUtf8BytesOrByteStringOrByteArray
	"Sometimes, a String or ByteArray will do, but if we have an UnicodeString, we
	want ASCII or UTF-8 bytes."
	
	^self! !

!String methodsFor: 'converting' stamp: 'ls 9/10/1998 08:48'!
capitalized
	"Return a copy with the first letter capitalized"
	| cap |
	self isEmpty ifTrue: [ ^self copy ].
	cap := self copy.
	cap at: 1 put: (cap at: 1) asUppercase.
	^ cap! !

!String methodsFor: 'converting' stamp: 'jmv 6/12/2022 17:39:24'!
fixLineEndings
	"Assume that CR, LF, and CRLF are all valid line endings. Replace each occurence with a single Lf.
	If possible, modify and answer the same instance. Create a new instance only if needed.
	Be quick and don't use extra memory if already using Character lf!!
	('Hello ', String crlfString, 'World') fixLineEndings
	('Hello ', String crString, 'World') fixLineEndings
	('Hello ', String lfString, 'World') fixLineEndings
	"
	(self includes: `Character cr`) ifFalse: [ ^self ].
	(self includesSubString: `String crlfString`) ifTrue: [ "A new instance is needed"
		^ self withLineEndings: `String newLineString` ].
	self replaceAll: `Character cr` with: `Character lf`.! !

!String methodsFor: 'converting' stamp: 'jmv 6/26/2022 14:57:43'!
substrings
	"Answer an array of the substrings that compose the receiver."
	^String substringsIn: self! !

!String methodsFor: 'converting' stamp: 'jmv 4/21/2022 12:20:42'!
surroundedBySingleQuotes
	"Answer the receiver with leading and trailing quotes.  "

	^ `(String with: $')`, self, `(String with: $')`! !

!String methodsFor: 'converting' stamp: 'jmv 8/5/2022 11:41:59'!
thatCanHoldCodePoints
	"See senders.
	Also see #asStreamResult"
	^ArrayOfCharactersAndCodePoints withAll: self! !

!String methodsFor: 'converting' stamp: 'jmv 6/19/2023 22:04:22'!
translateToLowercase
	"Translate all characters to lowercase, in place"

	String translateToLowercase: self! !

!String methodsFor: 'converting' stamp: 'jmv 6/19/2023 22:04:36'!
translateToUppercase
	"Translate all characters to lowercase, in place"

	String translateToUppercase: self! !

!String methodsFor: 'converting' stamp: 'jmv 6/12/2022 18:19:34'!
uncapitalized
	"Answer an object like the receiver but with first character downshifted if necesary
	'MElViN' uncapitalized
	'mElViN' uncapitalized
	('Will', Random next mantissaPart printString) asSymbol uncapitalized
	('will', Random next mantissaPart printString) asSymbol uncapitalized
	"
	| answer |
	self isEmpty ifTrue: [^ self].
	self first isLowercase ifTrue: [ ^self ].
	answer := self asPlainString.
	answer == self ifTrue: ["don't modify receiver"
		answer := self copy ].
	answer at: 1 put: (answer at: 1) asLowercase.
	^ answer! !

!String methodsFor: 'converting' stamp: 'jmv 6/26/2022 14:59:49'!
withLineEndings: lineEndingString
	"assume the string is textual, and that CR, LF, and CRLF are all valid line endings. 
	Answer a new String, where each occurence with is replaced with lineEndingString"

	^ String string: self withLineEndings: lineEndingString! !


!String methodsFor: 'enumerating' stamp: 'jmv 12/7/2022 09:05:55'!
collect: aBlock
	"Refer to the comment in Collection >> #collect:."
	| array resultClass |
	array := self collectInArray: aBlock.
	resultClass := String.
	array do: [ :element |
		element isCharacter ifFalse: [ ^array ].
		(element is: #Character) ifFalse: [
			resultClass := UnicodeString ]].
	^resultClass newFrom: array! !


!String methodsFor: 'printing' stamp: 'ST-80 5/31/1983 9:10:35'!
isLiteral
	^true! !


!String methodsFor: 'services' stamp: 'jmv 9/11/2023 14:31:47'!
numArgs
	"Answer either the number of arguments that the receiver would take if considered a selector. 
	Answer -1 if it couldn't be a selector. 
		Note that currently this will answer -1 for anything begining with an uppercase letter even though 
		the system will accept such symbols as selectors.  It is intended mostly for the assistance of spelling correction."
	| firstChar numColons start ix |
	self isEmpty ifTrue: [ ^ -1 ].
	"Binary messages"
	(self allSatisfy: [ :c | c isValidInBinarySelectors ])
		ifTrue: [ ^1 ].
	"Unary and keyword messages"
	firstChar := self at: 1.
	firstChar isValidStartOfIdentifiers ifTrue: [
		"Fast reject if any chars are non-alphanumeric"
		(String
			findSubstring: `'~' asByteString`
			in: self
			startingAt: 1
			matchTable: String tokenishTable) > 0 ifTrue: [ ^ -1 ].
		"Fast colon count"
		numColons := 0.
		start := 1.
		[ (ix := self findString: ':' startingAt: start) > 0 ] whileTrue: [
			numColons := numColons + 1.
			start := ix + 1 ].
		^ numColons ].
	^ -1.! !


!String methodsFor: 'testing' stamp: 'jmv 12/7/2022 09:34:32'!
canHoldCodePoints
	"Nope. Needs something like UnicodeString for that. Even an Array is better than us."
	^false! !

!String methodsFor: 'testing' stamp: 'jpb 8/3/2019 00:01:22'!
is: aSymbol
	"Note: Senders might prefer #isString for perfomance reasons. Still, Cuis tries to keep isXXX testing selectors to a minimum."
	^#String = aSymbol or: [ super is: aSymbol]! !

!String methodsFor: 'testing' stamp: 'jmv 6/9/2022 15:01:48'!
isAscii
	"Return true when I am pure 7-bit ASCII.
	This means, for example, that my bytes are also my UTF-8 representation."

	^ String isAscii: self! !

!String methodsFor: 'testing' stamp: 'jmv 6/6/2022 10:21:36'!
isByteString
	^ true! !

!String methodsFor: 'testing' stamp: 'jmv 6/8/2022 08:41:33'!
isEmpty
	^self size = 0! !

!String methodsFor: 'testing' stamp: 'jmv 12/11/2022 19:05:30'!
isInCanonicalCompositionForm

	^true! !


!String methodsFor: 'paragraph support' stamp: 'jmv 3/14/2012 08:22'!
encompassLine: anInterval
	"Return an interval that includes anInterval, and that comprises one or several whole paragraphs in the receiver.
	Answer starts at the position following a newLine (or eventually 1) and ends before a newLine (or eventually at self size)
	See also encompassParagraph:"
	| left rightCr rightNull |
	left := (self lastIndexOf: Character newLineCharacter startingAt: anInterval first - 1 ifAbsent:[0]) + 1.
	rightCr := (self indexOf: Character newLineCharacter startingAt: (anInterval last max: anInterval first) ifAbsent: [self size+1])-1.
	rightNull := (self indexOf: Character null startingAt: (anInterval last max: anInterval first) ifAbsent: [self size+1])-1.
	^left to: (rightCr min: rightNull)! !

!String methodsFor: 'paragraph support' stamp: 'jmv 3/14/2012 08:22'!
encompassParagraph: anInterval
	"Return an interval that includes anInterval, and that comprises one or several whole paragraphs in the receiver.
	Answer starts at the position following a newLine (or eventually 1) and ends at a newLine (or eventually at self size).
	Look also for null characters. Never include null characters in the answer.
	See also #encompassLine:"
	| left rightCr rightNull |
	left := (self lastIndexOf: Character newLineCharacter startingAt: anInterval first - 1 ifAbsent:[0]) + 1.
	rightCr := (self indexOf: Character newLineCharacter startingAt: (anInterval last max: anInterval first) ifAbsent: [self size]).
	rightNull := (self indexOf: Character null startingAt: (anInterval last max: anInterval first) ifAbsent: [self size+1])-1.
	^left to: (rightCr min: rightNull)! !


!String methodsFor: '*WebClient' stamp: 'jmv 6/26/2017 19:36:20'!
encodeForHTTP! !

!String methodsFor: '*WebClient' stamp: 'jmv 9/5/2016 20:49:10'!
unescapePercents
	"change each %XY substring to the character with ASCII value XY in hex.  This is the opposite of #encodeForHTTP"
	| ans c asciiVal pos oldPos specialChars |
	ans _ WriteStream on: String new.
	oldPos _ 1.
	specialChars _ '+%' asCharacterSet.

	[pos _ self indexOfAnyOf: specialChars startingAt: oldPos ifAbsent: [ 0 ]. pos > 0 ]
	whileTrue: [
		ans nextPutAll: (self copyFrom: oldPos to: pos - 1).
		c _ self at: pos.
		c = $+ ifTrue: [ans nextPut: $ ] ifFalse: [
			(c = $% and: [pos + 2 <= self size]) ifTrue: [
				asciiVal _ (self at: pos+1) asUppercase digitValue * 16 +
					(self at: pos+2) asUppercase digitValue.
				pos _ pos + 2.
				asciiVal > 255 ifTrue: [^self].	"not really an escaped string"
				ans nextPut: (Character numericValue: asciiVal)]
			ifFalse: [ans nextPut: c]].
		oldPos _ pos+1].
	ans nextPutAll: (self copyFrom: oldPos to: self size).
	^ ans contents! !


!String methodsFor: 'rot13' stamp: 'JP 5/6/2024 00:54:48'!
asRot13

	|rotatedString|
	rotatedString:=self collect:[:char | char asRot13].
	^rotatedString.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'String class' category: #'Kernel-Text'!
String class
	instanceVariableNames: ''!

!String class methodsFor: 'instance creation' stamp: 'sw 8/5/97 13:55'!
crString
	^ self with: Character cr! !

!String class methodsFor: 'instance creation' stamp: 'jmv 8/28/2013 10:27'!
crlfString
	"Answer a string containing a carriage return and a linefeed."

	^ self with: Character cr with: Character lf
! !

!String class methodsFor: 'instance creation' stamp: 'jmv 10/26/2022 15:48:17'!
fromUtf8Bytes: aByteArray
	"Convert the given bytes from UTF-8 to the internal encoding: ISO Latin 9 (ISO 8859-15).
	Discard any code points that can not be represented."

	"Fast lane."
	(String isAscii: aByteArray) ifTrue: [
		^aByteArray asString ].

	"Need to do UTF-8 decoding."
	^self fromUtf8Bytes: aByteArray trimLastNull: false! !

!String class methodsFor: 'instance creation' stamp: 'jmv 10/26/2022 15:43:16'!
fromUtf8Bytes: aByteArray trimLastNull: doTrimLastNullChar
	"Convert the given string from UTF-8 to the internal encoding: ISO Latin 9 (ISO 8859-15).
	Discard any code points that can not be represented."

	^String streamContents: [ :strm | | s byteIndex n |
		s := aByteArray size.
		byteIndex := 1.
		[  byteIndex <= s ] whileTrue: [
			n := Character utf8BytesAndCodePointAt: byteIndex in: aByteArray
				into: nil
				into: [ :codePoint |
					(Character codePoint: codePoint) ifNotNil: [ :char | strm nextPut: char ]].
			byteIndex := byteIndex + n
		].
		(doTrimLastNullChar and: [ aByteArray last = 0 ]) ifTrue: [
			strm position: strm position - 1 ]].! !

!String class methodsFor: 'instance creation' stamp: 'jmv 8/28/2013 10:28'!
lfString
	"Answer a string containing a single Lf character."

	^ self with: Character lf! !

!String class methodsFor: 'instance creation' stamp: 'ST-80 5/31/1983 9:10:35'!
new: size withAll: value
	"Answer a new instance of me, whose every element is equal to the argument,
	value."

	^(self new: size) atAllPut: value! !

!String class methodsFor: 'instance creation' stamp: 'jmv 12/7/2022 09:34:48'!
newFrom: aCollection 
	"Answer an instance of me containing the same elements as aCollection."
	| newArray index |
	newArray := self new: aCollection size.
	index := 0.
	aCollection do: [ :each | newArray at: (index := index + 1) put: each].
	^ newArray

"
	{$c. $h. $r} as: String
	{$c. $h. $r} as: UnicodeString
"! !

!String class methodsFor: 'instance creation' stamp: 'jmv 3/14/2012 08:33'!
newLineString
	"Answer a string containing a single newLine (i.e. Lf) character."

	^ self with: Character newLineCharacter! !

!String class methodsFor: 'instance creation' stamp: 'jmv 4/13/2023 14:42:11'!
percentEscapingNonAscii: aByteArray
	"Percent encode any byte not in the ASCII range:
	replace it with %XX where XX are the hexadecimal digits.
	See https://en.wikipedia.org/wiki/URL_encoding
	
	String percentEscapingNonAscii: '⊙' bytes
	(String percentEscapingNonAscii: '⊙' bytes) unescapePercents
	"

	^String percentEscapingNonAsciiAndThoseIn: nil bytes: aByteArray! !

!String class methodsFor: 'instance creation' stamp: 'jmv 4/13/2023 14:27:36'!
percentEscapingNonAsciiAndThoseIn: aCharacterMap bytes: aByteArray
	"Percent encode any byte not in the ASCII range.
	Also encode any in aCharacterMap.
	Replace them with %XX where XX are the hexadecimal digits.
	See https://en.wikipedia.org/wiki/URL_encoding
	
	String percentEscapingNonAscii: '⊙' bytes
	"

	^String streamContents: [ :strm |
		aByteArray do: [ :byte | | c |
			(byte > 127 or: [
						aCharacterMap isNil or: [
							c := Character asciiValue: byte.
							aCharacterMap includes: c ]])
				ifTrue: [
					strm nextPut: $%.
					strm nextPut: (byte // 16) asHexDigit.
					strm nextPut: (byte \\ 16) asHexDigit ]
				ifFalse: [ strm nextPut: c ]]].! !

!String class methodsFor: 'instance creation' stamp: 'sw 6/15/1999 22:59'!
tab
	"Answer a string containing a single tab character."

	^ self with: Character tab
! !

!String class methodsFor: 'instance creation' stamp: 'ST-80 5/31/1983 9:10:35'!
with: aCharacter 
	"Answer a new instance of me, containing only aCharacter.
	String with: $a
	String with: $á
	String with: Character euro
	"

	| newCollection |
	newCollection := self new: 1.
	newCollection at: 1 put: aCharacter.
	^newCollection! !

!String class methodsFor: 'instance creation' stamp: 'ST-80 5/31/1983 9:10:35'!
with: firstChar with: secondChar
	"Answer a new instance of me, containing firstChar and secondChar.
	String with: $a
	String with: $á with: Character euro
	"

	| newCollection |
	newCollection := self new: 2.
	newCollection at: 1 put: firstChar.
	newCollection at: 2 put: secondChar.
	^newCollection! !

!String class methodsFor: 'instance creation' stamp: 'ST-80 5/31/1983 9:10:35'!
with: firstObject with: secondObject with: thirdObject 
	"Answer a new instance of me, containing only these three objects."

	| newCollection |
	newCollection := self new: 3.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	newCollection at: 3 put: thirdObject.
	^newCollection! !

!String class methodsFor: 'instance creation' stamp: 'jmv 3/7/2015 23:10'!
withAll: aSequenceableCollection
	"Create a new collection containing all the elements from aSequenceableCollection."

	^ (self new: aSequenceableCollection size)
		replaceFrom: 1
		to: aSequenceableCollection size
		with: aSequenceableCollection! !



!String class methodsFor: 'primitives' stamp: 'jmv 6/28/2022 14:45:44'!
translate: aString from: start to: stop table: table
	"translate the characters in the string by the given table, in place"
	<primitive: 'primitiveTranslateStringWithTable' module: 'MiscPrimitivePlugin'>

	start to: stop do: [ :i |
		aString at: i put: (table at: (aString basicAt: i) +1) ]! !


!String class methodsFor: 'character collation' stamp: 'jmv 9/11/2023 14:22:24'!
does: aCharacter caseInsensitiveCollateBefore: otherCharacter
	"
	String does: $a caseInsensitiveCollateBefore: $b
	String does: $a caseInsensitiveCollateBefore: $B
	String does: $A caseInsensitiveCollateBefore: $b
	"
	^ (self caseInsensitiveOrder at: aCharacter numericValue + 1) <
		(self caseInsensitiveOrder at: otherCharacter numericValue + 1)! !

!String class methodsFor: 'character collation' stamp: 'jmv 9/11/2023 14:23:19'!
does: aCharacter collateAfter: otherCharacter
	^ (self caseSensitiveOrder at: aCharacter numericValue + 1) >
		(self caseSensitiveOrder at: otherCharacter numericValue + 1)! !

!String class methodsFor: 'character collation' stamp: 'jmv 9/11/2023 14:23:30'!
does: aCharacter collateBefore: otherCharacter
	^ (self caseSensitiveOrder at: aCharacter numericValue + 1) <
		(self caseSensitiveOrder at: otherCharacter numericValue + 1)! !


!String class methodsFor: 'fileman-constants' stamp: 'jmv 6/6/2015 23:54'!
pathSeparators
	^'\:/'! !


!String class methodsFor: 'system' stamp: 'jmv 6/3/2022 10:29:45'!
symbolClassToUse
	"Answer the class to create symbols from us"
	^Symbol! !


!String class methodsFor: 'stream creation' stamp: 'jmv 6/8/2022 16:15:00'!
writeStream
	^ WriteStream on: (self new: 100)! !


!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 14:23:06'!
compare: string1 with: string2
	"Return 1, 2 or 3, if string1 is <, =, or > string2,
	with the collating order of characters given by the order array."

	^self compare: string1 with: string2 collated: self caseSensitiveOrder! !

!String class methodsFor: 'services' stamp: 'jmv 6/27/2022 15:40:39'!
compare: string1 with: string2 collated: order
	"Return 1, 2 or 3, if string1 is <, =, or > string2, with the collating order of characters given by the order array."

	| len1 len2 c1 c2 |
	<primitive: 'primitiveCompareString' module: 'MiscPrimitivePlugin'>

	len1 := string1 size.
	len2 := string2 size.
	1 to: (len1 min: len2) do:
		[:i |
		c1 := order at: (string1 basicAt: i) + 1.
		c2 := order at: (string2 basicAt: i) + 1.
		c1 = c2 ifFalse: 
			[c1 < c2 ifTrue: [^ 1] ifFalse: [^ 3]]].
	len1 = len2 ifTrue: [^ 2].
	len1 < len2 ifTrue: [^ 1] ifFalse: [^ 3].
! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 14:22:12'!
compareIgnoreCase: string1 with: string2
	"Return 1, 2 or 3, if string1 is <, =, or > string2, 
	with the collating order of characters given by the order array."

	^self compare: string1 with: string2 collated: self caseInsensitiveOrder! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 14:22:49'!
findStringIgnoreCase: subString in: body startingAt: start
	"Answer the index of subString within the receiver, starting at start. If 
	the receiver does not contain subString, answer 0.
	Ignore case"

	^ self findSubstring: subString in: body startingAt: start matchTable: self caseInsensitiveOrder.! !

!String class methodsFor: 'services' stamp: 'jmv 6/28/2022 14:44:38'!
findSubstring: key in: body startingAt: start matchTable: matchTable
	"Answer the index in the string body at which the substring key first occurs, at or beyond start. The match is determined using matchTable, which can be used to effect, eg, case-insensitive matches.  If no match is found, zero will be returned.

	The algorithm below is not optimum -- it is intended to be translated to C which will go so fast that it wont matter."
	| index |
	<primitive: 'primitiveFindSubstring' module: 'MiscPrimitivePlugin'>

	key isEmpty ifTrue: [^ 0].
	start to: body size - key size + 1 do:
		[:startIndex |
		index := 1.
			[(matchTable at: (body basicAt: startIndex+index-1) + 1)
				= (matchTable at: (key basicAt: index) + 1)]
				whileTrue:
				[index = key size ifTrue: [^ startIndex].
				index := index+1]].
	^ 0
"
String findSubstring: 'abc' in: 'abcdefabcd' startingAt: 1 matchTable: CaseSensitiveOrder 1
String findSubstring: 'abc' in: 'abcdefabcd' startingAt: 2 matchTable: CaseSensitiveOrder 7
String findSubstring: 'abc' in: 'abcdefabcd' startingAt: 8 matchTable: CaseSensitiveOrder 0
String findSubstring: 'abc' in: 'abcdefABcd' startingAt: 2 matchTable: CaseSensitiveOrder 0
String findSubstring: 'abc' in: 'abcdefABcd' startingAt: 2 matchTable: CaseInsensitiveOrder 7
"! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 14:23:42'!
is: aStringOrByteArray equalTo: another
	"Take adventage of String primitive for comparing, for example, ByteArrays"

	^ (self compare: aStringOrByteArray with: another collated: self caseSensitiveOrder) = 2! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 13:20:22'!
isAscii: aStringOrByteArray
	"Return true if all bytes in argument are less than 128.
	This means it is a pure 7-bit ASCII.
	Valid both for instances of String (possibly with accented latin letters or other Character)
	and for utf-8 encoded ByteArrays.
	In these cases, the bytes represent the same ascii string both as String and as Utf8.
	See also #nextUtf8BytesAndCodePointInto:into:, #ascii and #nonAscii"

	| nonAsciiBytesMap |
	nonAsciiBytesMap := `(ByteArray new: 128), ((ByteArray new: 128) + 1)`.
	^ (ByteArray
		findFirstInBytes: aStringOrByteArray
		inSet: nonAsciiBytesMap
		startingAt: 1)
			= 0.! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 14:15:47'!
string: aString lineIndicesDo: aBlock
	"execute aBlock with 3 arguments for each line:
	- start index of line
	- end index of line without line delimiter
	- end index of line including line delimiter(s) CR, LF or CRLF"
	
	| start end endWithoutDelimiters |
	start := 1.
	[
		end := aString indexOfAnyOf: self charSetLineEnders startingAt: start ifAbsent: [ 0 ].
		end = 0
			ifTrue: [
				"Last line was found. Evaluate and exit.
				Note. If last char in receiver is a line separator, there's an extra empty line"
				endWithoutDelimiters := end := aString size.
				aBlock value: start value: endWithoutDelimiters value: end.
				^aString ].

		"Account for CrLf sequence"
		endWithoutDelimiters := end - 1.
		(end < aString size
			and: [(aString basicAt: end + 1) = `Character lf codePoint`
			and: [(aString basicAt: end) = `Character cr codePoint` ]])
				ifTrue: [ end := end + 1].

		aBlock value: start value: endWithoutDelimiters value: end.
		start := end + 1 ] repeat! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 18:04:12'!
string: aString withLineEndings: lineEndingString
	"assume the string is textual, and that CR, LF, and CRLF are all valid line endings. 
	Answer a new String, where each occurence with is replaced with lineEndingString"
	| cr lf crlf inPos outPos outString lineEndPos newOutPos lineEndingSize |
	cr := Character cr.
	lf := Character lf.
	crlf := `CharacterSet new
			add: Character cr; add: Character lf; yourself`.
	(aString is: #ByteArray)
		ifTrue: [
			cr := cr asciiValue.
			lf := lf asciiValue ].

	inPos := 1.
	outPos := 1.
	lineEndingSize := lineEndingString size.
	"This could be extremely inefficient if lineEndingString size > 1"
	outString := aString class new: aString size * lineEndingSize.

	[
		lineEndPos := aString indexOfAnyOf: crlf startingAt: inPos ifAbsent: [0].
		lineEndPos ~= 0 ] whileTrue: [
			newOutPos := outPos + (lineEndPos - inPos).
			outString replaceFrom: outPos to: newOutPos - 1 with: aString startingAt: inPos.
			1 to: lineEndingSize do: [ :i |
				outString at: newOutPos put: (lineEndingString at: i).
				newOutPos := newOutPos + 1 ].
			outPos := newOutPos.
			((aString at: lineEndPos) = cr and: [ lineEndPos < aString size and: [ (aString at: lineEndPos+1) = lf ] ]) ifTrue: [
				"CRLF ending"
				inPos := lineEndPos + 2 ]
			ifFalse: [ 
				"CR or LF ending"
				inPos := lineEndPos + 1 ]. ].

	"no more line endings.  copy the rest"
	newOutPos := outPos + (aString size - inPos).
	outString replaceFrom: outPos to: newOutPos with: aString startingAt: inPos.

	^outString copyFrom: 1 to: newOutPos! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 14:16:57'!
substringsIn: aByteStringOrByteArray
	"Answer an array of the substrings that compose the argument.
	If argument is an UTF-8 encoded ByteArray, answer is an array of same."

	| end beginning |
	end := 0.
	^Array streamContents: [ :result |
		"find one substring each time through this loop"
		[ 
			"find the beginning of the next substring"
			beginning := aByteStringOrByteArray indexOfAnyOf: self charSetNonSeparators startingAt: end+1 ifAbsent: nil.
			beginning notNil ] 
		whileTrue: [
			"find the end"
			end := aByteStringOrByteArray indexOfAnyOf: self charSetSeparators startingAt: beginning ifAbsent: [ aByteStringOrByteArray size + 1 ].
			end := end - 1.
			result nextPut: (aByteStringOrByteArray copyFrom: beginning to: end).
		]
	].! !

!String class methodsFor: 'services' stamp: 'jmv 6/19/2023 22:02:28'!
translate: aStringOrByteArray table: table
	"translate the characters in the string by the given table, in place"
	self translate: aStringOrByteArray from: 1 to: aStringOrByteArray size table: table! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 14:30:57'!
translateToLowercase: aStringOrByteArray
	"translate the characters in the string by the given table, in place"
	self translate: aStringOrByteArray from: 1 to: aStringOrByteArray size table: self lowercasingTable! !

!String class methodsFor: 'services' stamp: 'jmv 9/11/2023 14:31:14'!
translateToUppercase: aStringOrByteArray
	"translate the characters in the string by the given table, in place"
	self translate: aStringOrByteArray from: 1 to: aStringOrByteArray size table: self uppercasingTable! !


!String class methodsFor: 'accessing' stamp: 'jmv 9/11/2023 14:23:35'!
findString: subString in: body startingAt: start
	"Answer the index of subString within the receiver, starting at start. If 
	the receiver does not contain subString, answer 0."

	^ self findSubstring: subString in: body startingAt: start matchTable: self caseSensitiveOrder.! !


!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:20:24'!
basicCaseInsensitiveOrder
	"Case insensitive compare sorts null, space, digits, letters, all the rest..."
	| newOrder order |
	newOrder := Array new: 256.
	order := -1.
	newOrder at: 0+1 put:  (order := order+1).
	32 to: 64 do: [ :c |
		newOrder at: c + 1 put: (order := order+1)].
	#(92 94 124 126 183 215 247) do: [ :c | "\^|~·÷×"
		newOrder at: c + 1 put: (order := order+1)].
	16r90 to: 16r9F do: [:c| "special math operators"
		newOrder at: c + 1 put: (order := order+1)].
	Character uppercaseLowercaseAndUnaccentedLetters do: [ :upperAndLowercase |
		order := order+1.
		newOrder at: upperAndLowercase first numericValue + 1 put: order.
		upperAndLowercase size > 1 ifTrue: [
			newOrder at: upperAndLowercase second numericValue + 1 put: order ]].
	1 to: newOrder size do: [ :i |
		(newOrder at: i) ifNil: [
			newOrder at: i put: (order := order+1)]].
	^newOrder asByteArray.! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:21:00'!
basicCaseSensitiveOrder
	"Case sensitive compare sorts null, space, digits, letters, all the rest..."
	| newOrder order lowercase |
	newOrder := Array new: 256.
	order := -1.
	newOrder at: 0+1 put:  (order := order+1).
	32 to: 64 do: [ :c |
		newOrder at: c + 1 put: (order := order+1)].
	#(92 94 124 126 183 215 247) do: [ :c | "\^|~·÷×"
		newOrder at: c + 1 put: (order := order+1)].
	16r90 to: 16r9F do: [:c| "special math operators"
		newOrder at: c + 1 put: (order := order+1)].
	Character uppercaseLowercaseAndUnaccentedLetters do: [ :upperAndLowercase |
		upperAndLowercase size > 1 ifTrue: [
			newOrder at: upperAndLowercase first numericValue + 1 put: (order := order+1) ]].
	Character uppercaseLowercaseAndUnaccentedLetters do: [ :upperAndLowercase |
		lowercase := upperAndLowercase size = 1
			ifTrue: [ upperAndLowercase first ]
			ifFalse: [ upperAndLowercase second ].
		newOrder at: lowercase numericValue + 1 put: (order := order+1) ].
	1 to: newOrder size do: [ :i |
		(newOrder at: i) ifNil: [
			newOrder at: i put: (order := order+1)]].
	order = 255 ifFalse: [self error: 'order problem'].
	^newOrder asByteArray.! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 17:54:36'!
basicCharSetNonSeparators
	"CR and LF--characters that terminate a line"
	| answer |
	answer := CharacterSet new.
	0 to: 255 do: [ :i | | char |
		char := Character numericValue: i.
		char isSeparator ifFalse: [
			answer add: char ]].
	^answer! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:21:32'!
caseInsensitiveOrder
	^`String basicCaseInsensitiveOrder`! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:21:57'!
caseSensitiveOrder
	^`String basicCaseSensitiveOrder`! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:15:14'!
charSetLineEnders
	"CR and LF--characters that terminate a line"
	^`CharacterSet new
		add: Character cr;
		add: Character lf;
		yourself`.! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 17:55:05'!
charSetNonSeparators
	"CR and LF--characters that terminate a line"
	^`String basicCharSetNonSeparators`.! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 17:51:30'!
charSetSeparators
	"CR and LF--characters that terminate a line"
	^`CharacterSet new addAll: Character separators; yourself`.! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:27:58'!
lowercasingTable
	"a table for translating to lower case"
	^`String withAll: ((0 to: 255) collect: [ :c | (Character numericValue: c) asLowercase ])`
! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:30:19'!
tokenishTable
	"a table for testing tokenish (for fast numArgs)"
	^`String withAll: (
		((0 to: 255) collect: [ :c | (Character numericValue: c) ])
			collect: 	[ :c | c tokenish ifTrue: [c] ifFalse: [$~]]	)`! !

!String class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:28:26'!
uppercasingTable
	"a table for translating to upper case"
	^`String withAll: ((0 to: 255) collect: [ :c | (Character numericValue: c) asUppercase ])`
! !
