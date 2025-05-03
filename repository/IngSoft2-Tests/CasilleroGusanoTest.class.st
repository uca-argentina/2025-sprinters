Class {
	#name : 'CasilleroGusanoTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CasilleroGusanoTest >> test000WhenCreamosUnCasilleroAgujeroDeGusanoThenPuedenMostrarPosiciones [

	| unGusano unX unY |
	unX := 2.
	unY := 3.
	unGusano := Gusano with: unX and: unY.
	self assert:
		(unGusano posicionX = unX and: [ unGusano posicionY = unY ])
]

{ #category : 'tests' }
CasilleroGusanoTest >> test001WhenCreamosGusanoConXoYNegativoThenReturnsError [

	self 
	
	should: [ Gusano with: -4 and: -6 ]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Posiciones del agujero de gusano deben ser mayor a 0' ].
]

{ #category : 'tests' }
CasilleroGusanoTest >> test002WhenCreamosGusanoConXeYIgualesThenReturnsError [

	self 
	
	should: [ Gusano with: 4 and: 4 ]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Posiciones del agujero de gusano no pueden ser iguales' ].
]

{ #category : 'tests' }
CasilleroGusanoTest >> test003WhenCreamosGusanoConXeYNoEnterosThenReturnsError [

	self
		should: [ Gusano with: 3.14 and: '4' ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Posiciones del agujero deben ser enteros' ]
]
