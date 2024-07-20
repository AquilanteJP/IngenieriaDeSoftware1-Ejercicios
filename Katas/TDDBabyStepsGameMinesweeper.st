!classDefinition: #TDDBabyStepsMinesweeperTest category: #TDDBabyStepsGameMinesweeper!
TestCase subclass: #TDDBabyStepsMinesweeperTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameMinesweeper'!

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 18:43:49'!
test01SweepingEmpty1x1MinefieldReturns1x1SweptMinefieldWithZero

	| minefield1x1 |
	
	minefield1x1 := #('.').
	
	self assert: ((Minesweeper with: minefield1x1) sweep) equals: #('0')
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 18:47:47'!
test02SweepingEmpty2x1MinefieldReturns2x1SweptMinefieldWithZeros

	| minefield2x1 |
	
	minefield2x1 := #(					'.'
						'.').		
	
	self assert: ((Minesweeper with: minefield2x1) sweep) equals: #(																'0'
																	'0')
																	
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 18:49:41'!
test03SweepingEmptyMoreThan2x1MinefieldReturnsMoreThan2x1SweptMinefieldWithZeros

	| minefield4x1 |
	
	minefield4x1 := #(					'.'
						'.'
						'.'
						'.').		
	
	self assert: ((Minesweeper with: minefield4x1) sweep) equals: #(																'0'
																	'0'
																	'0'
																	'0')
	
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 18:53:52'!
test04SweepingEmptyNx2MinefieldReturnsNx2SweptMinefieldWithZeros

	| minefield1x2 minefield3x2 |
	
	minefield1x2 := #(		'..').		
	
	self assert: ((Minesweeper with: minefield1x2) sweep) equals: #('00').
	
	minefield3x2 := #(					'..'
						'..'
						'..').		
						
	self assert: ((Minesweeper with: minefield3x2) sweep) equals: #(																'00'
																	'00'
																	'00')

	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:07:29'!
test05SweepingEmptyNxMMinefieldReturnsNxMSweptMinefieldWithZeros

	| minefield3x5 |

	minefield3x5 := #(					'.....'
						'.....'
						'.....').		
						
	self assert: ((Minesweeper with: minefield3x5) sweep) equals: #(																'00000'
																	'00000'
																	'00000')
	
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:08:06'!
test06MinefieldHeightCantBeLessThan1

	| minefield0 |

	minefield0 := #(	)	.
						
	self should: [ Minesweeper with: minefield0 ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'Height cant be less than 1']
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:16:31'!
test07MinefieldWidthCantBeLessThan1

	| minefield3x0 |

	minefield3x0 := #(	'' '' '')	.
						
	self should: [ (Minesweeper with: minefield3x0) ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'Width cant be less than 1' ]
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:19:39'!
test08ColumnsOfMinefieldShouldAllHaveSameSize

	| minefield3x5ish |

	minefield3x5ish := #(						'.....'
							'......'
							'.....').		
						
	self should: [ (Minesweeper with: minefield3x5ish) ] raise: Error withExceptionDo: [ :error | self assert: error messageText equals: 'All columns should be the same size']
	
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:22:45'!
test09Sweeping1MineOn1x1MinefieldReturns1x1SweptMinefieldWithMine

	| minefield |

	minefield := #(			'*').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #('*')
						
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:32:31'!
test10Sweeping1MineOnTopIn2x1MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #(				'*'
					'.').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'*'
																'1')
						
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:35:25'!
test11Sweeping1MineAtBottomIn2x1MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #(				'.'
					'*').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'1'
																'*')
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:42:53'!
test12Sweeping1MineOnLeftIn1x2MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #('*.').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(		'*1')
						
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:43:36'!
test13Sweeping1MineOnRightIn1x2MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #('.*').		
	
	self assert: ((Minesweeper with: minefield) sweep) equals: #(		'1*')			
	
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:52:29'!
test14Sweeping1MineAtDiagonalsIn2x2MinefieldReturnsCorrect1DistancedSweptMinefield

	| minefield |

	minefield := #(				'*.'
					'..').		
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'*1' 
																'11').			
	
	minefield := #	(			'.*'
					'..').		
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'1*'
																'11').
														
	minefield := #(				'..'
					'*.').		
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'11' 
																'*1').
														
	minefield := #(				'..'
					'.*').		
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'11' 
																'1*')
																									
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 19:55:50'!
test15SweepingMoreThan1MineInMinefieldAddsUpMinesCorrectly

	| minefield |
	
	minefield := #(				'*...'
					'....'
					'.*..'
					'....').
					
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'*100'
																'2210'
																'1*10'
																'1110').

	minefield := #	(			'***'
					'*.*'
					'***').		
					
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'***'
																'*8*'
																'***')
	! !

!TDDBabyStepsMinesweeperTest methodsFor: 'tests' stamp: 'JP 7/3/2024 20:17:23'!
testExtraToCheckGeneralizationOnKata

	| minefield |

	minefield := #(				'**...**'
					'*.....*'
					'...*...'
					'*.....*'
					'**...**').
							
	self assert: ((Minesweeper with: minefield) sweep) equals: #(															'**101**'
																'*32123*'
																'221*122'
																'*32123*'
																'**101**').
	! !


!classDefinition: #Minesweeper category: #TDDBabyStepsGameMinesweeper!
Object subclass: #Minesweeper
	instanceVariableNames: 'minefield rowSize colSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDBabyStepsGameMinesweeper'!

!Minesweeper methodsFor: 'initialization' stamp: 'JP 7/3/2024 20:14:50'!
initializeWith: aMinefield

	minefield := aMinefield.
	rowSize := minefield size.
	colSize := (minefield at: 1) size.
	
	! !



!Minesweeper methodsFor: 'accessing' stamp: 'JP 7/3/2024 20:14:50'!
areInRangeRow: row andCol: col

	^ row > 0 and: [ row <= rowSize and: [ col > 0 and: [ col <= colSize ] ] ]
	
	! !

!Minesweeper methodsFor: 'accessing' stamp: 'JP 7/3/2024 20:14:50'!
fieldAtRow: row atCol: col

	^ (minefield at: row) at: col
	
	! !

!Minesweeper methodsFor: 'accessing' stamp: 'JP 7/3/2024 20:14:51'!
isMineAtRow: row atCol: col

	^ (self areInRangeRow: row andCol: col) and: [ (self fieldAtRow: row atCol: col) =  $* ] 
	
	! !

!Minesweeper methodsFor: 'accessing' stamp: 'JP 7/3/2024 20:14:51'!
notCenterCoordinatesVert: vertIndex hor: horizIndex
	
	^ (vertIndex = 0 and: [ horizIndex = 0 ]) not	
	
	! !


!Minesweeper methodsFor: 'converting' stamp: 'JP 7/3/2024 20:14:51'!
sweep
	
	| sweptMinefield |
	
	sweptMinefield := Array new: rowSize.
	
	1 to: rowSize do: [ :row | 
		| sweptMinefieldRow |
		
		sweptMinefieldRow := String new: colSize.
		
		1 to: colSize do: [ :col | 
						
			"1era versión:"
			"| numberOfAdjacentMines |
			
			numberOfAdjacentMines := 0.
			-1 to: 1 do: [ :vertIndex |
				-1 to: 1 do: [ :horizIndex |
					((vertIndex = 0 and: [ horizIndex = 0]) not and: [ self isMineAtRow: row + vertIndex atCol: col + horizIndex ])
						ifTrue:[ numberOfAdjacentMines := numberOfAdjacentMines + 1 ]
				]
			].
			
			(self isMineAtRow: row atCol: col) 
				ifTrue: [ sweptMinefieldRow at: col put: $* ]
				ifFalse: [ sweptMinefieldRow at: col put: numberOfAdjacentMines asString first ]"
			
			"Última versión (Paso 3):"
			(self isMineAtRow: row atCol: col) 
				ifTrue: [ sweptMinefieldRow at: col put: $* ]
				ifFalse: [ sweptMinefieldRow at: col put: (self numberOfAdjacentMinesToRow: row toCol: col) asString first ]
			
		].
			
		sweptMinefield at: row put: sweptMinefieldRow ].
		
	^ sweptMinefield
	
	! !

!Minesweeper methodsFor: 'converting' stamp: 'JP 7/3/2024 20:11:25'!
tallyUpMinesAt: aColumn onString: aString 
	"pasar caracter a numero"
	"sumale 1"
	"pasar numero a caracter"
	
	|output|
	
	output := ((aString at: aColumn) asString) asNumber.
	output := output +1.
	output := (output asString) first. 
	
	aString at: aColumn put: output! !


!Minesweeper methodsFor: 'adjacent mines' stamp: 'JP 7/3/2024 20:14:51'!
numberOfAdjacentMinesToRow: row toCol: col
	
	| numberOfAdjacentMines |
	
	numberOfAdjacentMines := 0.
	
	-1 to: 1 do: [ :vertIndex |
		-1 to: 1 do: [ :horizIndex |
			((self notCenterCoordinatesVert: vertIndex hor: horizIndex) and: [ self isMineAtRow: row + vertIndex atCol: col + horizIndex ])
				ifTrue:[ numberOfAdjacentMines := numberOfAdjacentMines + 1 ]
		]
	].

	^ numberOfAdjacentMines
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Minesweeper class' category: #TDDBabyStepsGameMinesweeper!
Minesweeper class
	instanceVariableNames: ''!

!Minesweeper class methodsFor: 'instance creation' stamp: 'JP 7/3/2024 19:23:23'!
assertColumnsOfMinefieldHaveSameSize: aMinefield

	^ (aMinefield allSatisfy:[:aRow| aRow size = aMinefield first size]) ifFalse:[self error:'All columns should be the same size']! !

!Minesweeper class methodsFor: 'instance creation' stamp: 'JP 7/3/2024 19:18:26'!
assertHeightIsGreaterThanZero: aMinefield

	^ (aMinefield size < 1) ifTrue:[self error:'Height cant be less than 1']! !

!Minesweeper class methodsFor: 'instance creation' stamp: 'JP 7/3/2024 19:19:36'!
assertWidthIsGreaterThanZero: aMinefield

	^ aMinefield first size <1 ifTrue:[self error:'Width cant be less than 1']! !

!Minesweeper class methodsFor: 'instance creation' stamp: 'JP 7/3/2024 20:14:50'!
with: minefield
	
	self assertMinefieldHasCorrectDimensions: minefield.
	
	^ self new initializeWith: minefield
	
	! !


!Minesweeper class methodsFor: 'assertions' stamp: 'JP 7/3/2024 20:14:50'!
assertMinefieldHasCorrectDimensions: minefield
	
	minefield size = 0 ifTrue: [ self error: 'Height cant be less than 1' ].
	(minefield at: 1) size = 0 ifTrue: [ self error: 'Width cant be less than 1' ].
	(minefield allSatisfy: [ :rows | rows size = ((minefield at: 1) size) ]) ifFalse: [ self error: 'All columns should be the same size' ]. 

	! !
