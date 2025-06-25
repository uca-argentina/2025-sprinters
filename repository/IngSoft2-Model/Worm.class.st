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
	
	^ self new initializeWith: aX positionsOn: aY
]

{ #category : 'initialization' }
Worm >> initializeWith: aX positionsOn: aY [

	positionX := aX.
	positionY := aY
]

{ #category : 'playing' }
Worm >> isInside: aAmountOfCells [ 
	^ ((positionX between: 0 and: aAmountOfCells) and: [positionY between: 0 and: aAmountOfCells]) . 
]

{ #category : 'playing' }
Worm >> positionX [
	^ positionX.
]

{ #category : 'playing' }
Worm >> positionY [
	^ positionY.
]

{ #category : 'playing' }
Worm >> positions: aBoard [ 
	^ { positionX. positionY. } .
]

{ #category : 'playing' }
Worm >> transportIfConnectedTo: aPosition [

	aPosition = positionX ifTrue: [ ^ positionY ].
	aPosition = positionY ifTrue: [ ^ positionX ].

	^ aPosition
]
