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
	aCara > 0 ifFalse: [
		^ Error signal: 'Numero de caras debe ser mayor a 0'].
	
	^ self new initializeWith: aCara
]

{ #category : 'asserting' }
Dado >> assertValid: aCara [

	aCara > 0 ifFalse: [
		^ Error signal: 'Numero de caras debe ser mayor 0'].
	
	^ true.
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
	numeroRandom := (Random new nextIntegerBetween: 1 and: cantidadCaras ).
	^ numeroRandom.
]
