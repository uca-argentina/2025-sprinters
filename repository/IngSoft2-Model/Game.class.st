Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'winner',
		'board',
		'bucketOfDices',
		'ships',
		'status',
		'turnManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> with: aBoard using: aDiceBucket andShipsNamed: shipsNames [

	| listOfShips |
	shipsNames size = 0 ifTrue: [
		^ Error signal: 'List of ships must not be empty.' ].
	listOfShips := Set new.
	shipsNames do: [ :ship | listOfShips add: ship ].
	listOfShips size = shipsNames size ifFalse: [
		^ Error signal: 'Ship´s name must not be reapeated.' ].
	^ self new
		  initializeWith: aBoard
		  using: aDiceBucket
		  andShipsNamed: shipsNames
]

{ #category : 'as yet unclassified' }
Game class >> with: aCircularBoard using: aLoadedDice andShipsNamed: aCollection until: anInteger [

	^ self new 
		  initializeWith: aCircularBoard
		  using: aLoadedDice
		  andShipsNamed: aCollection
		  until: anInteger
]

{ #category : 'as yet unclassified' }
Game >> currentStatus [

	^ status
]

{ #category : 'as yet unclassified' }
Game >> currentTopPlayer [

	| topShip topPosition |
	topShip := ships at: 1.
	topPosition := topShip showPosition.
	ships do: [ :ship |
		ship showPosition > topPosition ifTrue: [
			topShip := ship.
			topPosition := ship showPosition ] ].
	^ topShip
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard  using: aDiceBucket andShipsNamed: shipsNames [

	board := aBoard.
	bucketOfDices := aDiceBucket.
	ships := shipsNames collect: [ :aName | Ship create: aName ].
	status := NotPlayed new.
	turnManager:= TurnManager with:ships
]

{ #category : 'initialization' }
Game >> initializeWith: aCircularBoard using: aDiceBucket andShipsNamed: shipsNames until: numberOfLaps [

	board := aCircularBoard with:numberOfLaps .
	bucketOfDices := aDiceBucket.
	ships := shipsNames collect: [ :aName | Ship create: aName ].
	status := NotPlayed new.
	turnManager:= TurnManager with:ships.
	
	
]

{ #category : 'as yet unclassified' }
Game >> play [

	status := Started new.
	[ self someShipWon = false ] whileTrue: [
		turnManager nextShip move: bucketOfDices throw in: board ].
	status := Finished new.

	^ 'Game over'
]

{ #category : 'accessing' }
Game >> ships [
	^ ships
]

{ #category : 'as yet unclassified' }
Game >> showShipsPositions [

	winner
		ifNotNil: [
			| result |
			result := Dictionary new.
			ships do: [ :ship |
				result at: ship showName put: ship showPosition ].
			^ result ]
		ifNil: [ ^ 'The Game is not over' ]
]

{ #category : 'as yet unclassified' }
Game >> showWinner [
	^ winner.
]

{ #category : 'as yet unclassified' }
Game >> someShipWon [

	| laps |
	laps := board showLaps.
	winner := ships
		          detect: [ :ship |
			          laps isNil
				          ifTrue: [ ship winAt: board ]
				          ifFalse: [ ship winAt: board until: laps ] ]
		          ifNone: [ nil ].

	^ winner isNotNil
]
