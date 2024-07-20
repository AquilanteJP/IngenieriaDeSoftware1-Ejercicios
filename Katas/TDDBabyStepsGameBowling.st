!classDefinition: #TDDBabyStepsBowlingTest category: #TDDBabyStepsGameBowling!
TestCase subclass: #TDDBabyStepsBowlingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameBowling'!

!TDDBabyStepsBowlingTest methodsFor: 'tests' stamp: 'JP 7/3/2024 23:47:03'!
test01BowlingGameWithNoRollsHas0Score

	| game |
	
	game := BowlingGame new.
	
	self assert: game score equals: 0
	! !

!TDDBabyStepsBowlingTest methodsFor: 'tests' stamp: 'JP 7/3/2024 23:47:45'!
test02BowlingGameWithJustOneRollHasItAsScore
	
	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	
	self assert: game score equals: 2															
	! !

!TDDBabyStepsBowlingTest methodsFor: 'tests' stamp: 'JP 7/3/2024 23:50:20'!
test03OpenFrameCalculatedAsTheSumOfIts2Rolls

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	self assert: game score equals: 6
	! !

!TDDBabyStepsBowlingTest methodsFor: 'tests' stamp: 'JP 7/4/2024 00:12:28'!
test04SpareScoreCalculatedAsTheSumOfIts2RollsAndNextRollAsBonus

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	
	self assert: game score equals: (6 + (10 + 5) + 5)
	! !

!TDDBabyStepsBowlingTest methodsFor: 'tests' stamp: 'JP 7/4/2024 00:40:13'!
test05SpareScoreCalculatedJustAsTheSumOfIts2RollsWhenBonusNotYetRolled

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.

	game roll: 0.
	game roll: 10.
	
	game roll: 2.
	game roll: 8.
	
	self assert: game score equals: (6 + (10 + 0) + (10 + 2) + (10)) 
	! !

!TDDBabyStepsBowlingTest methodsFor: 'tests' stamp: 'JP 7/4/2024 00:40:22'!
test06StrikeScoreCalculatedAsTheSumOfIts2RollsAndNext2RollsOFNextFrameAsBonuses

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	game roll: 1.
	game roll: 1.
	
	self assert: game score equals: (6 + (10 + 5) + 8  + (10 + 1 + 1) + 2) 
	! !

!TDDBabyStepsBowlingTest methodsFor: 'tests' stamp: 'JP 7/4/2024 01:03:40'!
test07StrikeScoreCalculatedPartiallyIfSomeBonusesNotYetRolled

	| game |
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	
	game roll: 10.
	
	self assert: game score equals: (6 + (10 + 5) + 8  + (10))
	! !

!TDDBabyStepsBowlingTest methodsFor: 'tests' stamp: 'JP 7/4/2024 01:26:39'!
test08StrikeScoreCalculatedCrossing2FramesIfFirstBonusRollIsAnotherStrike

	| game checkpoint2|
	
	game := BowlingGame new.
	
	game roll: 2.
	game roll: 4.
	
	game roll: 4.
	game roll: 6.
	
	game roll: 5.
	game roll: 3.
	"29"
	
	game roll: 10.
	"50,recibo 39"
	checkpoint2:=game score.
	game roll: 10.
	"63, recibo 59"
	checkpoint2:=game score.
	game roll: 1.
	game roll: 2.
	checkpoint2:=game score.
	"66, recibo 68"
	
	self assert: game score equals: (6 + (10 + 5) + 8 + (10 + 10 + 1 ) + (10 + 1 + 2) + 1 + 2 ) "66"
	! !


!classDefinition: #BowlingGame category: #TDDBabyStepsGameBowling!
Object subclass: #BowlingGame
	instanceVariableNames: 'score frames'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameBowling'!

!BowlingGame methodsFor: 'score' stamp: 'JP 7/4/2024 00:11:33'!
score
	|sum|
	
	sum:=0.
	frames do:[:aFrame| sum:=sum+aFrame score].
	^sum.! !


!BowlingGame methodsFor: 'roll' stamp: 'JP 7/4/2024 00:39:54'!
addNewFrame: aNewFrame

	^ frames add: aNewFrame! !

!BowlingGame methodsFor: 'roll' stamp: 'JP 7/3/2024 23:53:03'!
initialize
	 
	score:=0.
	frames:= OrderedCollection with: Frame new.! !

!BowlingGame methodsFor: 'roll' stamp: 'JP 7/4/2024 00:39:31'!
mostRecentFrame

	^ frames last! !

!BowlingGame methodsFor: 'roll' stamp: 'JP 7/4/2024 00:55:05'!
roll: aNumberOfPins
	|currentFrame|
	
	currentFrame:=self mostRecentFrame.
	currentFrame addRoll: aNumberOfPins.
	(currentFrame hasEnded or: (currentFrame isStrike)) ifTrue:[|newFrame|
		newFrame:= Frame new.
		currentFrame setNextFrame: newFrame.
		self addNewFrame: newFrame.
		currentFrame:=self mostRecentFrame.
		].
	
	
	
	! !


!classDefinition: #Frame category: #TDDBabyStepsGameBowling!
Object subclass: #Frame
	instanceVariableNames: 'rolls score nextFrame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameBowling'!

!Frame methodsFor: 'as yet unclassified' stamp: 'JP 7/4/2024 00:02:11'!
addRoll: aNumberOfPins
	rolls add: aNumberOfPins ! !

!Frame methodsFor: 'as yet unclassified' stamp: 'JP 7/4/2024 00:17:31'!
initialize
	rolls:=OrderedCollection new.
	nextFrame:=nil.! !


!Frame methodsFor: 'testing' stamp: 'JP 7/4/2024 00:05:20'!
+ aFrame
	^rolls score + aFrame score! !

!Frame methodsFor: 'testing' stamp: 'JP 7/4/2024 01:05:05'!
firstRoll
	self hasNotBegun ifTrue:[^0].
	^rolls first.! !

!Frame methodsFor: 'testing' stamp: 'JP 7/4/2024 00:48:19'!
hasEnded
	^rolls size=2.! !

!Frame methodsFor: 'testing' stamp: 'JP 7/4/2024 01:05:05'!
hasNotBegun

	^ rolls isEmpty! !

!Frame methodsFor: 'testing' stamp: 'JP 7/4/2024 01:05:05'!
isStrike
	self hasNotBegun ifTrue:[^false].
	^rolls size=1 and: (rolls first = 10).! !

!Frame methodsFor: 'testing' stamp: 'JP 7/4/2024 01:35:04'!
score
	|sum|
	self hasNotBegun ifTrue:[^0].
	
	sum:= rolls sum.
	
	((self hasEnded and: (rolls sum = 10)) and: (nextFrame isNil not)) ifTrue:[sum:= sum + nextFrame firstRoll].
	
	((self isStrike) and: (nextFrame isNil not)) ifTrue:[sum:= sum + nextFrame score]. "se tendría que corregir acá"
	
	^sum.! !

!Frame methodsFor: 'testing' stamp: 'JP 7/4/2024 00:18:02'!
setNextFrame: aFrame
	nextFrame:= aFrame.! !
