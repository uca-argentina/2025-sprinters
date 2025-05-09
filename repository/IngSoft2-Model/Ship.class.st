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
Ship >> showPosition [
	^ position.
]

{ #category : 'as yet unclassified' }
Ship >> winAt: aBoard [

	^ position > aBoard showCells
]
