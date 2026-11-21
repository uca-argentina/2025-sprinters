Class {
	#name : 'Worm',
	#superclass : 'Effect',
	#instVars : [
		'positionX',
		'positionY'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
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

{ #category : 'playing' }
Worm >> applyTo: aShip in: aGame [

	aGame teleport: aShip to: (self otherEndOf: aShip position)
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

{ #category : 'private' }
Worm >> otherEndOf: aCell [

	^ aCell = positionX
		  ifTrue: [ positionY ]
		  ifFalse: [ positionX ]
]

{ #category : 'playing' }
Worm >> positions [
	^ { positionX. positionY. } .
]
