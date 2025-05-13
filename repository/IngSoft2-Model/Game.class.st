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
	aListOfShips do: [ :ship | listOfShips add: ship showName ].
	listOfShips size = aListOfShips size ifFalse: [
		^ Error signal: 'Ship´s name must not be reapeated.' ].
	^ self new
		  initializeWith: aBoard
		  and: aBucketOfDices
		  and: aListOfShips
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
