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

	^ self shipsSortedByPosition at: 1.
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

{ #category : 'testing' }
Game >> isBefore: shipA than: shipB [

	^ (ships indexOf: shipA) < (ships indexOf: shipB)
]

{ #category : 'as yet unclassified' }
Game >> play [

	| actualShip cellsToMove |
	status := Started new.
	[ self someShipWon = false ] whileTrue: [
		actualShip := turnManager nextShip.
		cellsToMove := bucketOfDices throw.
		actualShip move: cellsToMove in: board ].
	status := Finished new.

	^ 'Game over'
]

{ #category : 'accessing' }
Game >> ships [
	^ ships
]

{ #category : 'as yet unclassified' }
Game >> shipsSortedByPosition [

	^ ships copy sort: [ :a :b |
		  a showLaps > b showLaps or: [
			  a showLaps = b showLaps and: [
				  a showPosition > b showPosition or: [
					  a showPosition = b showPosition and: [
						  self isBefore: a than: b ] ] ] ] ]
]

{ #category : 'as yet unclassified' }
Game >> showRanking [

	| top ranking sorted |
	status isFinished
		ifTrue: [
			top := 1.
			ranking := OrderedCollection new.
			sorted := self shipsSortedByPosition.

			[ top <= 3 and: [ top <= sorted size ] ] whileTrue: [
				ranking add: (sorted at: top) showName.
				top := top + 1 ].
			^ ranking ]
		ifFalse: [
			Error signal:
				'The Game has not been played yet so it doesn`t have a ranking' ]
]

{ #category : 'as yet unclassified' }
Game >> showShipsPositions [

	status isFinished 
		ifTrue: [
			| result |
			result := Dictionary new.
			ships do: [ :ship |
				result at: ship showName put: ship showPosition ].
			^ result ]
		ifFalse: [ ^ 'The Game is not over' ]
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
