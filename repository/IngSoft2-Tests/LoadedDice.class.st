Class {
	#name : 'LoadedDice',
	#superclass : 'Object',
	#instVars : [
		'amountOfFaces',
		'index',
		'throwns'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
LoadedDice class >> with: aAmountOfFaces [

	^ self new initializeWith: aAmountOfFaces
]

{ #category : 'as yet unclassified' }
LoadedDice class >> withSequence: throwns [

	^ self new initializeWith: throwns
]

{ #category : 'initialization' }
LoadedDice >> initializeWith: amountOfThrowns [

	index := 1.
	throwns := amountOfThrowns
]

{ #category : 'as yet unclassified' }
LoadedDice >> throw [

	| result |
	result := throwns at: index.
	index := (index \\ throwns size + 1).
	^ result
]
