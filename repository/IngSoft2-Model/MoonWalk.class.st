Class {
	#name : 'MoonWalk',
	#superclass : 'Effect',
	#instVars : [
		'numberOfCells'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
MoonWalk class >> initializeThis [
	^ self new initializeWith: 10.
]

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

{ #category : 'accessing' }
MoonWalk >> numberOfCells [
	^ numberOfCells
]
