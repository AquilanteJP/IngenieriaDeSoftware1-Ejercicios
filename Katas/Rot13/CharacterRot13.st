'From Cuis6.3 [latest update: #6169] on 6 May 2024 at 12:58:34 am'!
!classDefinition: #Character category: #'Kernel-Text'!
Object immediateSubclass: #Character
	instanceVariableNames: 'value'
	classVariableNames: 'CharacterTable'
	poolDictionaries: ''
	category: 'Kernel-Text'!
!Character commentStamp: '<historical>' prior: 0!
I represent a character by storing its associated Latin-9 code (ISO 8859-15). My instances are created uniquely, so that all instances of a character ($R, for example) are identical.!

!Character methodsFor: 'accessing' stamp: 'jmv 5/23/2022 10:17:45'!
asciiValue
	"Answer the value of the receiver that represents its ANSI encoding.
	This is the same as ISO 8859-15 for the first 128 characters.
	Answer nil if out of range."

	| n |
	n := self numericValue.
	^ n < 128 ifTrue: [ n ].! !

!Character methodsFor: 'accessing' stamp: 'jmv 10/8/2018 18:39:19'!
codePoint
	"
	self assert: $A codePoint hex = '16r41'.
	self assert: $€ codePoint hex = '16r20AC'.
	"
	^self class unicodeCodePoints at: self numericValue + 1! !

!Character methodsFor: 'accessing' stamp: 'jmv 5/9/2017 19:49:32'!
digitValue
	"Answer 0-9 if the receiver is $0-$9, 10-35 if it is $A-$Z, and < 0 
	otherwise. This is used to parse literal numbers of radix 2-36.
	$0 numericValue = 48
	$9 numericValue = 57
	$A numericValue = 65
	$Z numericValue = 90 
	$7 digitValue = 7 
	"

	| nv |
	nv := self numericValue.
	(nv between: 48 and: 57)
		ifTrue: [ ^ nv - 48 ].
	(nv between: 65 and: 90)
		ifTrue: [ ^ nv - 55 ].
	^ -1! !

!Character methodsFor: 'accessing' stamp: 'jmv 8/11/2016 09:43:22'!
immediateNumericValue
	"Answer the numeric value of the receiver, if instances happen to be immediate (i.e. as in Spur)"

	<primitive: 171>
	^self primitiveFailed! !

!Character methodsFor: 'accessing' stamp: 'jmv 9/2/2016 10:46:56'!
iso8859s15Code
	"Answer the value of the receiver that represents its ISO 8859-15 (Latin-9) encoding.
	Any implementation of Character like object beyond ISO-8859-15 should answer nil.
	Senders, please consider that this method might answer nil.
	See #iso8859s15CodeForUnicodeCodePoint:"

	^ self numericValue! !

!Character methodsFor: 'accessing' stamp: 'jmv 8/11/2016 09:46:09'!
nonImmediateNumericValue
	"Answer the numeric value of the receiver, if instances happen to be regular (i.e. not in Spur)"

	^self instVarAt: 1! !

!Character methodsFor: 'accessing' stamp: 'jmv 8/11/2016 09:47:05'!
numericValue
	"Answer the value of the receiver that represents its ISO 8859-15 (Latin-9) encoding."

	^ Character isImmediateClass
		ifTrue: [ self immediateNumericValue ]
		ifFalse: [ self nonImmediateNumericValue ]! !


!Character methodsFor: 'comparing' stamp: 'jmv 6/6/2022 11:53:36'!
< aCharacter 
	"Compare with the standard case sensitive collation order.
	This stuff should be in Character and not in String..."

	aCharacter isUnicodeCodePoint ifTrue: [ ^aCharacter > self ].
	^String does: self collateBefore: aCharacter! !

!Character methodsFor: 'comparing' stamp: 'jmv 6/6/2022 11:53:40'!
<= aCharacter 
	"Answer whether the receiver is less than or equal to the argument."

	aCharacter isUnicodeCodePoint ifTrue: [ ^aCharacter >= self ].
	^(self > aCharacter) not! !

!Character methodsFor: 'comparing' stamp: 'jmv 6/6/2022 10:40:45'!
= aCodePointOrCharacter

	self == aCodePointOrCharacter ifTrue: [ ^true ].
	aCodePointOrCharacter isCharacter ifFalse: [ ^false ].
	^self codePoint = aCodePointOrCharacter codePoint! !

!Character methodsFor: 'comparing' stamp: 'jmv 6/6/2022 11:53:44'!
> aCharacter 
	"Compare with the standard case sensitive collation order.
	This stuff should be in Character and not in String..."

	aCharacter isUnicodeCodePoint ifTrue: [ ^aCharacter < self ].
	^String does: self collateAfter: aCharacter! !

!Character methodsFor: 'comparing' stamp: 'jmv 7/6/2022 06:49:21'!
>= aCharacter 
	"Answer whether the receiver is greater than or equal to the argument."

	aCharacter isUnicodeCodePoint ifTrue: [ ^aCharacter <= self ].
	^(self < aCharacter) not! !

!Character methodsFor: 'comparing' stamp: 'jmv 11/4/2019 11:03:26'!
hash
	"Hash is reimplemented because = is implemented."

	^self numericValue hash! !

!Character methodsFor: 'comparing' stamp: 'jmv 8/30/2016 11:07:40'!
identityHash
	"Answer the receiver's character code."

	"For Spur"
	<primitive: 171>

	"For preSpur (non-immediate Characters)"
	^super identityHash! !


!Character methodsFor: 'testing' stamp: 'jmv 12/8/2009 09:46'!
canBeGlobalVarInitial
	^self isUppercase! !

!Character methodsFor: 'testing' stamp: 'jmv 6/11/2019 12:14:09'!
is: aSymbol
	^ aSymbol == #Character or: [ super is: aSymbol ]! !

!Character methodsFor: 'testing' stamp: 'jmv 6/14/2011 22:53'!
isAccented
	^self isLetter and: [ self asUnaccented ~~ self ]! !

!Character methodsFor: 'testing' stamp: 'ST-80 5/31/1983 9:10:35'!
isAlphaNumeric
	"Answer whether the receiver is a letter or a digit."
	^self isLetter or: [self isDigit]! !

!Character methodsFor: 'testing' stamp: 'jmv 6/6/2022 10:40:24'!
isCharacter
	^true! !

!Character methodsFor: 'testing' stamp: 'jmv 11/28/2022 10:12:17'!
isDiacriticalMark
	"No diacritical marks are instances of Character.
	See other implementors."

	^ false! !

!Character methodsFor: 'testing' stamp: 'jmv 11/1/2016 22:06:16'!
isDigit
	"Answer whether the receiver is a digit."

	^ self numericValue between: 48 and: 57! !

!Character methodsFor: 'testing' stamp: 'jmv 11/28/2022 11:06:37'!
isLetter
	"Answer whether the receiver is a letter."

	^self isLowercase or: [ self isUppercase ]! !

!Character methodsFor: 'testing' stamp: 'jmv 11/1/2016 22:06:09'!
isLineSeparator
	"Answer whether the receiver is a line separator character:
	line feed, cr, or form feed."

	^ #(10 13 12) statePointsTo: self numericValue! !

!Character methodsFor: 'testing' stamp: 'jmv 11/28/2022 11:00:39'!
isLowercase
	^self asUnicodeCodePoint isLowercase! !

!Character methodsFor: 'testing' stamp: 'jmv 12/1/2022 11:53:24'!
isNullCharacter
	"Answer whether the receiver is the NULL character."

	^ self numericValue = 0! !

!Character methodsFor: 'testing' stamp: 'jmv 9/11/2023 17:54:15'!
isSeparator
	"Answer whether the receiver is one of the separator characters
	space, tab, lf, cr, or form feed."
	"Also see #separators"

	^ #(32 9 10 13 12) statePointsTo: self numericValue! !

!Character methodsFor: 'testing' stamp: 'jmv 11/28/2022 10:32:22'!
isSymbolLike
	^self asUnicodeCodePoint isSymbolLike! !

!Character methodsFor: 'testing' stamp: 'jmv 6/14/2011 22:53'!
isUnaccented
	^self isLetter and: [ self asUnaccented == self ]! !

!Character methodsFor: 'testing' stamp: 'jmv 11/28/2022 11:00:31'!
isUppercase
	^self asUnicodeCodePoint isUppercase! !

!Character methodsFor: 'testing' stamp: 'jmv 12/1/2022 13:00:23'!
isValidInBinarySelectors
	"Can be part of a binary selector?
		$< isValidInBinarySelectors
		$| isValidInBinarySelectors
		$^ isValidInBinarySelectors
		$: isValidInBinarySelectors
	"
	self isNullCharacter ifTrue: [ ^false ].
	^#(verticalBar upArrow xColon xBinary xDiacritical) statePointsTo: (Scanner typeTableAt: self).! !

!Character methodsFor: 'testing' stamp: 'jmv 12/1/2022 13:05:09'!
isValidInIdentifiers
	"Can I be part of an identifier? (unary or keyword selector, or variable name)"

	self isNullCharacter ifTrue: [ ^false ].
	^#(xLetter xDigit xUnderscore xDiacritical) statePointsTo: (Scanner typeTableAt: self).! !

!Character methodsFor: 'testing' stamp: 'jmv 12/1/2022 13:06:21'!
isValidStartOfIdentifiers
	"Can I be the first character of an identifier? (unary or keyword selector, or variable name)"

	self isNullCharacter ifTrue: [ ^false ].
	^#(xLetter xUnderscore) statePointsTo: (Scanner typeTableAt: self).! !

!Character methodsFor: 'testing' stamp: 'jmv 10/6/2010 17:27'!
isVowel
	"Answer whether the receiver is one of the vowels, AEIOU, in upper or 
	lower case, and with various diacritical marks."

	^Character vowels includes: self! !

!Character methodsFor: 'testing' stamp: 'jmv 11/16/2015 14:51'!
tokenish
	"Answer whether the receiver is a valid token-character--letter, digit, or 
	colon."

	^self isValidInIdentifiers or: [self = $:]! !


!Character methodsFor: 'copying' stamp: 'eem 2/5/2014 12:53'!
shallowCopy
	"Answer the receiver, because Characters are unique."
	^self! !


!Character methodsFor: 'printing' stamp: 'jmv 7/29/2016 15:12:10'!
hex
	^ String
		with: ('0123456789ABCDEF' at: self numericValue//16+1)
		with: ('0123456789ABCDEF' at: self numericValue\\16+1)! !

!Character methodsFor: 'printing' stamp: 'ST-80 5/31/1983 9:10:35'!
isLiteral
	^true! !

!Character methodsFor: 'printing' stamp: 'jmv 1/22/2023 15:49:21'!
printOn: aStream 
	aStream nextPut: $$.
	aStream nextPut: self.
	self numericValue <= 32 ifTrue: [
		aStream nextPut: $".
		aStream nextPutAll: self hex.
		aStream nextPut: $" ].! !

!Character methodsFor: 'printing' stamp: 'ST-80 5/31/1983 9:10:35'!
storeOn: aStream
	"Character literals are preceded by '$'."
	aStream nextPut: $$; nextPut: self! !


!Character methodsFor: 'converting' stamp: 'ST-80 5/31/1983 9:10:35'!
asCharacter
	"Answer the receiver itself."
	^self! !

!Character methodsFor: 'converting' stamp: 'jmv 9/11/2023 14:42:59'!
asLowercase
	^ Character lowercaseMappingTable at: self numericValue + 1.! !

!Character methodsFor: 'converting' stamp: 'sma 3/11/2000 17:21'!
asString
	^ String with: self! !

!Character methodsFor: 'converting' stamp: 'jmv 9/9/2023 20:48:15'!
asSymbol
	^self asString asSymbol! !

!Character methodsFor: 'converting' stamp: 'jmv 4/21/2022 12:18:12'!
asText
	^ (String with: self) asText! !

!Character methodsFor: 'converting' stamp: 'jmv 10/8/2018 18:44:52'!
asUnaccented
	"
	$A asUnaccented
	$Á asUnaccented
	(0 to: 255) collect: [ :i | (Character numericValue: i) asUnaccented ]
	(0 to: 255) collect: [ :i | (Character numericValue: i) asUnaccented  asLowercase]
	"
	^ Character
		numericValue: (self class unaccentedTable at: self numericValue + 1)! !

!Character methodsFor: 'converting' stamp: 'jmv 6/23/2022 17:01:52'!
asUnicodeCodePoint
	^UnicodeCodePoint codePoint: self codePoint! !

!Character methodsFor: 'converting' stamp: 'jmv 9/11/2023 14:43:17'!
asUppercase
	"If the receiver is lowercase, answer its matching uppercase Character."
	^ Character uppercaseMappingTable at: self numericValue + 1.! !

!Character methodsFor: 'converting' stamp: 'jmv 9/2/2016 11:00:54'!
to: other
	"Answer with a collection in ascii order -- $a to: $z"
	^ (self numericValue to: other numericValue) collect:
				[:ascii | Character numericValue: ascii]! !

!Character methodsFor: 'converting' stamp: 'jmv 3/12/2018 15:47:49'!
withDiacriticalMark: anUnicodeCodePoint
	"Answer the character resulting from adding a diacritical mark (accent) to a letter.
	If the result is unsupported in ISO 8859-15, answer the receiver.
	Supported diacritical marks are:
		U+0300 	COMBINING GRAVE ACCENT
		U+0301 	COMBINING ACUTE ACCENT
		U+0302 	COMBINING CIRCUMFLEX ACCENT
		U+0303 	COMBINING TILDE
		U+0308 	COMBINING DIAERESIS
		U+030A 	COMBINING RING ABOVE
		U+030C 	COMBINING CARON
		$a withDiacriticalMark: 16r301
		$N withDiacriticalMark: $~
		$Z withDiacriticalMark: $v
		
		invalid:
		$9 withDiacriticalMark:$v
		$A withDiacriticalMark: $v
		$Á withDiacriticalMark: $v
		$A withDiacriticalMark: 1244
		"
	| answer i |
	i := ((anUnicodeCodePoint isNumber
			ifTrue: [#(16r300 16r301 16r302 16r303 16r308 16r30A 16r30C)]
			ifFalse: [#($` $' $^ $~ $" $° $v)]) indexOf: anUnicodeCodePoint
				) + 1.
	answer := (Character accentedLetters detect: [ :group | group first = self ] ifNone: [ ^self ]) at: i.
	^answer = $- ifFalse: [answer] ifTrue: [self]! !



!Character methodsFor: 'fileman-testing' stamp: 'mu 3/2/2007 21:34'!
isDriveLetter
	^'ABCDEFGHIJKLMNOPQRSTUVWXYZ' includes: self asUppercase
	! !

!Character methodsFor: 'fileman-testing' stamp: 'jmv 5/21/2022 22:29:28'!
isDriveSeparator
	^self = $:
	! !

!Character methodsFor: 'fileman-testing' stamp: 'mu 3/3/2007 19:37'!
isPathSeparator
	self = $\ ifTrue: [^true].
	self = $: ifTrue: [^true].
	self = $/ ifTrue: [^true].
	^false! !


!Character methodsFor: 'rot13' stamp: 'JP 5/6/2024 00:57:33'!
asRot13
	(self isNeitherUppercaseOrLowercase) ifTrue:[^self].
	(self isLowercaseFirstHalf) ifTrue:[^self offsetPlus13].
	(self isLowercaseSecondHalf) ifTrue:[^self offsetMinus13].
	(self isUppercaseFirstHalf) ifTrue:[^self offsetPlus13].
	(self isUppercaseSecondHalf) ifTrue:[^self offsetMinus13].
	! !

!Character methodsFor: 'rot13' stamp: 'JP 5/2/2024 21:19:08'!
isLowercaseFirstHalf

	^ (self asciiValue) between: ($a asciiValue) and: ($m asciiValue)! !

!Character methodsFor: 'rot13' stamp: 'JP 5/2/2024 21:19:47'!
isLowercaseSecondHalf

	^ (self asciiValue) between: ($n asciiValue) and: ($z asciiValue)! !

!Character methodsFor: 'rot13' stamp: 'JP 5/6/2024 00:56:13'!
isNeitherUppercaseOrLowercase
	^((self isUppercase) or: (self isLowercase)) not.! !

!Character methodsFor: 'rot13' stamp: 'JP 5/2/2024 21:21:00'!
isUppercaseFirstHalf

	^ (self asciiValue) between: ($A asciiValue) and: ($M asciiValue)! !

!Character methodsFor: 'rot13' stamp: 'JP 5/2/2024 21:21:14'!
isUppercaseSecondHalf

	^ (self asciiValue) between: ($N asciiValue) and: ($Z asciiValue)! !

!Character methodsFor: 'rot13' stamp: 'JP 5/2/2024 21:25:00'!
offsetMinus13

	^ (self asciiValue-13) asCharacter! !

!Character methodsFor: 'rot13' stamp: 'JP 5/2/2024 21:24:39'!
offsetPlus13

	^ (self asciiValue+13) asCharacter! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Character class' category: #'Kernel-Text'!
Character class
	instanceVariableNames: ''!

!Character class methodsFor: 'class initialization' stamp: 'jmv 11/7/2013 18:33'!
accentedLetters
	"Answer all letters with all possible accents (combining diacritical marks).
	Order of this array is:
		unaccented
		U+0300 	COMBINING GRAVE ACCENT
		U+0301 	COMBINING ACUTE ACCENT
		U+0302 	COMBINING CIRCUMFLEX ACCENT
		U+0303 	COMBINING TILDE
		U+0308 	COMBINING DIAERESIS
		U+030A 	COMBINING RING ABOVE
		U+030C 	COMBINING CARON
	Do not include letters that can't have any accent in ISO 8859-15
	Denote unsupported combinations (for example A with caron, or N with accute accent) by a $-"
	^#(
		'AÀÁÂÃÄÅ-'
		'aàáâãäå-'
		'EÈÉÊ-Ë--'
		'eèéê-ë--'
		'IÌÍÎ-Ï--'
		'iìíî-ï--'
		'OÒÓÔÕÖ--'
		'oòóôõö--'
		'UÙÚÛ-Ü--'
		'uùúû-ü--'
		'N---Ñ---'
		'n---ñ---'
		'S------Š'
		's------š'
		'Y-Ý--Ÿ--'
		'y-ý--ÿ--'
		'Z------Ž'
		'z------ž'
	).! !

!Character class methodsFor: 'class initialization' stamp: 'len 5/21/2020 08:23:36'!
blackboardLetters
	"Answer the 'blackboard bold' or 'double struck' letters included in our font within the ASCII range.
	These are considered uppercase letters and can be used as identifiers (variable names, keyword or unary messages, etc)."
	^ 'ℕℤℚℝℂℙ'! !

!Character class methodsFor: 'class initialization' stamp: 'len 12/28/2021 12:09:45'!
greekLowercaseLetters
	"Answer the lowercase greek letters included in our font within the ASCII range.
	These are considered lowercase letters and can be used as identifiers (variable names, keyword or unary messages, etc)."
	^ 'αβγδελπζµω'! !

!Character class methodsFor: 'class initialization' stamp: 'len 12/28/2021 12:09:40'!
greekUppercaseLetters
	"Answer the uppercase greek letters included in our font within the ASCII range.
	These are considered uppercase letters and can be used as identifiers (variable names, keyword or unary messages, etc)."
	^ 'ΔΓ'! !

!Character class methodsFor: 'class initialization' stamp: 'jmv 9/11/2023 14:53:15'!
initialize
	"
	Character initialize
	"
	Character isImmediateClass ifTrue: [
		CharacterTable := nil ].! !

!Character class methodsFor: 'class initialization' stamp: 'jmv 6/14/2011 20:22'!
uppercaseLowercaseAndUnaccentedLetters
	"Answer all uppercase and lowercase letters in standard collation order.
	For accented characters, include the non-accented ones.
	Note that $ß is 'LATIN SMALL LETTER SHARP S' and ISO 8859-15 doesn't have an uppercase version."
	^#(
		'Aa' 'ÀàAa' 'ÁáAa' 'ÂâAa' 'ÃãAa' 'ÄäAa' 'ÅåAa'
		'Bb' 'Cc' 'Çç' 'Dd'
			'Ee' 'ÈèEe' 'ÉéEe' 'ÊêEe' 'ËëEe'
		'Ff' 'Gg' 'Hh'
			'Ii' 'ÌìIi' 'ÍíIi' 'ÎîIi' 'ÏïIi'
		'Jj' 'Kk' 'Ll' 'Mm' 'Nn' 'Ññ'
			'Oo' 'ÒòOo' 'ÓóOo' 'ÔôOo' 'ÕõOo' 'ÖöOo'
		'Pp' 'Qq' 'Rr'
			'Ss' 'ŠšSs'
		'Tt'
			'Uu' 'ÙùUu' 'ÚúUu' 'ÛûUu' 'ÜüUu'
		'Vv' 'Ww' 'Xx'
			'Yy' 'ÝýYy' 'ŸÿYy'
			'Zz' 'ŽžZz' 
		'Ææ' 'Ðð' 'Øø' 'Þþ' 'ß' 'Œœ'
	).! !

!Character class methodsFor: 'class initialization' stamp: 'jmv 10/6/2010 17:26'!
vowels
	"Answer a String with all the vowels"
	
	^'AaÀàÁáÂâÃãÄäÅåEeÈèÉéÊêËëIiÌìÍíÎîÏïOoÒòÓóÔôÕõÖöUuÙùÚúÛûÜü'! !


!Character class methodsFor: 'instance creation' stamp: 'jmv 9/19/2016 09:24:38'!
asciiValue: asciiValue
	"
	Answer the Character for the required asciiValue. Argument is a byte, i.e. in [0..255].
	values above 127, consider it an ISO 8859-15 code.
	
	self assert: (Character asciiValue: 16r41) = $A.
	self assert: (Character asciiValue: 16rA4) = $€.
	"
	^ Character numericValue: asciiValue! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 10/26/2022 15:16:50'!
codePoint: codePoint
	"
	Answer nil if the Unicode codePoint is not a valid ISO 8859-15 character
	
	self assert: (Character codePoint: 16r41) = $A.
	self assert: (Character codePoint: 16r20AC) = $€.
	"
	^ (self iso8859s15CodeForUnicodeCodePoint: codePoint)
		ifNotNil: [ :code | Character numericValue: code ]! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 8/11/2016 10:02:24'!
digitValue: x 
	"Answer the Character whose digit value is x. For example,
	 answer $9 for x=9, $0 for x=0, $A for x=10, $Z for x=35."

	| n |
	n := x asInteger.
	^self numericValue: (n < 10 ifTrue: [n + 48] ifFalse: [n + 55])! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 8/11/2016 09:54:19'!
immediateNumericValue: anInteger
	"Answer the Character whose value is anInteger, if instances happen to be immediate (i.e. as in Spur)"

	<primitive: 170>
	^self primitiveFailed! !

!Character class methodsFor: 'instance creation' stamp: 'ST-80 5/31/1983 9:10:35'!
new
	"Creating new characters is not allowed."

	self error: 'cannot create new characters'! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 8/15/2023 18:06:26'!
nonImmediateNumericValue: anInteger
	"Answer the Character whose value is anInteger, if instances happen to be regular (i.e. not in Spur)"


	CharacterTable ifNil: [
		CharacterTable := (0 to: 255) collect: [ :i | Character basicNew instVarAt: 1 put: i; yourself ]].
	^CharacterTable at: anInteger + 1! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 8/15/2023 18:06:55'!
numericValue: anInteger
	"Answer the Character whose value is anInteger."

	^ Character isImmediateClass
		ifTrue: [ self immediateNumericValue: anInteger ]
		ifFalse: [ self nonImmediateNumericValue: anInteger ].! !

!Character class methodsFor: 'instance creation' stamp: 'jmv 9/11/2023 17:54:07'!
separators
	"Also see #isSeparator"
	^ #(32 "space"
		13 "cr"
		9 "tab"
		10 "line feed"
		12 "form feed")
		collect: [:v | Character numericValue: v]

	
! !


!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:40'!
backspace
	"Answer the Character representing a backspace."

	^self numericValue: 8! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 21:52:42'!
cr
	"Answer the Character representing a carriage return."

	^ ($)! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 8/28/2013 10:26'!
crCharacter
	"Answer the Character representing a carriage return."
	"Deprecated. To be removed soon. Please use #cr"

	^self cr! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:48'!
delete
	^ self numericValue: 127! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:54'!
end
	^ self numericValue: 4! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:56'!
enter
	"Answer the Character representing enter."

	^self numericValue: 3! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:16:57'!
escape
	"Answer the ASCII ESC character"

	^self numericValue: 27! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:29'!
home
	^ self numericValue: 1! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:34'!
insert
	^ self numericValue: 5! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 21:52:37'!
lf
	"Answer the Character representing a linefeed."

	^ ($
)! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 8/28/2013 10:25'!
lfCharacter
	"Answer the Character representing a linefeed."
	"Deprecated. To be removed soon. Please use #lf"

	^self lf! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 8/28/2013 10:28'!
newLineCharacter
	"Answer the Character representing a newLine, that is, a linefeed.
	This should be the only method in the system that knows about this detail.
	Everybody else should eventually ask us."

	^self lf! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:44'!
newPage
	"Answer the Character representing a form feed."

	^self numericValue: 12! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:48'!
null
	"Answer the null Character."

	^self numericValue: 0! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:55'!
pageDown
	^ self numericValue: 12! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/2/2016 11:17:56'!
pageUp
	^ self numericValue: 11! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 9/24/2017 20:34:05'!
shortUnderscore
	"Answer the Character representing very short (or invisible) underscore.
	Used to optionally mark subscript in code."

	^ Character numericValue: 127! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 3/9/2023 16:52:27'!
smalltalkDownArrow
	"
	The use of code 31 for a down arrow is not part of the ASCII or Unicode standards.
	This code is generally not used in text.
	Cuis holds a down arrow glyph at this code. This is for possible future use.

	The actual glyph used is decided by the TrueType font. See #mapAndStoreGlyphsUsing:
		and references to FallbackArrowGlyphs.

	Character smalltalkDownArrow
	"
	^ Character numericValue: 31! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 3/9/2023 16:53:31'!
smalltalkLeftArrow
	"
	The use of code 28 for a left arrow is not part of the ASCII or Unicode standards.
	This code is generally not used in text files.

	Cuis holds a left arrow glyph at this code, that is only used to show $_ as a left arrow,
	when used for assignment of a Smalltalk variable.
	Note that it will be replaced by $_ when saving code files or exporting to OS clipboard.
	Browse senders to see how this works.

	The actual glyph used is decided by the TrueType font. See #mapAndStoreGlyphsUsing:
		and references to FallbackArrowGlyphs.

	Character smalltalkLeftArrow
	"
	^ Character numericValue: 28! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 3/9/2023 16:52:22'!
smalltalkRightArrow
	"
	The use of code 30 for a right arrow is not part of the ASCII or Unicode standards.
	This code is generally not used in text.
	Cuis holds a right arrow glyph at this code. This is for possible future use.

	The actual glyph used is decided by the TrueType font. See #mapAndStoreGlyphsUsing:
		and references to FallbackArrowGlyphs.

	Character smalltalkRightArrow
	"
	^ Character numericValue: 30! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 3/9/2023 16:53:21'!
smalltalkUpArrow
	"
	The use of code 29 for an up arrow is not part of the ASCII or Unicode standards.
	This code is generally not used in text files.

	Cuis holds an up arrow glyph at this code, that is only used to show $^ as an up arrow,
	when used for return from a Smalltalk method.
	Note that it will be replaced by $^ when saving code files or exporting to OS clipboard.
	Browse senders to see how this works.

	The actual glyph used is decided by the TrueType font. See #mapAndStoreGlyphsUsing:
		and references to FallbackArrowGlyphs.

	Character smalltalkUpArrow
	"
	^ Character numericValue: 29! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 21:52:33'!
space
	"Answer the Character representing a space."

	^ ($ )! !

!Character class methodsFor: 'accessing untypeable characters' stamp: 'jmv 11/1/2016 21:52:28'!
tab
	"Answer the Character representing a tab."

	^ ($	)! !



!Character class methodsFor: 'converting' stamp: 'jmv 11/15/2023 11:53:29'!
evaluate: aBlock withUtf16WordsOfUnicodeCodePoint: aCodePoint
	"See senders for typical usage"

	| highSurrogate lowSurrogate |
	(aCodePoint between: 16rD800 and: 16rDFFF) ifTrue: [
		self error: 'invalid CodePoint' ].

	aCodePoint <= 16rFFFF ifTrue: [
		^aBlock value: aCodePoint ].

	highSurrogate := (aCodePoint - 16r10000) >> 10 + 16rD800.
	lowSurrogate := ((aCodePoint - 16r10000) bitAnd: 1023) + 16rDC00.
	aBlock value: highSurrogate.
	aBlock value: lowSurrogate.! !

!Character class methodsFor: 'converting' stamp: 'jmv 2/8/2013 08:32'!
evaluate: aBlock withUtf8BytesOfUnicodeCodePoint: aCodePoint
	"See senders for typical usage"

	| mask nBytes shift |
	aCodePoint < 128 ifTrue: [
		^aBlock value: aCodePoint ].
	nBytes := aCodePoint highBit + 3 // 5.
	mask := #(128 192 224 240 248 252 254 255) at: nBytes.
	shift := nBytes - 1 * -6.
	aBlock value: (aCodePoint bitShift: shift) + mask.
	2 to: nBytes do: [ :i | 
		shift := shift + 6.
		aBlock value: ((aCodePoint bitShift: shift) bitAnd: 63) + 128 ]! !

!Character class methodsFor: 'converting' stamp: 'jmv 3/31/2020 18:30:21'!
evaluateOnce: aBlock withUtf8BytesOfUnicodeCodePoint: aCodePoint
	"Similar to #evaluate:withUtf8BytesOfUnicodeCodePoint:, but aBlock is evaluated just once, and must have 4 parameters."

	| mask nBytes shift byte1 byte2 byte3 byte4 |
	aCodePoint < 128 ifTrue: [
		^aBlock value: aCodePoint value: nil value: nil value: nil ].
	nBytes := aCodePoint highBit + 3 // 5.
	mask := #(128 192 224 240 248 252 254 255) at: nBytes.
	shift := nBytes - 1 * -6.
	byte1 := (aCodePoint bitShift: shift) + mask.
	nBytes >= 2 ifTrue: [
		shift := shift + 6.
		byte2 :=  ((aCodePoint bitShift: shift) bitAnd: 63) + 128.
		nBytes >= 3 ifTrue: [
			shift := shift + 6.
			byte3 :=  ((aCodePoint bitShift: shift) bitAnd: 63) + 128.
			nBytes = 4 ifTrue: [
				shift := shift + 6.
				byte4 :=  ((aCodePoint bitShift: shift) bitAnd: 63) + 128.
				].
			].
		].
		^aBlock value: byte1 value: byte2 value: byte3 value: byte4.! !

!Character class methodsFor: 'converting' stamp: 'jmv 6/21/2023 08:14:39'!
iso8859s15CodeForUnicodeCodePoint: codePoint
	"
	Answer nil if the Unicode codePoint is not a valid ISO 8859-15 character
	
	self assert: (Character iso8859s15CodeForUnicodeCodePoint: 16r41) = $A iso8859s15Code.
	self assert: (Character iso8859s15CodeForUnicodeCodePoint: 16r20AC) = $€ iso8859s15Code.
	"

	"For most 8 bit Characters, ISO 8859-15 and Unicode Code Point are the same. Fast path."
	(codePoint < 256 and: [ (self unicodeCodePoints at: codePoint+1) = codePoint ])
		ifTrue: [ ^codePoint ].

	^ self irregularIso8859s15Codes at: codePoint ifAbsent: nil.! !

!Character class methodsFor: 'converting' stamp: 'jmv 8/31/2011 22:07'!
macRomanToLatin1: charCode
	"Convert the receiver from MacRoman to  ISO 8895-1 Latin-1 encoding"
	
	charCode < 128 ifTrue: [^ charCode].
	^ #[
		196 197 199 201 209 214 220 225 224 226 228 227 229 231 233 232 
		234 235 237 236 238 239 241 243 242 244 246 245 250 249 251 252 
		134 176 162 163 167 149 182 223 174 169 153 180 168 128 198 216 
		129 177 138 141 165 181 142 143 144 154 157 170 186 158 230 248 
		191 161 172 166 131 173 178 171 187 133 160 192 195 213 140 156 
		150 151 147 148 145 146 247 179 255 159 185 164 139 155 188 189 
		135 183 130 132 137 194 202 193 203 200 205 206 207 204 211 212 
		190 210 218 219 217 208 136 152 175 215 221 222 184 240 253 254
	] at: charCode - 127! !

!Character class methodsFor: 'converting' stamp: 'jmv 5/24/2022 19:04:02'!
utf8BytesAndCodePointAt: byteIndex in: aByteArray into: bytesBlock into: codePointBlock
	"Find next UTF-8 encoded code point in utf8ByteArray starting at byte byteIndex.
	Evaluate bytesBlock (if not nil). Arguments are utf8 bytes for the codePoint found.
	Evaluate codePointBlock (if not nil) with codePoint found as argument.
	Answer the number of bytes that comprised this codePoint.
	If there is an invalid UTF-8 sequence, consider the first byte an ISO-8859-15 Character (i.e. Cuis Character class encoding), and answer 1.
	Skip codePoint U+FEFF (BOM, unneededly added by Win clipboard). Still, answer the number of bytes of the BOM sequence, to allow senders to update an index in an iteration.
	See senders."

	| i s byte1 byte2 byte3 byte4 |
	
	s := aByteArray size.
	i := byteIndex.
	byte1 := aByteArray at: i.
	i := byteIndex+1.
	byte2 := i <= s ifTrue: [aByteArray at: i].
	i := byteIndex+2.
	byte3 := i <= s ifTrue: [aByteArray at: i].
	i := byteIndex+3.
	byte4 := i <= s ifTrue: [aByteArray at: i].

	^self
		utf8BytesAndCodePointFor: byte1
		byte2: byte2
		byte3: byte3
		byte4: byte4
		into: bytesBlock
		into: codePointBlock! !

!Character class methodsFor: 'converting' stamp: 'jmv 5/24/2022 16:10:06'!
utf8BytesAndCodePointFor: byte1 byte2: byte2 byte3: byte3 byte4: byte4 into: bytesBlock into: codePointBlock
	"Find next UTF-8 encoded code point in argument bytes.
	Evaluate bytesBlock (if not nil). Arguments are utf8 bytes for the codePoint found.
	Evaluate codePointBlock (if not nil) with codePoint found as argument.
	Answer the number of bytes that comprised this codePoint.
	If there is an invalid UTF-8 sequence, consider the first byte an ISO-8859-15 Character (i.e. Cuis Character class encoding), and answer 1.
	Skip codePoint U+FEFF (BOM, unneededly added by Win clipboard). Still, answer the number of bytes of the BOM sequence, to allow senders to update an index in an iteration.
	See senders."

	| codePoint |
	byte1 < 128 ifTrue: [	"single byte"
		bytesBlock ifNotNil: [
			bytesBlock value: byte1 value: nil value: nil value: nil ].
		codePointBlock ifNotNil: [
			codePointBlock value: byte1 ].
		^ 1 ].
	
	"At least 2 bytes"
	(byte2 notNil and: [ (byte2 bitAnd: 16rC0) = 16r80 ]) ifFalse: [
		"invalid UTF-8. Assume byte1 is ISO8859-15."
		^ self utf8BytesAndCodePointForIso8859s15: byte1 into: bytesBlock into: codePointBlock ].
	(byte1 bitAnd: 16rE0) = 16rC0  ifTrue: [ "two bytes"
		bytesBlock ifNotNil: [
			bytesBlock value: byte1 value: byte2 value: nil value: nil ].
		codePointBlock ifNotNil: [
			codePoint := ((byte1 bitAnd: 31) bitShift: 6) + (byte2 bitAnd: 63).
			codePointBlock value: codePoint ].
		^2 ].
	
	"At least 3 bytes"
	(byte3 notNil and: [ (byte3 bitAnd: 16rC0) = 16r80 ]) ifFalse: [
		"invalid UTF-8. Assume byte1 is ISO8859-15."
		^ self utf8BytesAndCodePointForIso8859s15: byte1 into: bytesBlock into: codePointBlock ].
	(byte1 bitAnd: 16rF0) = 16rE0  ifTrue: [ "three bytes"
		codePoint :=  ((byte1 bitAnd: 15) bitShift: 12) + ((byte2 bitAnd: 63) bitShift: 6) + (byte3 bitAnd: 63).
		codePoint = 16rFEFF ifTrue: [ "BOM. Ignore it. Skip ti."
			^3 ].
		bytesBlock ifNotNil: [
			bytesBlock value: byte1 value: byte2 value: byte3 value: nil ].
		codePointBlock ifNotNil: [
			codePointBlock value: codePoint ].
		^3 ].

	"4 bytes"
	(byte4 notNil and: [ (byte4 bitAnd: 16rC0) = 16r80 ]) ifFalse: [
		"invalid UTF-8. Assume byte1 is ISO8859-15."
		^ self utf8BytesAndCodePointForIso8859s15: byte1 into: bytesBlock into: codePointBlock ].
	(byte1 bitAnd: 16rF8) = 16rF0  ifTrue: [  "four bytes"
		bytesBlock ifNotNil: [
			bytesBlock value: byte1 value: byte2 value: byte3 value: byte4 ].
		codePointBlock ifNotNil: [
			codePoint := ((byte1 bitAnd: 16r7) bitShift: 18) + ((byte2 bitAnd: 63) bitShift: 12)
					+ ((byte3 bitAnd: 63) bitShift: 6) + (byte4 bitAnd: 63).
			codePointBlock value: codePoint ].
		^ 4].

	"invalid UTF-8. Assume byte1 is ISO8859-15."
	^ self utf8BytesAndCodePointForIso8859s15: byte1 into: bytesBlock into: codePointBlock.! !

!Character class methodsFor: 'converting' stamp: 'jmv 5/24/2022 16:58:19'!
utf8BytesAndCodePointForIso8859s15: iso8859s15 into: bytesBlock into: codePointBlock
	| codePoint |
	codePoint := (Character numericValue: iso8859s15) codePoint.
	bytesBlock ifNotNil: [
		Character
			evaluateOnce: bytesBlock
			withUtf8BytesOfUnicodeCodePoint: codePoint ].
	codePointBlock ifNotNil: [
		codePointBlock value: codePoint ].
	^1! !

!Character class methodsFor: 'converting' stamp: 'jmv 2/8/2013 08:34'!
utf8BytesOfUnicodeCodePoint: aCodePoint

	^ ByteArray streamContents: [ :strm |
		Character
			evaluate: [ :byte |
				strm nextPut: byte ]
			withUtf8BytesOfUnicodeCodePoint: aCodePoint ]! !


!Character class methodsFor: 'fileIn/Out' stamp: 'jmv 9/11/2023 14:53:02'!
definition
	"Special class definition for Character, SmallInteger and SmallFloat64
	Required to have the same definition both for preSpur and Spur, and to be compatible with both."
	^
'Object immediateSubclass: #Character
	instanceVariableNames: ''value''
	classVariableNames: ''CharacterTable''
	poolDictionaries: ''''
	category: ''', self category, ''''
! !


!Character class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:51:11'!
basicIrregularIso8859s15Codes
	
	| unicodeCodePoints irregularIso8859s15Codes |
	unicodeCodePoints := Character unicodeCodePoints.
	irregularIso8859s15Codes := Dictionary new.
	0 to: 255 do: [ :iso |
		(unicodeCodePoints at: iso+1) = iso ifFalse: [
			irregularIso8859s15Codes at: (unicodeCodePoints at: iso+1) put: iso ]].
	^irregularIso8859s15Codes! !

!Character class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:40:24'!
basicLookupTables
	| lowercaseMappingTable uppercaseMappingTable unaccentedTable |
	lowercaseMappingTable := Array new: 256.
	uppercaseMappingTable := Array new: 256.
	unaccentedTable := ByteArray new: 256.
	0
		to: 255
		do: [ :idx | | char |
			"Default to an identity mapping with a false truth mapping"
			char := self numericValue: idx.
			lowercaseMappingTable
				at: idx + 1 put: char.
			uppercaseMappingTable
				at: idx + 1 put: char.
			unaccentedTable at: idx + 1 put: idx].
	"Now override as needed"
	Character uppercaseLowercaseAndUnaccentedLetters do: [ :group | | uppercase lowercase |
		group size > 1
			ifTrue: [ | lowercaseChar uppercaseChar |
				uppercase := group first numericValue.
				lowercase := group second numericValue.
				lowercaseChar := self numericValue: lowercase.
				uppercaseChar := self numericValue: uppercase.
				lowercaseMappingTable
					at: lowercase + 1 put: lowercaseChar;
					at: uppercase + 1 put: lowercaseChar.
				uppercaseMappingTable
					at: lowercase + 1 put: uppercaseChar;
					at: uppercase + 1 put: uppercaseChar.
				group size > 2
					ifTrue: [|unaccentedUppercase unaccentedLowercase|
						unaccentedUppercase := group third numericValue.
						unaccentedLowercase := group fourth numericValue.
						unaccentedTable
							at: uppercase+1 put: unaccentedUppercase;
							at: lowercase+1 put: unaccentedLowercase]]
			ifFalse: [ | lowercaseChar |
				lowercase := group first numericValue.
				lowercaseChar := self numericValue: lowercase.
				lowercaseMappingTable
					at: lowercase + 1 put: lowercaseChar.
				uppercaseMappingTable
					at: lowercase + 1 put: lowercaseChar ]].
	^{ lowercaseMappingTable. uppercaseMappingTable. unaccentedTable}! !

!Character class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:48:46'!
basicUnicodeCodePoints
	"Initialize the table of Unicode code points"
	| unicodeCodePoints |
	unicodeCodePoints := Array new: 256.
	0 to: 255 do: [ :code |
		unicodeCodePoints at: code + 1 put: code ].
	
	"The following codes are different in ISO 8859-15 from those in ISO 8859-1,
	so the character code is not equal to the Unicode code point"
	unicodeCodePoints at: 16rA4+1 put: 16r20AC.		"euro sign"
	unicodeCodePoints at: 16rA6+1 put: 16r160.		"latin capital letter S with caron"
	unicodeCodePoints at: 16rA8+1 put: 16r161.		"latin small letter s with caron"
	unicodeCodePoints at: 16rB4+1 put: 16r17D.		"latin capital letter Z with caron"
	unicodeCodePoints at: 16rB8+1 put: 16r17E.		"latin small letter z with caron"
	unicodeCodePoints at: 16rBC+1 put: 16r152.		"latin capital ligature OE"
	unicodeCodePoints at: 16rBD+1 put: 16r153.		"latin small ligature oe"
	unicodeCodePoints at: 16rBE+1 put: 16r178.		"latin capital letter Y with diaeresis"

	"Mathematical symbols (see Character>>#namedCharactersTable)"
	unicodeCodePoints at: 16r80+1 put: 16r221E.		"infinity"
	unicodeCodePoints at: 16r81+1 put: 16r2135.		"aleph"
	unicodeCodePoints at: 16r82+1 put: 16r2115.		"blackboard bold N"
	unicodeCodePoints at: 16r83+1 put: 16r2124.		"blackboard bold Z"
	unicodeCodePoints at: 16r84+1 put: 16r211A.		"blackboard bold Q"
	unicodeCodePoints at: 16r85+1 put: 16r211D.		"blackboard bold R"
	unicodeCodePoints at: 16r86+1 put: 16r2102.		"blackboard bold C"
	unicodeCodePoints at: 16r87+1 put: 16r2119.		"blackboard bold P"
	unicodeCodePoints at: 16r88+1 put: 16r03B1.		"alpha"
	unicodeCodePoints at: 16r89+1 put: 16r03B2.		"beta"
	unicodeCodePoints at: 16r8A+1 put: 16r03B3.		"gamma"
	unicodeCodePoints at: 16r8B+1 put: 16r03B4.		"delta"
	unicodeCodePoints at: 16r8C+1 put: 16r03B5.		"epsilon"
	unicodeCodePoints at: 16r8D+1 put: 16r03BB.		"lambda"
	unicodeCodePoints at: 16r8E+1 put: 16r03C0.		"pi"
	unicodeCodePoints at: 16r8F+1 put: 16r03B6.		"zeta"
	unicodeCodePoints at: 16r90+1 put: 16r2295.		"oplus"
	unicodeCodePoints at: 16r91+1 put: 16r2297.		"otimes"
	unicodeCodePoints at: 16r92+1 put: 16r2218.		"circ"
	unicodeCodePoints at: 16r93+1 put: 16r2293.		"prod"
	unicodeCodePoints at: 16r94+1 put: 16r2294.		"coprod"
	unicodeCodePoints at: 16r95+1 put: 16r22A5.		"perp"
	unicodeCodePoints at: 16r96+1 put: 16r0394.		"Delta"
	unicodeCodePoints at: 16r97+1 put: 16r0393.		"Gamma"
	unicodeCodePoints at: 16r98+1 put: 16r03C9.		"omega"
	unicodeCodePoints at: 16r99+1 put: 16r21A0.		"SURJECTIVE ARROW"
	unicodeCodePoints at: 16r9A+1 put: 16r21A3.		"INJECTIVE ARROW"
	unicodeCodePoints at: 16r9B+1 put: 16r2194.		"BIJECTIVE ARROW"
	unicodeCodePoints at: 16r9C+1 put: 16r21AA.		"INCLUSION ARROW"
	unicodeCodePoints at: 16r9D+1 put: 16r21A6.		"MAPPING ARROW"
	unicodeCodePoints at: 16r9E+1 put: 16r2202.		"partial differential"
	unicodeCodePoints at: 16r9F+1 put: 16r221A.		"sqrt"
	^unicodeCodePoints! !

!Character class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:51:48'!
irregularIso8859s15Codes
	^`Character basicIrregularIso8859s15Codes`! !

!Character class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:41:06'!
lowercaseMappingTable
	^`Character basicLookupTables at: 1`! !

!Character class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:41:18'!
unaccentedTable
	^`Character basicLookupTables at: 3`! !

!Character class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:49:18'!
unicodeCodePoints
	^`Character basicUnicodeCodePoints`! !

!Character class methodsFor: 'static state' stamp: 'jmv 9/11/2023 14:41:12'!
uppercaseMappingTable
	^`Character basicLookupTables at: 2`! !


Character initialize!
