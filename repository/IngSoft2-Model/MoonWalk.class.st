Class {
	#name : 'MoonWalk',
	#superclass : 'Object',
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

{ #category : 'as yet unclassified' }
MoonWalk >> applyTo: aShip in: aGame [

	aGame applyMoonWalkEffectOn: aShip  moving: numberOfCells
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: cells [

	numberOfCells := cells
]

{ #category : 'as yet unclassified' }
MoonWalk >> showName [

	^ 'Moon Walk'
]
