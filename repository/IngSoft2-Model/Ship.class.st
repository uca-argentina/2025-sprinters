Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'posicion'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Ship class >> newShip [
	^ self new initializePosicion.
]

{ #category : 'as yet unclassified' }
Ship >> ganoEn: aTablero [

	^ posicion > aTablero showCells
]

{ #category : 'initialization' }
Ship >> initializePosicion [
	posicion := 0.
]

{ #category : 'as yet unclassified' }
Ship >> mostrarPosicion [
	^ posicion.
]

{ #category : 'as yet unclassified' }
Ship >> moverNave: numeroDeCasillas [ 
	posicion := posicion + numeroDeCasillas.
]
