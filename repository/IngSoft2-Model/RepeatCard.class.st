Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RepeatCard >> applyTo: aShip using: aShip2 in: aGame [

	aGame applyRepeatCardEffectOn: aShip2
]
