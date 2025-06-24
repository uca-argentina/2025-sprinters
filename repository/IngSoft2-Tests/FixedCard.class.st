Class {
	#name : 'FixedCard',
	#superclass : 'Object',
	#instVars : [
		'card'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
FixedCard class >> withTypeOfCard: aCard [

^ self new initializeWithA: aCard.
]

{ #category : 'as yet unclassified' }
FixedCard >> generateRandomCard [

	^ card
]

{ #category : 'initialization' }
FixedCard >> initializeWithA: aCard [

	card := aCard
]
