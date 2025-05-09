Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test000WhenCreamosTableroConCantidadDeCasillerosThenMostrarCantidadDeCasilleros [

	| unTablero cantidadDeCasilleros |
	cantidadDeCasilleros := 10.
	unTablero := Board with: cantidadDeCasilleros.
	self assert: unTablero showCells equals: cantidadDeCasilleros
]

{ #category : 'tests' }
BoardTest >> test000WhenCreamosTableroConCantidadDeCasillerosYGusanoThenMostrarCantidadDeCasilleros [

	| unTablero cantidadDeCasilleros unGusano aX aY |
	cantidadDeCasilleros := 10.
	aX := 4.
	aY := 6.
	unGusano := Worm with: aX and: aY. 
	unTablero := Board with: cantidadDeCasilleros and: unGusano.
	self assert: unTablero showSpecialCells equals: {aX. aY}.
]

{ #category : 'tests' }
BoardTest >> test002WhenCreamosTableroConCantidadDeCasillerosYGusanoErroneosThenReturnsError [

	| cantidadDeCasilleros unGusano |
	cantidadDeCasilleros := 10.
	unGusano := Worm with: 4 and: 11. 
	self 
	
	should: [ Board with: cantidadDeCasilleros and: unGusano.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Posiciones de agujero de gusanos excede cantidad de casilleros de tablero' ].
]

{ #category : 'tests' }
BoardTest >> test003WhenCreamosTableroConCantidadDeCasillerosMenoresa1ThenReturnsError [

	| cantidadDeCasilleros unGusano |
	cantidadDeCasilleros := 0.
	unGusano := Worm with: 4 and: 11. 
	self 
	
	should: [ Board with: cantidadDeCasilleros and: unGusano.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Cantidad de casilleros en el tablero debe ser mayor a 0' ].
]

{ #category : 'tests' }
BoardTest >> test004WhenCreamosTableroConCantidadDeCasillerosNoEnteroThenReturnsError [

	| cantidadDeCasilleros unGusano |
	cantidadDeCasilleros := 3.14.
	unGusano := Worm with: 4 and: 11. 
	self 
	
	should: [ Board with: cantidadDeCasilleros and: unGusano.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Cantidad de casillero no es un numero entero' ].
]
