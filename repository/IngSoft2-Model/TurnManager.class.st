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
	^ self new initializeWith: ships.
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
	turn := ships size = turn
		        ifTrue: [ 1 ]
		        ifFalse: [ turn + 1 ].
	^ actualShip
]
