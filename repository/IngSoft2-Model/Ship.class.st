Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Ship class >> newShip [
	^ self new initializePosition.
]

{ #category : 'initialization' }
Ship >> initializePosition [
	position := 0.
]

{ #category : 'as yet unclassified' }
Ship >> moveShip: numberOfCells [ 
	position := position + numberOfCells.
]

{ #category : 'as yet unclassified' }
Ship >> moveShip: numberOfCells in: aBoard [

	position + numberOfCells > aBoard showCells
		ifTrue: [ position := aBoard showCells ]
		ifFalse: [ position := position + numberOfCells ].
	position := aBoard verifyPosition: self
]

{ #category : 'as yet unclassified' }
Ship >> showPosition [
	^ position.
]

{ #category : 'as yet unclassified' }
Ship >> winAt: aBoard [

	^ position > aBoard showCells
]
