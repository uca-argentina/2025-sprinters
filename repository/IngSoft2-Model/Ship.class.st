Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'currentLap',
		'shields',
		'turnsToSkip',
		'diceBucket'
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

{ #category : 'as yet unclassified' }
Ship class >> create: aName with: aDiceBucket [

	^ self new initializeWith: aName and: aDiceBucket
]

{ #category : 'instance creation' }
Ship class >> newShip [
	^ self new initializePosition.
]

{ #category : 'testing' }
Ship >> canPlay [

	^ turnsToSkip = 0
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

{ #category : 'initialization' }
Ship >> initializeWith: aName and: aDiceBucket [

	name := aName.
	diceBucket := aDiceBucket.
	position := 0.
	currentLap := 0.
	turnsToSkip := 0.
	shields := 3
]

{ #category : 'as yet unclassified' }
Ship >> loseFight [

	self loseShield.
	position := 0
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

	| totalCells newPosition |
	totalCells := aBoard showCells.
	newPosition := position + numberOfCells.

	currentLap := currentLap + (newPosition // totalCells).

	position := newPosition < 0
		            ifTrue: [ 0 ]
		            ifFalse: [
			            aBoard showLaps > 1
				            ifTrue: [ newPosition \\ totalCells + 1 ]
				            ifFalse: [
					            newPosition < 0 ifTrue: [ 0 ].
					            newPosition > totalCells
						            ifTrue: [ totalCells ]
						            ifFalse: [ newPosition ] ] ]
]

{ #category : 'as yet unclassified' }
Ship >> moveIn: aBoard [

	| boardCells |
	position := position + self throwDices.
	boardCells := aBoard showCells.
	currentLap := currentLap + (position // aBoard showCells).
	position > boardCells ifTrue: [
		position := aBoard showLaps > 1
			            ifTrue: [ position \\ boardCells ]
			            ifFalse: [ aBoard showCells ] ].
	position := aBoard verifyPosition: self
]

{ #category : 'as yet unclassified' }
Ship >> moveToFirstPosition [

	position := 0
]

{ #category : 'as yet unclassified' }
Ship >> recoverShields [

	shields := 3.
	turnsToSkip :=0.
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
Ship >> skipTurn [

	turnsToSkip := turnsToSkip - 1
]

{ #category : 'as yet unclassified' }
Ship >> throwDices [

	^ diceBucket throw
]

{ #category : 'as yet unclassified' }
Ship >> turnsThatHasToSkip [
	^turnsToSkip 
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

	^ currentLap >= laps 
]
