Class {
	#name : 'AtomicBomb',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomicBomb class >> initializeThis [
	^ self new.
]

{ #category : 'as yet unclassified' }
AtomicBomb >> applyTo: aShip in: aGame [

	aGame applyAtomicEffectOn: aShip
]
