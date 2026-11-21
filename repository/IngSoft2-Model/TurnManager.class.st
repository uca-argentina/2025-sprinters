Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'turn',
		'penalties'
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
	penalties := IdentityDictionary new
]

{ #category : 'private' }
TurnManager >> isPenalized: aShip [

	^ (penalties at: aShip ifAbsent: [ 0 ]) > 0
]

{ #category : 'playing' }
TurnManager >> nextShip [

	| ship |
	ship := self shipInTurnOrder.
	[ self isPenalized: ship ] whileTrue: [
		self servePenaltyOf: ship.
		ship := self shipInTurnOrder ].
	^ ship
]

{ #category : 'penalizing' }
TurnManager >> penalize: aShip turns: anAmountOfTurns [

	penalties at: aShip put: anAmountOfTurns
]

{ #category : 'private' }
TurnManager >> servePenaltyOf: aShip [

	penalties at: aShip put: (penalties at: aShip) - 1
]

{ #category : 'accessing' }
TurnManager >> shipInTurn [

	| simulatedTurn simulatedPenalties ship |
	simulatedTurn := turn.
	simulatedPenalties := penalties copy.
	[
	ship := ships at: simulatedTurn.
	(simulatedPenalties at: ship ifAbsent: [ 0 ]) > 0 ] whileTrue: [
		simulatedPenalties at: ship put: (simulatedPenalties at: ship) - 1.
		simulatedTurn := simulatedTurn \\ ships size + 1 ].
	^ ship
]

{ #category : 'private' }
TurnManager >> shipInTurnOrder [

	| ship |
	ship := ships at: turn.
	turn := turn \\ ships size + 1.
	^ ship
]
