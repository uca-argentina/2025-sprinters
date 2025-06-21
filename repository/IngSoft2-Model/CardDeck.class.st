Class {
	#name : 'CardDeck',
	#superclass : 'Object',
	#instVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardDeck class >> withDeck: cards [ 
	^ self new initializeWithDeck: cards.
]

{ #category : 'as yet unclassified' }
CardDeck >> amountOfCardsInDeck [

	^ cards size
]

{ #category : 'initialization' }
CardDeck >> initializeWithDeck: aSetOfcards [

	cards := aSetOfcards
]

{ #category : 'as yet unclassified' }
CardDeck >> randomCard [

	^ cards atRandom
]
