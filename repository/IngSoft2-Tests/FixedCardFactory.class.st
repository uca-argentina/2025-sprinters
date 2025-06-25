Class {
	#name : 'FixedCardFactory',
	#superclass : 'CardFactory',
	#instVars : [
		'types'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
FixedCardFactory class >> with: typesOfCards [

	^ self new initializeWithTypes: typesOfCards
]

{ #category : 'as yet unclassified' }
FixedCardFactory >> generateInitialCards [

	| selectedTypes |
	selectedTypes := types size >= 2
		                 ifTrue: [ types first: 2 ]
		                 ifFalse: [
			                 {
				                 types first.
				                 types first } ].

	^ (selectedTypes collect: [ :aType | aType generateRandomCard ])
		  asOrderedCollection
]

{ #category : 'initialization' }
FixedCardFactory >> initializeWithTypes: typesOfCards [

	types := typesOfCards
]

{ #category : 'initialization' }
FixedCardFactory >> initializeWithTypesOfCards: cardsTypes [

	typesOfCards := cardsTypes.
]
