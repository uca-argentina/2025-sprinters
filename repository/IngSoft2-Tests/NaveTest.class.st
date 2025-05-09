Class {
	#name : 'NaveTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
NaveTest >> test000WhenCreateNaveThenPosicionIgualACero [

| unaNave |

unaNave := Ship newShip.

self assert: unaNave mostrarPosicion equals: 0.
]

{ #category : 'tests' }
NaveTest >> test001WhenNaveRecibeUnNumeroThenSeMueveEsaCantidad [

| unaNave jugadaDeDados |

unaNave := Ship newShip.
jugadaDeDados := 2.
unaNave moverNave: jugadaDeDados.

self assert: unaNave mostrarPosicion equals: jugadaDeDados .
]
