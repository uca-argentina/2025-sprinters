Class {
	#name : 'Nave',
	#superclass : 'Object',
	#instVars : [
		'posicion'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Nave class >> newShip [
	^ self new initializePosicion.
]

{ #category : 'initialization' }
Nave >> initializePosicion [
	posicion := 0.
]

{ #category : 'as yet unclassified' }
Nave >> mostrarPosicion [
	^ posicion.
]

{ #category : 'as yet unclassified' }
Nave >> moverNave: numeroDeCasillas [ 
	posicion := posicion + numeroDeCasillas.
]
