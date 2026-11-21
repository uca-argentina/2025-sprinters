Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
RepeatCard >> applyBy: aShip targeting: aShipName in: aGame [

	aGame repeatLastEffectOn: (aGame shipNamed: aShipName)
]
