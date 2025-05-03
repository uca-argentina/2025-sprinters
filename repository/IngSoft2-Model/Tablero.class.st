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
