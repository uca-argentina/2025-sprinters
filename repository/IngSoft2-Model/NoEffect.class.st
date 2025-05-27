Class {
	#name : 'NoEffect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
NoEffect class >> initializeThis [
	^ self new.
]

{ #category : 'as yet unclassified' }
NoEffect >> applyTo: aShip in: aGame [

	^ 'No effects are applied'
]
