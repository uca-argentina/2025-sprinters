Class {
	#name : 'BucketTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BucketTest >> test000WhenTiramos2DadosCon6CarasThenReturnNumeroEntre2YCaraDadoUnoYCaraDadoDos [

	| dadoUno dadoDos bucketDeDados listaDeDados jugadaDeDados |
	dadoUno := Dado with: 6.
	dadoDos := Dado with: 6.
	listaDeDados := OrderedCollection new: 2.
	listaDeDados add: dadoUno.
	listaDeDados add: dadoDos.
	bucketDeDados := BucketDados with: listaDeDados.
	jugadaDeDados := bucketDeDados tirarBucket.


	self assert: (jugadaDeDados between: listaDeDados size and: dadoUno caras + dadoDos caras).
]

{ #category : 'tests' }
BucketTest >> test003Banana [

	| dadoUno dadoDos bucketDeDados listaDeDados jugadaDeDados |
	dadoUno := Dado with: 6.
	dadoDos := Dado with: 6.
	listaDeDados := OrderedCollection new: 2.
	listaDeDados add: dadoUno.
	listaDeDados add: dadoDos.
	bucketDeDados := BucketDados with: listaDeDados.
	jugadaDeDados := bucketDeDados tirarBucket.


	self assert: (jugadaDeDados between: listaDeDados size and: dadoUno caras + dadoDos caras).
]
