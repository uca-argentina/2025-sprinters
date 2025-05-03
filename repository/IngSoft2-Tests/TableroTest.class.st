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
TableroTest >> test000WhenCreamosTableroConCantidadDeCasillerosYGusanoThenMostrarCantidadDeCasilleros [

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

{ #category : 'tests' }
TableroTest >> test003WhenCreamosTableroConCantidadDeCasillerosMenoresa1ThenReturnsError [

	| cantidadDeCasilleros unGusano |
	cantidadDeCasilleros := 0.
	unGusano := Gusano with: 4 and: 11. 
	self 
	
	should: [ Tablero with: cantidadDeCasilleros and: unGusano.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Cantidad de casilleros en el tablero debe ser mayor a 0' ].
]

{ #category : 'tests' }
TableroTest >> test004WhenCreamosTableroConCantidadDeCasillerosNoEnteroThenReturnsError [

	| cantidadDeCasilleros unGusano |
	cantidadDeCasilleros := 3.14.
	unGusano := Gusano with: 4 and: 11. 
	self 
	
	should: [ Tablero with: cantidadDeCasilleros and: unGusano.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Cantidad de casillero no es un numero entero' ].
]
