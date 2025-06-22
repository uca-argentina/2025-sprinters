Class {
	#name : 'CardGiver',
	#superclass : 'Object',
	#instVars : [
		'card'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardGiver class >> initializeThis [

	^ self new
]

{ #category : 'instance creation' }
CardGiver class >> with: aCard [

	^ self new initializeWith: aCard
]

{ #category : 'as yet unclassified' }
CardGiver >> applyTo: aShip in: aGame [

	| cardFactory |
	cardFactory := CardFactory new.
	cardFactory generateRandomCardOn: aShip
]

{ #category : 'initialization' }
CardGiver >> initializeWith: aCard [

	card := aCard
]
