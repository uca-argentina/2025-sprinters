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

{ #category : 'playing' }
TurnManager >> findShipBy: shipName [

	^ ships detect: [ :ship | ship name = shipName ]
]

{ #category : 'initialization' }
TurnManager >> initializeWith: shipCollection [ 
	turn := 1.
	ships := shipCollection.
]

{ #category : 'playing' }
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
	Error signal: 'There is no ship witch can play' " --> esto lo podemos hacer pero para que el juego siga jugando si ninguna de las naves puede jugar entonces que la nabe juegue"
]

{ #category : 'playing' }
TurnManager >> nextShip [

	^ self nextShipThatWantToPlay: self nextPlayableShip
]

{ #category : 'playing' }
TurnManager >> nextShipThatWantToPlay: actualShip [

	actualShip wantsToPlay
		ifTrue: [ ^ actualShip ]
		ifFalse: [
			actualShip skipTurn.
			^ self nextShip ]
]

{ #category : 'playing' }
TurnManager >> skipTurnForShipNamed: shipName [	
	| shipFound |
	shipFound := self findShipBy: shipName.
	shipFound choiceToNotPlay.
]
