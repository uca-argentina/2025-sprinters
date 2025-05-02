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
