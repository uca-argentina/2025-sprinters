Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'currentLap',
		'shields',
		'turnsToSkip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Ship class >> create: aName [

	aName isString ifFalse: [
		^ Error signal: 'Ship´s name must be a string.' ].

	^ self new initializeWith: aName
]

{ #category : 'instance creation' }
Ship class >> newShip [
	^ self new initializePosition.
]

{ #category : 'initialization' }
Ship >> initializePosition [
	position := 0.
]

{ #category : 'initialization' }
Ship >> initializeWith: aName [

	currentLap := 1.
	position := 0.
	name := aName.
	shields := 3.
	turnsToSkip:=0.
]

{ #category : 'as yet unclassified' }
Ship >> loseShield [

	shields := shields - 1.
	shields = 0 ifTrue: [ turnsToSkip := 2 ]
]

{ #category : 'as yet unclassified' }
Ship >> move: numberOfCells [ 
	position := position + numberOfCells.
]

{ #category : 'as yet unclassified' }
Ship >> move: numberOfCells in: aBoard [

	| boardCells |
	position := position + numberOfCells.
	boardCells := aBoard showCells.
	currentLap := currentLap + (position // aBoard showCells).
	position > boardCells ifTrue: [
		position := aBoard showLaps > 1
			            ifTrue: [ position \\ boardCells ]
			            ifFalse: [ aBoard showCells ] ].
	position := aBoard verifyPosition: self
]

{ #category : 'as yet unclassified' }
Ship >> showLaps [

	^ currentLap
]

{ #category : 'as yet unclassified' }
Ship >> showName [

	^ name.
]

{ #category : 'as yet unclassified' }
Ship >> showPosition [
	^ position.
]

{ #category : 'as yet unclassified' }
Ship >> showShields [
	^shields
]

{ #category : 'as yet unclassified' }
Ship >> wantsToPlay [

	^ true
]

{ #category : 'as yet unclassified' }
Ship >> winAt: aBoard [

	^ position >= aBoard showCells
]

{ #category : 'accessing' }
Ship >> winAt: cells until: laps [

	^ currentLap > laps 
]
