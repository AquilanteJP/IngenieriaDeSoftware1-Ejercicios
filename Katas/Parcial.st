!classDefinition: #ProjectTest category: #Parcial!
TestCase subclass: #ProjectTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial'!

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/9/2024 20:44:43'!
alan

	^ Developer named: 'Alan Kay' withDedication: 6*hour/day withHourlyRate: 80*dollar/hour! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/9/2024 20:14:14'!
dan

	^ Developer named: 'Dan Ingalls' withDedication: 8*hour/day withHourlyRate: 60*dollar/hour! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/9/2024 20:14:25'!
test01TaskWithSameWorkHoursAsDevDedicationIsFinishedInSameDay
	|task |
	
	task := ConcreteTask named: 'SS A' withDevs: self dan startingOnDate: December/1/2021 withHours:8*hour.
	
	self assert:(task endsOn: December/1/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/10/2024 20:29:46'!
test01_2EndsOnIsntJustATrue
	|task |
	
	task := ConcreteTask named: 'SS A' withDevs: self dan startingOnDate: December/1/2021 withHours:8*hour.
	
	self deny:(task endsOn: December/2/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/9/2024 20:44:43'!
test02TaskWithNonEqualWorkHoursAndDevDedicationEndsOnCorrectDate
	|task dev|
	
	dev := self alan.
	task := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	
	self assert:(task endsOn: December/2/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/9/2024 20:45:06'!
test03MinimumDedicationIsUsedOnDevTeamToDetermineEndDate
	|task dev|
	
	dev := OrderedCollection with: self dan with:self alan.
	task := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	
	self assert:(task endsOn: December/2/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/10/2024 20:35:42'!
test04ConcreteTaskWithoutDependentsStartsOnStartingDate
	|task dev|
	
	dev := OrderedCollection with: self dan with:self alan.
	task := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	
	self assert:(task startsOn: December/1/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/10/2024 20:38:23'!
test05ConcreteTaskWithoutDependentsDoesntStartOnDateDifferentThanStartDate
	|task dev|
	
	dev := OrderedCollection with: self dan with:self alan.
	task := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	
	self deny:(task startsOn: December/2/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/10/2024 22:57:04'!
test06ConcreteTaskWithDependentsStartsAfterDependentsEndAndAfterStartingDate
	|taskA taskB dev|
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour dependingOn: {taskA}.
	
	self assert:(taskB startsOn: December/2/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/10/2024 22:56:54'!
test07ConcreteTaskWithDependentsStartsAfterDependentsEndButNotBeforeDesiredStartingDate
	|taskA taskB dev|
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/4/2021 withHours:8*hour dependingOn: {taskA}.
	
	self assert:(taskB startsOn: December/4/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/10/2024 22:56:43'!
test08ConcreteTaskEndDateConsidersActualStartingDateAndNotDesiredStartingDate
	|taskA taskB dev|
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:16*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour dependingOn: {taskA}.
	
	self assert:(taskB endsOn: December/3/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/10/2024 23:36:21'!
test09ProjectEndsOnLatestEndDateOfSubtasks
	|taskA taskB dev project |
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:16*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/2/2021 withHours:8*hour dependingOn: {taskA}.
	project := Project named: 'Tax evasion' composedBy:{taskA. taskB}.
	
	self assert:(project endsOn: December/3/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/10/2024 23:25:28'!
test09_02ProjectEndsOnIsntJustATrue
	|taskA taskB dev project |
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:16*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/2/2021 withHours:8*hour dependingOn: {taskA}.
	project := Project named: 'Tax evasion' composedBy:{taskA. taskB}.
	
	self deny:(project endsOn: December/4/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/11/2024 15:59:47'!
test10ProjectStartsOnIEarliestStartDateOfSubtasks
	|taskA taskB dev project |
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:16*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/4/2021 withHours:8*hour dependingOn: {taskA}.
	project := Project named: 'Tax evasion' composedBy:{taskA. taskB}.
	
	self assert:(project startsOn: December/1/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/11/2024 16:00:25'!
test10_02ProjectStartsOnIsntJustATrue
	|taskA taskB dev project |
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:16*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/4/2021 withHours:8*hour dependingOn: {taskA}.
	project := Project named: 'Tax evasion' composedBy:{taskA. taskB}.
	
	self deny:(project startsOn: December/2/2021). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/11/2024 16:40:38'!
test11ProjectDoesntHaveOverworkWhenDevIsntOverworked
	|taskA taskB dev project |
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/4/2021 withHours:8*hour.
	project := Project named: 'Tax evasion' composedBy:{taskA. taskB}.
	
	self deny:(project hasOverwork). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/11/2024 16:21:13'!
test12ProjectHasOverworkWhenDevIsOverworked
	|taskA taskB dev project |
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	project := Project named: 'Tax evasion' composedBy:{taskA. taskB}.
	
	self assert:(project hasOverwork). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/11/2024 16:40:32'!
test13DevWithTasksStartingEffectivelyOnDifferentDatesHasNoOverworkingDates
	|taskA taskB dev project worksheet|
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/4/2021 withHours:8*hour.
	project := Project named: 'Tax evasion' composedBy:{taskA. taskB}.
	worksheet := ProjectWorksheet on:project.
	
	self assert:((worksheet overworkingDatesOf: dev) isEmpty). 
! !

!ProjectTest methodsFor: 'as yet unclassified' stamp: 'JP 7/11/2024 16:51:37'!
test14DevWithTasksStartingEffectivelyOnSameDateHasOverworkingDates
	|taskA taskB dev project worksheet danOverworkingDates|
	
	dev := OrderedCollection with: self dan.
	taskA := ConcreteTask named: 'SS A' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	taskB:= ConcreteTask named: 'SS B' withDevs: dev startingOnDate: December/1/2021 withHours:8*hour.
	project := Project named: 'Tax evasion' composedBy:{taskA. taskB}.
	worksheet := ProjectWorksheet on:project.
	
	danOverworkingDates := worksheet overworkingDatesOf: dev.
	
	self assert:(danOverworkingDates size=1). 
	self assert:(danOverworkingDates includes: December/1/2021).
! !


!classDefinition: #ConcreteTask category: #Parcial!
Object subclass: #ConcreteTask
	instanceVariableNames: 'name devTeam desiredStartingDate hourAmount dependingOnTasks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial'!

!ConcreteTask methodsFor: 'endDate' stamp: 'JP 7/10/2024 21:45:55'!
dependentsLatestEndDate

	^ dependingOnTasks max:[:aTask| aTask endDate]! !

!ConcreteTask methodsFor: 'endDate' stamp: 'JP 7/10/2024 22:53:37'!
endDate
	| netDedication |
	(devTeam class = OrderedCollection) 
										ifTrue:[netDedication :=  devTeam min:[:aDev| aDev dedication]] 
										ifFalse:[netDedication := devTeam dedication].
	
	^ self startingDate next:((hourAmount/(netDedication)) ceiling -(1*day))! !

!ConcreteTask methodsFor: 'endDate' stamp: 'JP 7/9/2024 20:39:02'!
endsOn: aDate 
	^(self endDate) = aDate! !


!ConcreteTask methodsFor: 'initialization' stamp: 'JP 7/10/2024 22:53:52'!
initializeNamed: aName withDevs: aDevTeam startingOnDate: aDate withHours: anHourAmount 
	name := aName.
	devTeam := aDevTeam.
	desiredStartingDate := aDate.
	hourAmount := anHourAmount.
	dependingOnTasks := Bag new.! !

!ConcreteTask methodsFor: 'initialization' stamp: 'JP 7/10/2024 22:53:52'!
initializeNamed: aName withDevs: aDevTeam startingOnDate: aDate withHours: anHourAmount dependingOn: aListOfTasks
	name := aName.
	devTeam := aDevTeam.
	desiredStartingDate := aDate.
	hourAmount := anHourAmount.
	dependingOnTasks := aListOfTasks! !


!ConcreteTask methodsFor: 'startDate' stamp: 'JP 7/11/2024 16:41:15'!
startingDate
	|actualStartingDate|
	
	actualStartingDate:=desiredStartingDate.
	(dependingOnTasks size = 0) ifFalse:[
		(actualStartingDate < (self dependentsLatestEndDate next)) ifTrue:[actualStartingDate :=(self dependentsLatestEndDate) next].
	].
	
	^actualStartingDate.! !

!ConcreteTask methodsFor: 'startDate' stamp: 'JP 7/10/2024 22:53:37'!
startsOn: aDate
	^self startingDate = aDate.! !


!ConcreteTask methodsFor: 'getter' stamp: 'JP 7/11/2024 16:16:25'!
dev
	^devTeam! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConcreteTask class' category: #Parcial!
ConcreteTask class
	instanceVariableNames: ''!

!ConcreteTask class methodsFor: 'instance creation' stamp: 'JP 7/9/2024 20:10:49'!
named: aName withDevs: aDevTeam startingOnDate: aDate withHours: anHourAmount 
	^self new initializeNamed: aName withDevs: aDevTeam startingOnDate: aDate withHours: anHourAmount ! !

!ConcreteTask class methodsFor: 'instance creation' stamp: 'JP 7/10/2024 21:04:28'!
named: aName withDevs: aDevTeam startingOnDate: aDate withHours: anHourAmount dependingOn: aListOfTasks
	^self new initializeNamed: aName withDevs: aDevTeam startingOnDate: aDate withHours: anHourAmount dependingOn: aListOfTasks! !


!classDefinition: #Developer category: #Parcial!
Object subclass: #Developer
	instanceVariableNames: 'name dedication hourlyRate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial'!

!Developer methodsFor: 'initialization' stamp: 'JP 7/9/2024 20:09:56'!
initializeNamed: aName withDedication: aDedication withHourlyRate: anHourlyRate 
	name := aName.
	dedication := aDedication.
	hourlyRate := anHourlyRate.! !


!Developer methodsFor: 'dedication' stamp: 'JP 7/9/2024 20:21:08'!
dedication
	^dedication! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Developer class' category: #Parcial!
Developer class
	instanceVariableNames: ''!

!Developer class methodsFor: 'instance creation' stamp: 'JP 7/9/2024 20:09:41'!
named: aName withDedication: aDedication withHourlyRate: anHourlyRate 
	^self new initializeNamed: aName withDedication: aDedication withHourlyRate: anHourlyRate ! !


!classDefinition: #Project category: #Parcial!
Object subclass: #Project
	instanceVariableNames: 'name tasks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial'!

!Project methodsFor: 'initialization' stamp: 'JP 7/10/2024 23:10:54'!
initializeNamed: aName composedBy: someTasks 

	name := aName.
	tasks := someTasks.! !


!Project methodsFor: 'endDate' stamp: 'JP 7/10/2024 23:35:40'!
endsOn: aDate
	^ (self subtasksLatestEndDate) = aDate! !

!Project methodsFor: 'endDate' stamp: 'JP 7/10/2024 23:35:40'!
subtasksLatestEndDate

	^ tasks max:[:aTask| aTask endDate]! !


!Project methodsFor: 'startDate' stamp: 'JP 7/11/2024 16:02:36'!
startsOn: aDate
	^ (self subtasksEarliestStartDate) = aDate! !

!Project methodsFor: 'startDate' stamp: 'JP 7/11/2024 16:02:36'!
subtasksEarliestStartDate

	^ tasks min:[:aTask| aTask startingDate]! !


!Project methodsFor: 'overwork' stamp: 'JP 7/11/2024 16:41:27'!
hasOverwork
	^((tasks first dev) = (tasks second dev)) and: ((tasks first startingDate) = (tasks second startingDate)).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Project class' category: #Parcial!
Project class
	instanceVariableNames: ''!

!Project class methodsFor: 'instance creation' stamp: 'JP 7/10/2024 23:10:14'!
named: aName composedBy: someTasks
	^self new initializeNamed: aName composedBy: someTasks! !


!classDefinition: #ProjectWorksheet category: #Parcial!
Object subclass: #ProjectWorksheet
	instanceVariableNames: 'project'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Parcial'!

!ProjectWorksheet methodsFor: 'initialization' stamp: 'JP 7/11/2024 16:42:08'!
initializeOn: aProject 
	project := aProject.! !


!ProjectWorksheet methodsFor: 'overworkingDates' stamp: 'JP 7/11/2024 16:42:36'!
overworkingDatesOf: aDev 
	^OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProjectWorksheet class' category: #Parcial!
ProjectWorksheet class
	instanceVariableNames: ''!

!ProjectWorksheet class methodsFor: 'instance creation' stamp: 'JP 7/11/2024 16:41:54'!
on: aProject 
	^self new initializeOn: aProject ! !
