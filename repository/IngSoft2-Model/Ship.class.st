Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'currentLap',
		'shields',
		'turnsToSkip',
		'diceBucket',
		'optionalTurn'
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

{ #category : 'testing' }
Ship >> canPlay [

	^ turnsToSkip = 0
]

{ #category : 'as yet unclassified' }
Ship >> choiceToNotPlay [
	optionalTurn:=false. 
	self recoverShields.
	
	
]

{ #category : 'initialization' }
Ship >> initializeWith: aName [

	currentLap := 1.
	position := 1.
	name := aName.
	shields := 3.
	turnsToSkip:=0.
	optionalTurn:=true
]

{ #category : 'testing' }
Ship >> isAheadOf: anotherShip [

	^ self laps > anotherShip laps or: [
		  self laps = anotherShip laps and: [
			  self position > anotherShip position ] ]
]

{ #category : 'accessing' }
Ship >> laps [

	^ currentLap
]

{ #category : 'as yet unclassified' }
Ship >> loseFight [

	self loseShield.
	position := 1
]

{ #category : 'as yet unclassified' }
Ship >> loseShield [

	shields := shields - 1.
	shields = 0 ifFalse: [ ^ self ].

	self recoverShields.
	turnsToSkip := 2
]

{ #category : 'as yet unclassified' }
Ship >> move: numberOfCells in: aBoard [

	| newPosition result |
	newPosition := position + numberOfCells.
	result := aBoard move: newPosition at: currentLap having: 0.
	position := result at: 1.
	position := aBoard verifyPosition: position.
	currentLap := result at: 2
]

{ #category : 'as yet unclassified' }
Ship >> moveByParsecs: parsecs on: aBoard [

	| result |
	result := aBoard move: position at: currentLap having: parsecs.
	position := result at: 1.
	currentLap := result at: 2
]

{ #category : 'as yet unclassified' }
Ship >> moveToFirstPosition [

	position := 1
]

{ #category : 'accessing' }
Ship >> name [

	^ name
]

{ #category : 'accessing' }
Ship >> position [

	^ position
]

{ #category : 'as yet unclassified' }
Ship >> receiveAtomicBombEffect [
	self moveToFirstPosition. 
	self loseShield.
]

{ #category : 'as yet unclassified' }
Ship >> receiveBlackHoleEffectFrom: aBoard [

	| newPosition result |
	newPosition := position - 4.
	result := aBoard move: newPosition at: currentLap having: 0.
	position := result at: 1.
	currentLap := result at: 2
]

{ #category : 'as yet unclassified' }
Ship >> receiveHyperJumpIn: aBoard moving: numberOfParsecs [
	self moveByParsecs: numberOfParsecs on: aBoard
]

{ #category : 'as yet unclassified' }
Ship >> recieveHyperSpaceJumpIn: aBoard [

	| newPosition result |
	newPosition := position + 4.
	result := aBoard move: newPosition at: currentLap having: 0.
	position := result at: 1.
	currentLap := result at: 2.
	self loseShield
]

{ #category : 'as yet unclassified' }
Ship >> recoverShields [

	shields := 3.
	turnsToSkip :=0.
	optionalTurn :=true.
]

{ #category : 'accessing' }
Ship >> shields [

	^ shields
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

	^ turnsToSkip
]

{ #category : 'as yet unclassified' }
Ship >> wantsToPlay [

	^ optionalTurn 
]

{ #category : 'as yet unclassified' }
Ship >> winAt: aBoard [

	^ position >= aBoard amountOfCells
]

{ #category : 'accessing' }
Ship >> winAt: arg1 until: arg2 [

	^ currentLap >= arg2
]
