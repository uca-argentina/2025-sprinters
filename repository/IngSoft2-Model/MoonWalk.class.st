Class {
	#name : 'MoonWalk',
	#superclass : 'Effect',
	#instVars : [
		'numberOfCells'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
MoonWalk class >> move: numberOfCells [

	numberOfCells <= 0 ifTrue: [
		Error signal: 'Amount of cells must be greater than zero' ].

	^ self new initializeWith: numberOfCells
]

{ #category : 'playing' }
MoonWalk >> applyTo: aShip in: aGame [

	aGame moveAllShipsExcept: aShip by: numberOfCells negated
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: cells [

	numberOfCells := cells
]
