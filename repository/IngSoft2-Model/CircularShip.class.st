Class {
	#name : 'CircularShip',
	#superclass : 'Ship',
	#instVars : [
		'currentLap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CircularShip >> initializeWith: aName [
	currentLap := 0.
	position := 0.
	name := aName.
]

{ #category : 'as yet unclassified' }
CircularShip >> move: numberOfCells in: aBoard [
	position := position + numberOfCells.
	currentLap := currentLap + ( position  // aBoard showCells ).
	position := aBoard verifyPosition: self.
]

{ #category : 'as yet unclassified' }
CircularShip >> showLaps [
	^ currentLap.
]
