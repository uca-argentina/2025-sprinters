Class {
	#name : 'JuegoTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
JuegoTest >> test000WhenCreamosTableroConCantidadDeCasillerosYGusanoThenMostrarCantidadDeCasilleros [

	| unaNave listaDeDados unDado unBucketDeDados jugadaDeDados unTablero cantidadDeCasilleros unGusano unJuego listaDeNaves naveUno naveDos |
	
	listaDeNaves := OrderedCollection new.
	naveUno := Nave newShip.
	naveDos := Nave newShip.
	listaDeDados := OrderedCollection new.
	listaDeNaves add: naveUno.
	listaDeNaves add: naveDos.
	unDado := Dado with: 5.
	listaDeDados add: unDado.
	unBucketDeDados := BucketDados with: listaDeDados.
	cantidadDeCasilleros := 10.
	unGusano := Gusano with: 2 and: 4.
	unTablero := Tablero with: cantidadDeCasilleros and: unGusano.
	unJuego := Game with: unTablero and: unBucketDeDados and: listaDeNaves.
	
	self assert: unJuego jugar equals: 'fin'.
]
