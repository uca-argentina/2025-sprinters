Class {
	#name : 'CardFactory',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'givenCards',
		'typesOfCards'
	],
	#classInstVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardFactory class >> with: typesOfCard [

	^ self new initializeWithTypesOfCards: typesOfCard
]

{ #category : 'accessing' }
CardFactory class >> withTypes: cardsTypes [

	^ self new initializeWithTypesOfCards: cardsTypes
]

{ #category : 'generators' }
CardFactory >> generateInitialCards [

	| initialCards |
	initialCards := OrderedCollection new.
	initialCards add: (self randomCard:
			 (Random new nextIntegerBetween: 1 and: typesOfCards size)).
	initialCards add: (self randomCard:
			 (Random new nextIntegerBetween: 1 and: typesOfCards size)).
	^ initialCards
]

{ #category : 'generators' }
CardFactory >> generateRandomCardOn: aShip [

	| card |
	typesOfCards := Card subclasses.
	cards := typesOfCards do: [ :type | type new generateRandomCard ].

	card := (cards at: (Random new nextIntegerBetween: 1 and: cards size))
		        new.
	aShip receiveThis: card generateRandomCard
]

{ #category : 'initialization' }
CardFactory >> initializeWithTypesOfCards: cardsTypes [

	typesOfCards := cardsTypes.
]

{ #category : 'generators' }
CardFactory >> randomCard: index [

	^ (typesOfCards at: index) generateRandomCard.
]
