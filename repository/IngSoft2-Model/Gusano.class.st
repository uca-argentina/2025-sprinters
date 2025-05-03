Class {
	#name : 'Gusano',
	#superclass : 'Object',
	#instVars : [
		'x',
		'y'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Gusano class >> with: aX and: aY [
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

{ #category : 'initialization' }
Gusano >> initializeWith: aX and: aY [ 
	x := aX.
	y := aY.
]

{ #category : 'as yet unclassified' }
Gusano >> posicionX [
	^ x.
]

{ #category : 'as yet unclassified' }
Gusano >> posicionY [
	^ y.
]
