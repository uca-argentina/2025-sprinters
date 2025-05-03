Class {
	#name : 'TableroTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TableroTest >> test000WhenCreamosTableroConCantidadDeCasillerosThenMostrarCantidadDeCasilleros [

	| unTablero cantidadDeCasilleros |
	cantidadDeCasilleros := 10.
	unTablero := Tablero with: cantidadDeCasilleros.
	self assert: unTablero mostrarCasilleros equals: cantidadDeCasilleros
]

{ #category : 'tests' }
TableroTest >> test001WhenCreamosTableroConCantidadDeCasillerosYGusanoThenMostrarCantidadDeCasilleros [

	| unTablero cantidadDeCasilleros unGusano aX aY |
	cantidadDeCasilleros := 10.
	aX := 4.
	aY := 6.
	unGusano := Gusano with: aX and: aY. 
	unTablero := Tablero with: cantidadDeCasilleros and: unGusano.
	self assert: unTablero mostrarCasillerosEspeciales equals: {aX. aY}.
]

{ #category : 'tests' }
TableroTest >> test002WhenCreamosTableroConCantidadDeCasillerosYGusanoErroneosThenReturnsError [

	| cantidadDeCasilleros unGusano |
	cantidadDeCasilleros := 10.
	unGusano := Gusano with: 4 and: 11. 
	self 
	
	should: [ Tablero with: cantidadDeCasilleros and: unGusano.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Posiciones de agujero de gusanos excede cantidad de casilleros de tablero' ].
]
