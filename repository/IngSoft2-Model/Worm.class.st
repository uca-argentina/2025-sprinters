Class {
	#name : 'Worm',
	#superclass : 'Object',
	#instVars : [
		'positionX',
		'positionY'
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

	positionX := aX.
	positionY := aY
]

{ #category : 'as yet unclassified' }
Worm >> isInside: aAmountOfCells [ 
	^ ((positionX between: 0 and: aAmountOfCells) and: [positionY between: 0 and: aAmountOfCells]) . 
]

{ #category : 'as yet unclassified' }
Worm >> positionX [
	^ positionX.
]

{ #category : 'as yet unclassified' }
Worm >> positionY [
	^ positionY.
]

{ #category : 'as yet unclassified' }
Worm >> showPositions: aBoard [ 
	^ { positionX. positionY. } .
]

{ #category : 'as yet unclassified' }
Worm >> transportIfConnectedTo: aPosition [

	aPosition = positionX ifTrue: [ ^ positionY ].
	aPosition = positionY ifTrue: [ ^ positionX ].

	^ aPosition
]
