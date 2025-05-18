Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'winner',
		'board',
		'bucketOfDices',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> with: aBoard and: aBucketOfDices and: aListOfShips [

	| listOfShips |
	aListOfShips size = 0 ifTrue: [
		^ Error signal: 'List of ships must not be empty.' ].
	listOfShips := Set new.
	aListOfShips do: [ :ship | listOfShips add: ship ].
	listOfShips size = aListOfShips size ifFalse: [
		^ Error signal: 'Ship´s name must not be reapeated.' ].
	^ self new
		  initializeWith: aBoard
		  and: aBucketOfDices
		  and: aListOfShips
]

{ #category : 'as yet unclassified' }
Game class >> withBoard: aBoard usingDice: aDiceBucket andShipsNamed: shipsNames [

	| listOfShips |
	shipsNames size = 0 ifTrue: [
		^ Error signal: 'List of ships must not be empty.' ].
	listOfShips := Set new.
	shipsNames do: [ :ship | listOfShips add: ship ].
	listOfShips size = shipsNames size ifFalse: [
		^ Error signal: 'Ship´s name must not be reapeated.' ].
	^ self new
		  initializeWithBoard: aBoard
		  usingDice: aDiceBucket
		  andShipsNamed: shipsNames
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
Game >> initializeWith: aBoard and: aBucketOfDices and: aListOfShips [

	board := aBoard.
	bucketOfDices := aBucketOfDices.
	ships := aListOfShips collect: [ :aName | Ship createShip: aName ].
	winner := nil
]

{ #category : 'initialization' }
Game >> initializeWithBoard: aBoard  usingDice: aDiceBucket andShipsNamed: shipsNames [

	board := aBoard.
	bucketOfDices := aDiceBucket.
	ships := shipsNames collect: [ :aName | Ship createShip: aName ].
	winner := nil
]

{ #category : 'as yet unclassified' }
Game >> play [	
[ self someShipWon = false ] whileTrue: [
	ships do: [ :aShip |
		aShip move: bucketOfDices throw in: board.
		self someShipWon ifTrue: [ ^ 'Game over' ] ] ].
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
	
	winner := ships detect: [:n | n winAt: board ] ifNone: [nil].
	
	^ winner isNotNil.

	

]
