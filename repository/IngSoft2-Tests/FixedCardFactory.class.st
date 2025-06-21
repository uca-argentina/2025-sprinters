Class {
	#name : 'FixedCardFactory',
	#superclass : 'CardFactory',
	#instVars : [
		'card'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
FixedCardFactory class >> with: aTypeOfCard [

	^ self new initializeWith: aTypeOfCard
]

{ #category : 'as yet unclassified' }
FixedCardFactory >> generateInitialCards [

	| cards |
	cards := OrderedCollection new.
	cards add: card.
	cards add: card.
	^ cards
]

{ #category : 'initialization' }
FixedCardFactory >> initializeWith: aCard [

	card := aCard
]
