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

	| actualShip totalShips turnsSkipped shipIndex |
	totalShips := ships size.
	turnsSkipped := 0.
	shipIndex := turn.
	[ turnsSkipped < totalShips ] whileTrue: [
		actualShip := ships at: shipIndex.
		actualShip wantsToPlay
			ifTrue: [
				turn := shipIndex \\ totalShips + 1. " es para que en caso de que este en la ultima nave vuelva a empezar en la nave 1"
				^ actualShip ]
			ifFalse: [
				turnsSkipped := turnsSkipped + 1.
				shipIndex := shipIndex \\ totalShips + 1 ] ].
	actualShip := ships at: turn.
	turn := turn \\ totalShips + 1.

	^ actualShip
]
