Class {
	#name : 'FixCardGiver',
	#superclass : 'CardGiver',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
FixCardGiver >> generateInitialCards [
	^ card at:1
]

{ #category : 'initialization' }
FixCardGiver >> initializeThis [

	^ self
]
