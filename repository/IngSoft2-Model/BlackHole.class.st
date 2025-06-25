Class {
	#name : 'BlackHole',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHole class >> applyTo: aShip in: aGame [ 
	self shouldBeImplemented.
]

{ #category : 'initialization' }
BlackHole class >> initializeThis [
	^ self new.
]

{ #category : 'playing' }
BlackHole >> applyTo: aShip in: aGame [

	aGame applyBlackHoleEffectOn: aShip
]
