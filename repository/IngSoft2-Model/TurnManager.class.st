Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'turn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TurnManager class >> with: ships [

	ships isEmpty ifTrue: [
		^ Error signal: 'Ships must to have one item at least' ].
	^ self new initializeWith: ships
]

{ #category : 'initialization' }
TurnManager >> initializeWith: shipCollection [ 
	turn := 1.
	ships := shipCollection.
]

{ #category : 'as yet unclassified' }
TurnManager >> nextShip [

	| actualShip |
	actualShip := ships at: turn.
	ships size = turn
		ifTrue: [
			actualShip wantsToPlay "ultimo jujador quiere jugar?"
				ifTrue: [ turn := 1 ] " iultimo jugador juega y el siguiente es el 1 --Z vuelve a empezar"
				ifFalse: [
					actualShip := (ships at: 1). " iultimo jugador NO juega , el actual es el 1 y el siguiente es el 2 "
					turn := 2] ] 
		ifFalse: [
			actualShip wantsToPlay "NO es el ultimo jujador quiere jugar?"
				ifTrue: [ turn := turn + 1 ]  
				ifFalse: [
					actualShip := (ships at: (turn + 1)). "jugador simple el actual va a ser el siguiente"
					turn := (turn + 2) ] ].

	^ actualShip
]
