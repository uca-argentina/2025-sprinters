Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
PermanentCard >> activeCardBy: aShip targeting: aTarget in: aGame [

	self subclassResponsibility
]

{ #category : 'playing' }
PermanentCard >> applyBy: aShip targeting: aTarget in: aGame [

	aGame activate: (self activeCardBy: aShip targeting: aTarget in: aGame)
]

{ #category : 'playing' }
PermanentCard >> validatePlayBy: aShip in: aGame [

	aGame validateTurnOf: aShip
]
