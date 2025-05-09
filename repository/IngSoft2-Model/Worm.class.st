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
		^ Error signal: 'Worm holes positions must be integers' ].
	(aX > 0 and: [ aY > 0 ]) ifFalse: [
		^ Error signal:
			  'Worm holes positions must be greater than zero' ].
	(aX = aY) ifTrue: [
		^ Error signal:
			  'Worm holes positions must be different' ].
	
	^ self new initializeWith: aX and: aY
]

{ #category : 'initialization' }
Worm >> initializeWith: aX and: aY [ 
	x := aX.
	y := aY.
]

{ #category : 'as yet unclassified' }
Worm >> isInside: aAmountOfCells [ 
	^ ((x between: 0 and: aAmountOfCells) and: [y between: 0 and: aAmountOfCells]) . 
]

{ #category : 'as yet unclassified' }
Worm >> positionX [
	^ x.
]

{ #category : 'as yet unclassified' }
Worm >> positionY [
	^ y.
]

{ #category : 'as yet unclassified' }
Worm >> showPositions: aBoard [ 
	^ aBoard showWormHoleCell: { x. y. } .
]
