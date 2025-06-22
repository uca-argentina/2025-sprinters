Class {
	#name : 'FixedCardFactory',
	#superclass : 'CardFactory',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'accessing' }
FixedCardFactory class >> withTypes: cardsTypes [

	^ self new initializeWithTypesOfCards: cardsTypes
]

{ #category : 'as yet unclassified' }
FixedCardFactory >> generateInitialCards [

	| initialCards |
	initialCards := OrderedCollection new.
	initialCards add: (typesOfCards at: 1).
	initialCards add: (typesOfCards at: 2).
	^ initialCards
]

{ #category : 'initialization' }
FixedCardFactory >> initializeWithTypesOfCards: cardsTypes [

	typesOfCards := cardsTypes.
]
