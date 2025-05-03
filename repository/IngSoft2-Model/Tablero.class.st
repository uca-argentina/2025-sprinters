Class {
	#name : 'Tablero',
	#superclass : 'Object',
	#instVars : [
		'cantidadDeCasilleros',
		'agujeroDeGusano'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Tablero class >> with: aCantidadDeCasilleros [
	^ self new initializeWith: aCantidadDeCasilleros.
]

{ #category : 'as yet unclassified' }
Tablero class >> with: aCantidadDeCasilleros and: aGusano [

	aCantidadDeCasilleros isInteger ifFalse: [
		^ Error signal: 'Cantidad de casillero no es un numero entero' ].
	aCantidadDeCasilleros < 1 ifTrue: [
		^ Error signal:
			  'Cantidad de casilleros en el tablero debe ser mayor a 0' ].

	(aGusano estaDentro: aCantidadDeCasilleros) ifFalse: [
		^ Error signal:
			  'Posiciones de agujero de gusanos excede cantidad de casilleros de tablero' ].

	^ self new initializeWith: aCantidadDeCasilleros and: aGusano
]

{ #category : 'initialization' }
Tablero >> initializeWith: aCantidadDeCasilleros [ 
	cantidadDeCasilleros := aCantidadDeCasilleros.
]

{ #category : 'initialization' }
Tablero >> initializeWith: aCantidadDeCasillero and: aGusano [ 
	cantidadDeCasilleros := aCantidadDeCasillero.
	agujeroDeGusano := aGusano.
]

{ #category : 'as yet unclassified' }
Tablero >> mostrarCasilleroDeGusano: aCollection [ 
	| posicionesDeGusano |
	posicionesDeGusano := aCollection.
	^ posicionesDeGusano.
]

{ #category : 'as yet unclassified' }
Tablero >> mostrarCasilleros [
	^ cantidadDeCasilleros.
]

{ #category : 'as yet unclassified' }
Tablero >> mostrarCasillerosEspeciales [
	^ agujeroDeGusano mostrarPosiciones: self.
	




]
