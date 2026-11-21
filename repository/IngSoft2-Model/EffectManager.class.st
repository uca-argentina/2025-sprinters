Class {
	#name : 'EffectManager',
	#superclass : 'Object',
	#instVars : [
		'lastEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'applying' }
EffectManager >> apply: anEffect to: aShip in: aGame [

	anEffect applyTo: aShip in: aGame.
	lastEffect := anEffect
]

{ #category : 'initialization' }
EffectManager >> initialize [

	super initialize.
	lastEffect := NoEffect new
]

{ #category : 'as yet unclassified' }
EffectManager >> repeatLastEffectOn: aShip in: aGame [

	lastEffect applyTo: aShip in: aGame
]
