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

	^ self new initializeWith: aAmountOfCells
]

{ #category : 'as yet unclassified' }
Board class >> with: amountOfCells and: aWorm [

	amountOfCells isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	amountOfCells < 1 ifTrue: [
		^ Error signal:
			  'Amount of cells must be greater than zero' ].

	(aWorm isInside: amountOfCells) ifFalse: [
		^ Error signal:
			  'Position of the worm hole exceed amount board`s cells' ].

	^ self new initializeWith: amountOfCells and: aWorm
]

{ #category : 'initialization' }
Board >> initializeWith: aAmountOfCells [ 
	amountOfCells := aAmountOfCells.
]

{ #category : 'initialization' }
Board >> initializeWith: aAmountOfCells and: aWorm [ 
	amountOfCells := aAmountOfCells.
	wormHole := aWorm.
]

{ #category : 'as yet unclassified' }
Board >> showCells [
	^ amountOfCells .
]

{ #category : 'as yet unclassified' }
Board >> showSpecialCells [
	^ wormHole showPositions: self.
	




]

{ #category : 'as yet unclassified' }
Board >> showWormHoleCell: aCollection [ 
	| wormPositions |
	wormPositions := aCollection.
	^ wormPositions.
]
