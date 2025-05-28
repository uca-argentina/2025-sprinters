Class {
	#name : 'BlackHole',
	#superclass : 'Object',
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

{ #category : 'as yet unclassified' }
BlackHole >> applyTo: aShip in: aGame [

	aShip receiveBlackHoleEffectFrom: aGame
]

{ #category : 'as yet unclassified' }
BlackHole >> effectOnMovement [
	^ -4.
]

{ #category : 'initialization' }
BlackHole >> initializeThis [
	^ self new.
]

{ #category : 'as yet unclassified' }
BlackHole >> showName [

	^ 'Black Hole'
]
