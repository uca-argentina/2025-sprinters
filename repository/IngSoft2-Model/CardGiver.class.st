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

{ #category : 'playing' }
CardGiver >> applyTo: aShip in: aGame [

	| cardFactory |
	cardFactory := CardFactory new.
	cardFactory generateRandomCardOn: aShip
]
