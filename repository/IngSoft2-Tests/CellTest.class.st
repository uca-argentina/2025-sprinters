Class {
	#name : 'CellTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
CellTest >> test000WhenACellHasBlackHoleEffectThenMoves4Backwards [

	| cell anEffect |
	anEffect := BlackHole new.
	cell := Cell with: anEffect.
	self assert: cell effect showName equals: 'Black Hole'
]
