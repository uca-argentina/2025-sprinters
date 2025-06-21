Class {
	#name : 'CardFactory',
	#superclass : 'Object',
	#instVars : [
		'cards'
	],
	#classInstVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardFactory >> generateInitialCards [

	| cards |
	cards := OrderedCollection new.
	cards add: self randomCard.
	cards add: self randomCard.
	^ cards
]

{ #category : 'as yet unclassified' }
CardFactory >> randomCard [

	| random index |
	cards := {
		         SpeedCard.
		         AccelerationCard.
		         MercenaryCard.
		         CancellationCard.
		         RedoCard.
		         RepeatCard }.
	index := Random new nextIntegerBetween: 1 and: cards size.
	^ cards at: index
]
