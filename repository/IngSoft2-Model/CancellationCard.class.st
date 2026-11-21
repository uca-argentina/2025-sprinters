Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
CancellationCard >> applyBy: aShip targeting: anActiveCard in: aGame [

	aGame cancel: anActiveCard
]
