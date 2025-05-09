Class {
	#name : 'Worm',
	#superclass : 'Object',
	#instVars : [
		'x',
		'y'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Worm class >> with: aX and: aY [
	(aX isInteger and: [ aY isInteger ]) ifFalse: [
		^ Error signal: 'Posiciones del agujero deben ser enteros' ].
	(aX > 0 and: [ aY > 0 ]) ifFalse: [
		^ Error signal:
			  'Posiciones del agujero de gusano deben ser mayor a 0' ].
	(aX = aY) ifTrue: [
		^ Error signal:
			  'Posiciones del agujero de gusano no pueden ser iguales' ].
	
	^ self new initializeWith: aX and: aY
]

{ #category : 'as yet unclassified' }
Worm >> estaDentro: aCantidadDeCasilleros [ 
	^ ((x between: 0 and: aCantidadDeCasilleros) and: [y between: 0 and: aCantidadDeCasilleros]) . 
]

{ #category : 'initialization' }
Worm >> initializeWith: aX and: aY [ 
	x := aX.
	y := aY.
]

{ #category : 'as yet unclassified' }
Worm >> posicionX [
	^ x.
]

{ #category : 'as yet unclassified' }
Worm >> posicionY [
	^ y.
]

{ #category : 'as yet unclassified' }
Worm >> showPositions: aTablero [ 
	^ aTablero showWormHoleCell: { x. y. } .
]
