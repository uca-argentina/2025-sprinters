Class {
	#name : 'LoadedDice',
	#superclass : 'Object',
	#instVars : [
		'amountOfFaces'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
LoadedDice class >> with: aAmountOfFaces [

	^ self new initializeWith: aAmountOfFaces
]

{ #category : 'initialization' }
LoadedDice >> initializeWith: aAmountOfFaces [

	amountOfFaces := aAmountOfFaces.
	
]

{ #category : 'as yet unclassified' }
LoadedDice >> throw [

	^ amountOfFaces
]
