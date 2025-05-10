Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'amountOfCells',
		'wormHole',
		'aFinalPosition',
		'listOfPositions'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> with: arg1 [

	arg1 isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	arg1 < 1 ifTrue: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	nil.
	^ self new initializeWith: arg1
]

{ #category : 'as yet unclassified' }
Board class >> with: arg1 and: arg2 [ 

	arg1 isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	arg1 < 1 ifTrue: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	(arg2 isInside: arg1) ifFalse: [
		^ Error signal:
			  'Position of the worm hole exceed amount board`s cells' ].
	^ self new initializeWith: arg1 and: arg2
]

{ #category : 'initialization' }
Board >> initializeWith: arg1 [

	amountOfCells := arg1
]

{ #category : 'initialization' }
Board >> initializeWith: arg1 and: arg2 [

	listOfPositions := OrderedCollection new: arg1 withAll: false.
	amountOfCells := arg1.
	wormHole := arg2
]

{ #category : 'as yet unclassified' }
Board >> positionTaken [

	^ listOfPositions
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
Board >> showWormHoleCell: arg1 [

	| tmp1 |
	tmp1 := arg1.
	^ tmp1
]

{ #category : 'as yet unclassified' }
Board >> verifyPosition: aShip [

	^ wormHole sendPosition: aShip showPosition
]
