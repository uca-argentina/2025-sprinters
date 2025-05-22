Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'amountOfCells',
		'wormHole'
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
Board >> initializeWith: arg1 [

	amountOfCells := arg1
]

{ #category : 'initialization' }
Board >> initializeWith: aAmountOfCells and: aWormHole [
	amountOfCells := aAmountOfCells.
	wormHole := aWormHole
]

{ #category : 'as yet unclassified' }
Board >> showCells [

	^ amountOfCells
]

{ #category : 'as yet unclassified' }
Board >> showSpecialCells [

	^ wormHole showPositions: self
]

{ #category : 'as yet unclassified' }
Board >> verifyPosition: aShip [
	wormHole ifNotNil: [ ^ wormHole transportIfConnectedTo: aShip showPosition. ].
	^ aShip showPosition .
]
