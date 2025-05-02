Class {
	#name : 'Tablero',
	#superclass : 'Object',
	#instVars : [
		'cantidadDeCasilleros'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Tablero class >> with: aCantidadDeCasilleros [
	^ self new initializeWith: aCantidadDeCasilleros.
]

{ #category : 'initialization' }
Tablero >> initializeWith: aCantidadDeCasilleros [ 
	cantidadDeCasilleros := aCantidadDeCasilleros.
]

{ #category : 'as yet unclassified' }
Tablero >> mostrarCasilleros [
	^ cantidadDeCasilleros.
]
