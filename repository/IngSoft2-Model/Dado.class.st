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
Dado class >> with: numeroDeCaras [
	numeroDeCaras > 0 ifFalse: [
		^ Error signal: 'Numero de caras debe ser mayor a 0'].
	
	^ self new initializeWith: numeroDeCaras.
]

{ #category : 'as yet unclassified' }
Dado >> caras [
	^ cantidadCaras.
]

{ #category : 'initialization' }
Dado >> initializeWith: numeroDeCaras [
	cantidadCaras := numeroDeCaras. 
]

{ #category : 'as yet unclassified' }
Dado >> tirarDado [
	| numeroRandom |
	numeroRandom := (Random new nextIntegerBetween: 1 and: cantidadCaras ).
	^ numeroRandom.
]
