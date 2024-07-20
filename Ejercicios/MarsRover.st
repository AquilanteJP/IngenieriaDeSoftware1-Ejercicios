!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 23:41:34'!
test01LookingNorthThenTurningRightFacesRoverToEast
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #North.
	miRover parseThenExecute: 'r'.
	
	self assert: (miRover isHeading: #East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 23:42:03'!
test02TurningRightThenLeftFacesRoverInOriginalDirection
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #North.
	miRover parseThenExecute:'rl'.
	
	self assert: (miRover isHeading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 23:57:52'!
test03LookingSouthThenTurningRightFacesRoverToWest
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #South.
	miRover parseThenExecute:'r'.
	
	self assert: (miRover isHeading: #West)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 23:58:09'!
test04LookingWestThenTurningRightFacesRoverToNorth
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #West.
	miRover parseThenExecute:'r'.
	
	self assert: (miRover isHeading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 23:58:43'!
test05LookingEastThenTurningRightFacesRoverToSouth
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #East.
	miRover parseThenExecute:'r'.
	
	self assert: (miRover isHeading: #South)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 00:09:17'!
test06LookingNorthThenTurningLeftFacesRoverToWest
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #North.
	miRover parseThenExecute:'l'.
	
	self assert: (miRover isHeading: #West )! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 00:09:34'!
test07LookingSouthThenTurningLeftFacesRoverToEast
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #South.
	miRover parseThenExecute:'l'.
	
	self assert: (miRover isHeading: #East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 00:09:48'!
test08LookingWestThenTurningLeftFacesRoverToSouth
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #West.
	miRover parseThenExecute:'l'.
	
	self assert: (miRover isHeading: #South)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 00:10:05'!
test09LookingEastThenTurningLeftFacesRoverToNorth
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #East.
	miRover parseThenExecute:'l'.
	
	self assert: (miRover isHeading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 00:21:01'!
test10LookingNorthThenMovingForwardMovesInNorth
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #North.
	miRover parseThenExecute:'f'.
	
	self assert: (miRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 14:45:51'!
test11LookingNorthThenMovingBackwardMovesInSouth
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #North.
	miRover parseThenExecute:'b'.
	
	self assert: (miRover isAt: 1@0 heading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 14:59:28'!
test12LookingEastThenMovingForwardMovesInEast
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #East.
	miRover parseThenExecute:'f'.
	
	self assert: (miRover isAt: 2@1 heading: #East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:02:18'!
test13LookingEastThenMovingBackwardMovesInWest
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #East.
	miRover parseThenExecute:'b'.
	
	self assert: (miRover isAt: 0@1 heading: #East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:08:55'!
test14LookingSouthThenMovingForwardMovesInSouth
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #South.
	miRover parseThenExecute:'f'.
	
	self assert: (miRover isAt: 1@0 heading: #South)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:12:24'!
test15LookingSouthThenMovingBackwardMovesInNorth
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #South.
	miRover parseThenExecute:'b'.
	
	self assert: (miRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:14:24'!
test16LookingWestThenMovingForwardMovesInWest
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #West.
	miRover parseThenExecute:'f'.
	
	self assert: (miRover isAt: 0@1 heading: #West)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:14:53'!
test17LookingWestThenMovingBackwardMovesInEast
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #West.
	miRover parseThenExecute:'b'.
	
	self assert: (miRover isAt: 2@1 heading: #West)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:50:33'!
test18PathWhereYouTestEverything
	|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #West.
	miRover parseThenExecute:'fffbblbb'.
	"0@1, -1@1,-2@1,-1@1,0@1,South,0@2,0@3"
	self assert: (miRover isAt: 0@3 heading: #South).
	miRover parseThenExecute:'rrfrfrffflllrffb'.
	"West,North,0@4,East,1@4,South,1@3,1@2,1@1,East,North,West,North,1@2,1@3,1@2"
	self assert: (miRover isAt: 1@2 heading: #North).! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'JP 5/23/2024 23:46:56'!
test19RaiseErrorForUnknownCommand
	"|miRover|
	
	miRover:= MarsRover landAt: 1@1 withDirection: #West.
	
	self 
		should: [miRover isAt: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]"
	self assert: true = true.! !


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'coordinate direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'JP 5/19/2024 18:32:09'!
initializeWith: aCoordinate withDirection: aDirection 
	coordinate := aCoordinate.
	direction := aDirection.
! !


!MarsRover methodsFor: 'testing' stamp: 'JP 5/20/2024 00:20:53'!
isAt: aCoordinate heading: aCardinalPoint 
	^(aCoordinate = coordinate) and: (self isHeading:aCardinalPoint)! !

!MarsRover methodsFor: 'testing' stamp: 'JP 5/19/2024 23:41:20'!
isHeading: aCardinalPoint
	^direction isHeading: aCardinalPoint! !

!MarsRover methodsFor: 'testing' stamp: 'JP 5/13/2024 00:19:47'!
lookingAt
	^direction.! !


!MarsRover methodsFor: 'parsing' stamp: 'JP 5/19/2024 23:46:08'!
parseThenExecute: aString
	aString do:[:char|
		char = $f ifTrue:[self moveForward].
		char = $b ifTrue:[self moveBackward].
		char = $l ifTrue:[self turnLeft].
		char= $r ifTrue:[self turnRight].
		]! !


!MarsRover methodsFor: 'private' stamp: 'JP 5/19/2024 23:27:02'!
headEast
	
	direction:= East new.! !

!MarsRover methodsFor: 'private' stamp: 'JP 5/19/2024 23:43:00'!
headNorth
	
	^direction:= North new.! !

!MarsRover methodsFor: 'private' stamp: 'JP 5/19/2024 23:43:05'!
headSouth
	
	^direction:= South new.! !

!MarsRover methodsFor: 'private' stamp: 'JP 5/19/2024 23:43:09'!
headWest
	
	^direction:= West new.! !

!MarsRover methodsFor: 'private' stamp: 'JP 5/20/2024 15:21:41'!
moveEast
	
	^coordinate:=coordinate+(1@0)! !

!MarsRover methodsFor: 'private' stamp: 'JP 5/20/2024 15:22:17'!
moveNorth
	
	^coordinate:=coordinate+(0@1)! !

!MarsRover methodsFor: 'private' stamp: 'JP 5/20/2024 15:22:08'!
moveSouth
	
	^coordinate:=coordinate-(0@1)! !

!MarsRover methodsFor: 'private' stamp: 'JP 5/20/2024 15:21:53'!
moveWest
	
	^coordinate:=coordinate-(1@0)! !


!MarsRover methodsFor: 'rotation' stamp: 'JP 5/19/2024 23:49:03'!
turnLeft
	direction turnLeft: self.
	"((self lookingAt) isEqualTo:$N) ifTrue:[^direction:=$W.].
	((self lookingAt) isEqualTo:$S) ifTrue:[^direction:=$E.].
	((self lookingAt) isEqualTo:$W) ifTrue:[^direction:=$S.].
	((self lookingAt) isEqualTo:$E) ifTrue:[^direction:=$N.]"! !

!MarsRover methodsFor: 'rotation' stamp: 'JP 5/19/2024 23:26:07'!
turnRight
	direction turnRight: self.
	"((self lookingAt) isEqualTo:$N) ifTrue:[^direction:=$E.].
	((self lookingAt) isEqualTo:$S) ifTrue:[^direction:=$W.].
	((self lookingAt) isEqualTo:$W) ifTrue:[^direction:=$N.].
	((self lookingAt) isEqualTo:$E) ifTrue:[^direction:=$S.]."
	! !


!MarsRover methodsFor: 'movement' stamp: 'JP 5/20/2024 15:24:33'!
moveBackward
	direction moveBackward:self
	
	"(self isHeading:#North) ifTrue:[^coordinate:=coordinate-(0@1)].
	(self isHeading:#East) ifTrue:[^coordinate:=coordinate-(1@0)].
	(self isHeading:#South) ifTrue:[^coordinate:=coordinate+(0@1)].
	(self isHeading:#West) ifTrue:[^coordinate:=coordinate+(1@0)]."! !

!MarsRover methodsFor: 'movement' stamp: 'JP 5/20/2024 15:16:38'!
moveForward
	direction moveForward:self
	"(self isHeading:#North) ifTrue:[^coordinate:=coordinate+(0@1)].
	(self isHeading:#East) ifTrue:[^coordinate:=coordinate+(1@0)].
	(self isHeading:#South) ifTrue:[^coordinate:=coordinate-(0@1)].
	(self isHeading:#West) ifTrue:[^coordinate:=coordinate-(1@0)]."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'JP 5/19/2024 19:50:00'!
landAt: aCoordinate withDirection: aCardinalPoint
	
	^self new initializeWith: aCoordinate withDirection: (MarsRoverDirection heading:aCardinalPoint) 
	! !


!classDefinition: #MarsRoverDirection category: #MarsRover!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 23:30:20'!
isHeading: aCardinalPoint
	^self class isFor: aCardinalPoint! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:18:44'!
moveBackward: aRover

	self subclassResponsibility! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:18:50'!
moveForward: aRover

	self subclassResponsibility! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:18:35'!
turnLeft: aRover

	self subclassResponsibility! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:18:41'!
turnRight: aRover

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirection class' category: #MarsRover!
MarsRoverDirection class
	instanceVariableNames: ''!

!MarsRoverDirection class methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:50:37'!
cardinalPoint

	self subclassResponsibility! !

!MarsRoverDirection class methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:43:48'!
heading: aCardinalPoint
	^self subclasses
		detect:[:aMarsRoverDirectionClass | aMarsRoverDirectionClass isFor: aCardinalPoint]
		ifFound:[:aMarsRoverDirectionClass | aMarsRoverDirectionClass new]
		ifNone:[self error: 'invalid direction']! !

!MarsRoverDirection class methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:44:41'!
isFor: aCardinalPoint
	^self cardinalPoint = aCardinalPoint! !


!classDefinition: #East category: #MarsRover!
MarsRoverDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:22:55'!
moveBackward: aRover

	^aRover moveWest! !

!East methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:19:40'!
moveForward: aRover

	^aRover moveEast! !

!East methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 20:30:30'!
turnLeft: aRover

	^aRover headNorth! !

!East methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 20:30:46'!
turnRight: aRover

	^aRover headSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: #MarsRover!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:50:55'!
cardinalPoint
	^#East! !


!classDefinition: #North category: #MarsRover!
MarsRoverDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:23:26'!
moveBackward: aRover

	^aRover moveSouth! !

!North methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:23:12'!
moveForward: aRover

	^aRover moveNorth! !

!North methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 21:35:54'!
turnLeft: aRover
	
	^aRover headWest.! !

!North methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 21:36:07'!
turnRight: aRover

	^aRover headEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: #MarsRover!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:51:04'!
cardinalPoint
	^#North! !


!classDefinition: #South category: #MarsRover!
MarsRoverDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:23:52'!
moveBackward: aRover

	^aRover moveNorth! !

!South methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:23:37'!
moveForward: aRover

	^aRover moveSouth! !

!South methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 21:41:17'!
turnLeft: aRover

	^aRover headEast! !

!South methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 21:41:39'!
turnRight: aRover

	^aRover headWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: #MarsRover!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:51:17'!
cardinalPoint
	^#South! !


!classDefinition: #West category: #MarsRover!
MarsRoverDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:24:03'!
moveBackward: aRover

	^aRover moveEast! !

!West methodsFor: 'as yet unclassified' stamp: 'JP 5/20/2024 15:24:10'!
moveForward: aRover

	^aRover moveWest! !

!West methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 21:41:52'!
turnLeft: aRover

	^aRover headSouth! !

!West methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 21:44:27'!
turnRight: aRover

	^aRover headNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: #MarsRover!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'as yet unclassified' stamp: 'JP 5/19/2024 19:59:07'!
cardinalPoint
	^#West! !
