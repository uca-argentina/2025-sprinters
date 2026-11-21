Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RedoCard >> applyBy: aShip targeting: aTarget in: aGame [

	aGame lastPlayedCard applyBy: aShip targeting: aTarget in: aGame
]

{ #category : 'as yet unclassified' }
RedoCard >> registerIn: aCardManager [

	^ self
]

{ #category : 'as yet unclassified' }
RedoCard >> validatePlayBy: aShip in: aGame [

	aGame lastPlayedCard validatePlayBy: aShip in: aGame
]
