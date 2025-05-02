Class {
	#name : 'JuegoTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
JuegoTest >> test000WhenCreamosTableroConCantidadDeCasillerosThenMostrarCantidadDeCasilleros [

	| unaNave listaDeDados unDado unBucketDeDados jugadaDeDados unTablero cantidadDeCasilleros |
	unaNave := Nave newShip.
	listaDeDados := OrderedCollection new.
	unDado := Dado with: 5.
	listaDeDados add: unDado.
	unBucketDeDados := BucketDados with: listaDeDados.
	cantidadDeCasilleros := 10.
	unTablero := Tablero with: cantidadDeCasilleros.

	jugadaDeDados := unBucketDeDados tirarBucket.
	unaNave moverNave: jugadaDeDados.

	self assert: unaNave mostrarPosicion equals: jugadaDeDados
]

{ #category : 'tests' }
JuegoTest >> test001Banana [

	| unaNave listaDeDados unDado unBucketDeDados jugadaDeDados unTablero cantidadDeCasilleros |
	unaNave := Nave newShip.
	listaDeDados := OrderedCollection new.
	unDado := Dado with: 13.
	listaDeDados add: unDado.
	unBucketDeDados := BucketDados with: listaDeDados.
	cantidadDeCasilleros := 10.
	unTablero := Tablero with: cantidadDeCasilleros.

	jugadaDeDados := unBucketDeDados tirarBucket.
	unaNave moverNave: jugadaDeDados.

	self assert: unaNave mostrarPosicion equals: jugadaDeDados.
]
