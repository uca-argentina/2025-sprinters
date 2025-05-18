Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Ship class >> createShip: aName [

	aName isString ifFalse: [
		^ Error signal: 'Ship´s name must be a string.' ].

	^ self new initializeWith: aName
]

{ #category : 'instance creation' }
Ship class >> newShip [
	^ self new initializePosition.
]

{ #category : 'initialization' }
Ship >> initializePosition [
	position := 0.
]

{ #category : 'initialization' }
Ship >> initializeWith: aName [

	position := 0.
	name := aName.
]

{ #category : 'as yet unclassified' }
Ship >> move: numberOfCells [ 
	position := position + numberOfCells.
]

{ #category : 'as yet unclassified' }
Ship >> move: numberOfCells in: aBoard [
	(position + numberOfCells) > (aBoard showCells)
		ifTrue: [ position := aBoard showCells ]
		ifFalse: [position := position + numberOfCells ].
	position := aBoard verifyPosition: self.
]

{ #category : 'as yet unclassified' }
Ship >> showName [

	^ name.
]

{ #category : 'as yet unclassified' }
Ship >> showPosition [
	^ position.
]

{ #category : 'as yet unclassified' }
Ship >> winAt: aBoard [

	^ position >= aBoard showCells
]
