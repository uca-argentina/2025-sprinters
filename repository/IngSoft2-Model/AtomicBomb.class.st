Class {
	#name : 'AtomicBomb',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBomb >> applyTo: aShip in: aGame [

	aGame applyAtomicEffectOn: aShip
]

{ #category : 'as yet unclassified' }
AtomicBomb >> showName [

	^ 'Atomic Bomb'
]
