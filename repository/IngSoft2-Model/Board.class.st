Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'amountOfCells',
		'wormHole',
		'laps',
		'distributions',
		'cells'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> with: aAmountOfCells [

	aAmountOfCells isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	aAmountOfCells < 1 ifTrue: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	nil.
	^ self new initializeWith: aAmountOfCells
]

{ #category : 'as yet unclassified' }
Board class >> with: aAmountOfCells and: aWormHole [ 

	aAmountOfCells isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	aAmountOfCells < 1 ifTrue: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	(aWormHole isInside: aAmountOfCells) ifFalse: [
		^ Error signal:
			  'Position of the worm hole exceed amount board`s cells' ].
	^ self new initializeWith: aAmountOfCells and: aWormHole
]

{ #category : 'initialization' }
Board >> initializeWith: cells [

	amountOfCells := cells.
	laps := 1
]

{ #category : 'initialization' }
Board >> initializeWith: aAmountOfCells and: aWormHole [
	amountOfCells := aAmountOfCells.
	wormHole := aWormHole.
	laps:=1.
]

{ #category : 'as yet unclassified' }
Board >> showCells [

	^ amountOfCells
]

{ #category : 'as yet unclassified' }
Board >> showLaps [

	^ laps
]

{ #category : 'as yet unclassified' }
Board >> showSpecialCells [

	^ wormHole showPositions: self
]

{ #category : 'as yet unclassified' }
Board >> verifyPosition: aShip [

	| shipPosition |
	shipPosition := aShip showPosition.
	wormHole ifNotNil: [
		^ wormHole transportIfConnectedTo: aShip showPosition ].
	^ shipPosition   
]

{ #category : 'instance creation' }
Board >> with: aNumberOfLaps [

	laps := aNumberOfLaps
]
