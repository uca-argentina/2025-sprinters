Class {
	#name : 'TestDado',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TestDado >> test000WhenCreoDadoCon5CarasThenCarasIgual5 [

	| unDado |
	unDado := Dado with: 5.
	self assert: unDado caras equals: 5.
]

{ #category : 'tests' }
TestDado >> test001WhenDadoNCarasTirarDadoThenReturnEntre1yNCaras [

	| unDado valorDado cantidadDeCaras|
	cantidadDeCaras := 5.
	unDado := Dado with: cantidadDeCaras.
	valorDado := unDado tirarDado.
	self assert: (valorDado between: 1 and: cantidadDeCaras).
]

{ #category : 'tests' }
TestDado >> testBanana [

	
]
