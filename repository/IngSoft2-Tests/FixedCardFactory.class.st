Class {
	#name : 'FixedCardFactory',
	#superclass : 'CardFactory',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
FixedCardFactory class >> generateInitialCardsUsing: aRandom [

	| cards |
	cards := OrderedCollection new.
	cards add: self randomCardUsing: aRandom.
	cards add: self randomCardUsing: aRandom.
	^ cards
]
