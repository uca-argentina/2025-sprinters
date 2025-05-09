Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'tablero',
		'bucketDeDados',
		'naves',
		'ganador'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> with: aTablero and: aBucketDados and: aNave [ 
	^ self new initializeWith: aTablero and: aBucketDados and: aNave.
]

{ #category : 'as yet unclassified' }
Game >> algunaNaveGano [
	
	ganador := naves detect: [:n | n ganoEn: tablero] ifNone: [nil].
	
	^ ganador isNotNil.

	

]

{ #category : 'initialization' }
Game >> initializeWith: aTablero and: aBucketDados and: aCollectionOfNaves [ 
	tablero := aTablero.
	bucketDeDados := aBucketDados.
	naves := aCollectionOfNaves.
	ganador := nil.
]

{ #category : 'as yet unclassified' }
Game >> jugar [

	[ self algunaNaveGano = false ] whileTrue: [
		naves do: [ :unaNave | unaNave moverNave: bucketDeDados tirarBucket ] ].
	^ 'fin'
]

{ #category : 'as yet unclassified' }
Game >> mostrarGanador [
	^ ganador.
]
