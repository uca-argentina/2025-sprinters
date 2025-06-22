Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
RedoCard >> applyTo: aShip using: aShip2 in: aGame [

	aGame applyRedoCardEffectOn: aShip
]

{ #category : 'as yet unclassified' }
RedoCard >> generateRandomCard [

	^ self
]

{ #category : 'testing' }
RedoCard >> isRedo [

	^ true
]
