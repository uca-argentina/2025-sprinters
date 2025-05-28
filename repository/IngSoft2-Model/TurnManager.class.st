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
TurnManager >> nextPlayableShip [

	| totalShips turnsSkipped ship |
	totalShips := ships size.
	turnsSkipped := 0.

	[ turnsSkipped < totalShips ] whileTrue: [
		ship := ships at: turn.
		turn := turn \\ totalShips + 1.
		ship canPlay
			ifTrue: [ ^ ship ]
			ifFalse: [
				ship skipTurn.
				turnsSkipped := turnsSkipped + 1 ] ].
	Error signal: 'There is no ship witch can play'
]

{ #category : 'as yet unclassified' }
TurnManager >> nextShip [

	^ self nextShipThatWantToPlay: self nextPlayableShip
]

{ #category : 'as yet unclassified' }
TurnManager >> nextShipThatWantToPlay: actualShip [

	actualShip wantsToPlay
		ifTrue: [ ^ actualShip ]
		ifFalse: [
			actualShip skipTurn.
			^ self nextShip ]
]
