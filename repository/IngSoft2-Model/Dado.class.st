Class {
	#name : 'Dado',
	#superclass : 'Object',
	#instVars : [
		'cantidadCaras'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Dado class >> with: aCara [
	^ self new initializeWith: aCara.
]

{ #category : 'as yet unclassified' }
Dado >> caras [
	^ cantidadCaras.
]

{ #category : 'initialization' }
Dado >> initializeWith: aCara [ 
	cantidadCaras := aCara. 
]

{ #category : 'as yet unclassified' }
Dado >> tirarDado [
	| numeroRandom |
	numeroRandom := 1 + (Random new nextIntegerBetween: 1 and: cantidadCaras ).
	^ numeroRandom.
]
