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
		'optionalTurn',
		'cards',
		'bonusThrow',
		'bonusBattle'
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
Ship class >> create: aName with: aDiceBucket andReceiveCardsFrom: aCardFactory [

	aName isString ifFalse: [
		^ Error signal: 'Ship´s name must be a string.' ].

	^ self new initializeWith: aName and: aDiceBucket using: aCardFactory
]

{ #category : 'as yet unclassified' }
Ship class >> create: aName withDeck: aCardDeck [

	aName isString ifFalse: [
		^ Error signal: 'Ship´s name must be a string.' ].

	^ self new initializeWith: aName withADeck: aCardDeck
]

{ #category : 'testing' }
Ship >> canPlay [

	^ turnsToSkip = 0
]

{ #category : 'as yet unclassified' }
Ship >> cards [

	^ cards
]

{ #category : 'as yet unclassified' }
Ship >> choiceToNotPlay [

	self recoverShields.
	turnsToSkip := turnsToSkip + 1
]

{ #category : 'testing' }
Ship >> hasNotAsMercery: aShip [ 
	self shouldBeImplemented.
]

{ #category : 'initialization' }
Ship >> initializeWith: aName [

	currentLap := 1.
	position := 1.
	name := aName.
	shields := 3.
	turnsToSkip := 0.
	optionalTurn := true.
]

{ #category : 'initialization' }
Ship >> initializeWith: aName and: aDiceBucket using: aCardFactory [

	currentLap := 1.
	position := 1.
	name := aName.
	shields := 3.
	turnsToSkip := 0.
	optionalTurn := true.
	cards := aCardFactory generateInitialCards.
	diceBucket := aDiceBucket.
	bonusThrow := 0.
	bonusBattle := OrderedCollection new
]

{ #category : 'initialization' }
Ship >> initializeWith: aName withADeck: aCardDeck [

	| giver |
	currentLap := 1.
	position := 1.
	name := aName.
	shields := 3.
	turnsToSkip := 0.
	optionalTurn := true.
	giver := CardFactory new.
	cards := giver generateInitialCards.
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
Ship >> receiveHyperJumpIn: aBoard moving: numberOfCells [
	self move: numberOfCells in: aBoard
]

{ #category : 'as yet unclassified' }
Ship >> receiveMercenaryCardEffectWith: aShip [

	bonusBattle add: aShip
]

{ #category : 'as yet unclassified' }
Ship >> receiveSpeedCardEffect [

	bonusThrow := bonusThrow + 1
]

{ #category : 'as yet unclassified' }
Ship >> recieveCardsFrom: cardFactory [

	cards := cardFactory generateInitialCards
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
Ship >> throwBucket [

	^ diceBucket throw + self useBonusThrow
]

{ #category : 'as yet unclassified' }
Ship >> throwDices [

	^ diceBucket throw
]

{ #category : 'as yet unclassified' }
Ship >> throwDicesWith: aDiceBucket [

	^ aDiceBucket throw
]

{ #category : 'as yet unclassified' }
Ship >> turnsThatHasToSkip [

	^ turnsToSkip
]

{ #category : 'as yet unclassified' }
Ship >> use: aTypeOfCard [

	cards
		detect: [ :card | card classSide = aTypeOfCard classSide ]
		ifNone: [
		^ Error signal: 'You can not play a card that you do not have' ].
	aTypeOfCard applyTo: self
]

{ #category : 'as yet unclassified' }
Ship >> use: aCard with: aShip [

	aCard applyTo: self using: aShip
]

{ #category : 'as yet unclassified' }
Ship >> useBonusThrow [

	| increment |
	increment := 0.
	bonusThrow > 0 ifTrue: [ increment := 1 ].
	bonusThrow := bonusThrow - 1.
	^ increment
]

{ #category : 'as yet unclassified' }
Ship >> wantsToPlay [

	^ optionalTurn 
]

{ #category : 'as yet unclassified' }
Ship >> winAt: aBoard [

	^ (currentLap = aBoard laps and: position >= aBoard amountOfCells)
		  or: currentLap > aBoard laps
]
