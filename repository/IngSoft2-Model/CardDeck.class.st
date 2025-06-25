Class {
	#name : 'CardDeck',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'givenCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardDeck class >> withDeck: cards [ 
	^ self new initializeWithDeck: cards.
]

{ #category : 'accessing' }
CardDeck >> cards [

	^ cards
]

{ #category : 'playing' }
CardDeck >> dealCard [

	| card |
	card := cards atRandom.
	givenCards add: card.
	cards remove: card.
	^ card
]

{ #category : 'initialization' }
CardDeck >> initializeWithDeck: aSetOfcards [

	cards := aSetOfcards.
	givenCards := OrderedCollection new
]
