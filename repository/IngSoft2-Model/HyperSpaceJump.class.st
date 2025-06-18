Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperSpaceJump class >> initializeThis [
	^ self new.
]

{ #category : 'as yet unclassified' }
HyperSpaceJump >> applyTo: aShip in: aGame [

	aGame applyHyperSpaceJumpEffectOn: aShip
]

{ #category : 'as yet unclassified' }
HyperSpaceJump >> showName [

	^ 'Hyper Space Jump'
]
