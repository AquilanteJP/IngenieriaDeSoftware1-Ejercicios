!classDefinition: #I category: #'Ejercicio 4 hecho bien'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4 hecho bien'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Ejercicio 4 hecho bien'!
I class
	instanceVariableNames: ''!

!I class methodsFor: '-- all --' stamp: 'JPA 3/25/2024 22:01:10'!
* aMultiplicand
	
	^aMultiplicand.! !

!I class methodsFor: '-- all --' stamp: 'JPA 3/25/2024 21:50:46'!
+ anAdder
	
	"Le suma algo."

	"(anAdder isEqualTo: 1) ifTrue:[^self next] 
						ifFalse:[^self next + anAdder previous]	"
	^anAdder next.! !

!I class methodsFor: '-- all --' stamp: 'JP 4/10/2024 14:45:39'!
< aNumber
	
	^(aNumber isNotEqualTo: I).! !

!I class methodsFor: '-- all --' stamp: 'JPA 3/25/2024 20:56:25'!
next
	"El siguiente."

	^II.! !


!classDefinition: #II category: #'Ejercicio 4 hecho bien'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4 hecho bien'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Ejercicio 4 hecho bien'!
II class
	instanceVariableNames: 'previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'JPA 3/25/2024 21:16:42'!
next
	"comment stating purpose of message"

	| nextNumber|
	nextNumber := II createChildNamed: self name,'I'.
	nextNumber previous: self.
	^nextNumber.! !


!II class methodsFor: '-- all --' stamp: 'JPA 3/25/2024 22:04:05'!
* aMultiplicand
	
	^self + (self * aMultiplicand previous).! !

!II class methodsFor: '-- all --' stamp: 'JPA 3/25/2024 21:34:04'!
+ anAdder
	"comment stating purpose of message"

	^self previous + anAdder next.! !

!II class methodsFor: '-- all --' stamp: 'JP 4/8/2024 21:28:01'!
- aSustrahend
	"comment stating purpose of message"
	
	(aSustrahend isEqualTo: I) ifTrue:[^self previous]. 
						^self previous - aSustrahend previous.
	
	! !

!II class methodsFor: '-- all --' stamp: 'JP 4/10/2024 14:45:08'!
/ aDivisor
	"Devuelve el cociente después de hacer división larga."
	
	(aDivisor isEqualTo: I) ifTrue:[^self].
	((aDivisor isEqualTo: self) or: (self-aDivisor < aDivisor)) ifTrue:[^I].
	(self < aDivisor) ifTrue: [^self error: 'Division te da fuera de los nat.']. "devolver error"
	^I + ((self-aDivisor)/aDivisor).
						
	
	! !

!II class methodsFor: '-- all --' stamp: 'JP 4/10/2024 14:45:55'!
< aNumber
	

	((aNumber isEqualTo: I) or:(aNumber isEqualTo: II))ifTrue:[^false].
	
	
	^(self previous) < (aNumber previous).! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'JP 4/17/2024 22:58:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JPA 3/25/2024 21:16:42'!
next
	"comment stating purpose of message"

	| nextNumber|
	nextNumber := II createChildNamed: self name,'I'.
	nextNumber previous: self.
	^nextNumber.! !

!II class methodsFor: '-- all --' stamp: 'JPA 3/25/2024 21:54:31'!
previous

	"Devuelve el anterior".

	^previous.
	! !

!II class methodsFor: '-- all --' stamp: 'JPA 3/25/2024 21:39:46'!
previous: aNumber
	"comment stating purpose of message"
	"COMO SETEO previous DE II SIN INSPECT??"
	previous:= aNumber.
	! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'JP 4/17/2024 22:58:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.! !


!classDefinition: #III category: #'Ejercicio 4 hecho bien'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4 hecho bien'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Ejercicio 4 hecho bien'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'JP 4/17/2024 22:58:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.! !


!classDefinition: #IIII category: #'Ejercicio 4 hecho bien'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4 hecho bien'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Ejercicio 4 hecho bien'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'JP 4/17/2024 22:58:55'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.! !


!classDefinition: #IIIII category: #'Ejercicio 4 hecho bien'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4 hecho bien'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #'Ejercicio 4 hecho bien'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'JP 4/17/2024 22:58:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIII.! !


!classDefinition: #IIIIII category: #'Ejercicio 4 hecho bien'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4 hecho bien'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #'Ejercicio 4 hecho bien'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JP 4/17/2024 22:58:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIII.! !


!classDefinition: #IIIIIII category: #'Ejercicio 4 hecho bien'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4 hecho bien'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: #'Ejercicio 4 hecho bien'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JP 4/17/2024 22:58:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: #'Ejercicio 4 hecho bien'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4 hecho bien'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: #'Ejercicio 4 hecho bien'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: '--** private fileout/in **--' stamp: 'JP 4/17/2024 22:58:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!