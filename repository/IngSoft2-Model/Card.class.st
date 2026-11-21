Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
Card >> applyBy: aShip targeting: aTarget in: aGame [

	self subclassResponsibility
]

{ #category : 'playing' }
Card >> playBy: aShip targeting: aTarget in: aGame [

	self validatePlayBy: aShip in: aGame.
	self applyBy: aShip targeting: aTarget in: aGame
]

{ #category : 'playing' }
Card >> registerIn: aCardManager [

	aCardManager registerPlayed: self
]

{ #category : 'playing' }
Card >> validatePlayBy: aShip in: aGame [

	self subclassResponsibility
]
