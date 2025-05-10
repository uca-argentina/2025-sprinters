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
Game class >> with: aBoard and: aBucketOfDices and: aShip [ 
	^ self new initializeWith: aBoard and: aBucketOfDices and: aShip.
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard and: aBucketOfDices and: aBucketOfShips [ 
	board := aBoard.
	bucketOfDices := aBucketOfDices.
	ships := aBucketOfShips.
	winner := nil.
]

{ #category : 'as yet unclassified' }
Game >> play [	
[ self someShipWon = false ] whileTrue: [
	ships do: [ :aShip |
		aShip moveShip: bucketOfDices throwBucket in: board.
		self someShipWon ifTrue: [ ^ 'Game over' ] ] ].
^ 'Game over'

]

{ #category : 'as yet unclassified' }
Game >> showShipsPositions [ winner
	ifNotNil: [ ^ ships collect: [ :ship | ship showPosition ] ]
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
