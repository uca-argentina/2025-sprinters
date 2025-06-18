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

{ #category : 'as yet unclassified' }
Ship >> choiceToNotPlay [
	optionalTurn:=false. 
	self recoverShields.
	
	
]

{ #category : 'initialization' }
Ship >> initializePosition [
	position := 1.
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

{ #category : 'initialization' }
Ship >> initializeWith: aName and: aDiceBucket [

	name := aName.
	diceBucket := aDiceBucket.
	position := 1.
	currentLap := 0.
	turnsToSkip := 0.
	shields := 3.
	optionalTurn:=true
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
	shields = 0 ifTrue: [ turnsToSkip := 2 ]
]

{ #category : 'as yet unclassified' }
Ship >> move: numberOfCells [ 
	position := position + numberOfCells.
]

{ #category : 'as yet unclassified' }
Ship >> move: numberOfCells in: aBoard [

	| totalCells newPosition |
	totalCells := aBoard amountOfCells.
	newPosition := position + numberOfCells.

	currentLap := currentLap + (newPosition // totalCells).

	position := newPosition <= 0
		            ifTrue: [ 1 ]
		            ifFalse: [
			            aBoard laps > 1
				            ifTrue: [ newPosition \\ totalCells ]
				            ifFalse: [
					            newPosition <= 0 ifTrue: [ 1 ].
					            newPosition > totalCells
						            ifTrue: [ totalCells ]
						            ifFalse: [ newPosition ] ] ].
	position := aBoard verifyPosition: self
]

{ #category : 'as yet unclassified' }
Ship >> moveByParsecs: parsecs on: aBoard [
 "escenario  --> 7 parsecs y 5 celas --> 1.4 parsecs/celd"
	| boardSize currentParsec newParsecPos newPosition |
	boardSize := aBoard amountOfCells. "5 casilleros"
	currentParsec := position * aBoard parsecsPerCell. " 2 * 1.4 = 2.8 parsecs"
	newParsecPos := currentParsec + parsecs. " 8 parsecs´+ 2.8 parsec = 10.8 parsecs"
	newPosition := newParsecPos // aBoard parsecsPerCell. " (10.8 parsecs / (1.4 parsec/celda ) = 1 celdas "
	currentLap := currentLap + (newPosition // boardSize).
	position := newPosition > boardSize
		            ifTrue: [
			            aBoard laps > 1
				            ifTrue: [ newPosition \\ boardSize ]
				            ifFalse: [ boardSize ] ]
		            ifFalse: [ newPosition ].
	position <= 0 ifTrue: [ position := 1 ].
	position := aBoard verifyPosition: self
]

{ #category : 'as yet unclassified' }
Ship >> moveIn: aBoard [

	| boardCells |
	position := position + self throwDices.
	boardCells := aBoard amountOfCells.
	currentLap := currentLap + (position // aBoard amountOfCells).
	position > boardCells ifTrue: [
		position := aBoard laps > 1
			            ifTrue: [ position \\ boardCells. ]
			            ifFalse: [ aBoard amountOfCells ] ].
	position := aBoard verifyPosition: self
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
	self  loseShield.
]

{ #category : 'as yet unclassified' }
Ship >> receiveBlackHoleEffect [

	self move: -4
]

{ #category : 'as yet unclassified' }
Ship >> receiveBlackHoleEffectFrom: aGame [ 
	self move:-4 in:aGame board
	
]

{ #category : 'as yet unclassified' }
Ship >> receiveHyperJumpIn: aBoard moving: numberOfParsecs [
	self moveByParsecs: numberOfParsecs on: aBoard
]

{ #category : 'as yet unclassified' }
Ship >> recieveHyperSpaceJumpIn: aBoard [ 
	self move: 4 in: aBoard.
	self loseShield
]

{ #category : 'as yet unclassified' }
Ship >> recoverShields [

	shields := 3.
	turnsToSkip :=0.
	optionalTurn :=true.
]

{ #category : 'as yet unclassified' }
Ship >> showName [

	^ name.
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
