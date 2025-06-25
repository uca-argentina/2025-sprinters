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
		'bonusBattle',
		'shipsIAmMercenaryTo',
		'amIMercenary'
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
Ship >> cards [

	^ cards
]

{ #category : 'as yet unclassified' }
Ship >> choiceToNotPlay [

	self recoverShields.
	turnsToSkip := turnsToSkip + 1
]

{ #category : 'as yet unclassified' }
Ship >> decreaseBonusThrow [
	bonusThrow := bonusThrow -1.
]

{ #category : 'as yet unclassified' }
Ship >> giveBonusThrow [
	^ bonusThrow.
]

{ #category : 'testing' }
Ship >> hasAsMercery: aShip [

	^ bonusBattle anySatisfy: [ :ship | aShip = ship name ]
]

{ #category : 'as yet unclassified' }
Ship >> helpToFightWith: aDiceBucket [

	^ aDiceBucket throw
]

{ #category : 'as yet unclassified' }
Ship >> increaseBonusThrow [
	bonusThrow := bonusThrow +1.
]

{ #category : 'initialization' }
Ship >> initializeWith: aName [

	currentLap := 1.
	position := 1.
	name := aName.
	shields := 3.
	turnsToSkip := 0.
	optionalTurn := true.
	bonusThrow := 0.
	bonusBattle := OrderedCollection new.
	shipsIAmMercenaryTo := OrderedCollection new.
	amIMercenary:=false.
]

{ #category : 'testing' }
Ship >> isAheadOf: anotherShip [

	^ self laps > anotherShip laps or: [
		  self laps = anotherShip laps and: [
			  self position > anotherShip position ] ]
]

{ #category : 'testing' }
Ship >> isNotMercenaryAnymore [
	amIMercenary := false.
]

{ #category : 'testing' }
Ship >> isSomeoneMercenary [
	^ amIMercenary.
]

{ #category : 'accessing' }
Ship >> laps [

	^ currentLap
]

{ #category : 'as yet unclassified' }
Ship >> loseFight [

	bonusBattle do:[:mercenaryShip|mercenaryShip loseShield ].
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
Ship >> markedAsMercenary [
	amIMercenary := true.
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

{ #category : 'as yet unclassified' }
Ship >> popThisMercenary: shipBeingMercenary [ 
	bonusBattle remove: shipBeingMercenary .
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
Ship >> receiveCard: aClass [ 
	self shouldBeImplemented.
]

{ #category : 'as yet unclassified' }
Ship >> receiveHyperJumpIn: aBoard moving: numberOfParsecs [

	| result |
	result := aBoard move: position at: currentLap having: numberOfParsecs.
	position := result at: 1.
	currentLap := result at: 2
]

{ #category : 'as yet unclassified' }
Ship >> receiveMercenaryCardEffectWith: aShip [

	aShip isSomeoneMercenary ifTrue: [ Error signal:'You can not use this ship as a mercenary' ] ifFalse: [ bonusBattle add: aShip. aShip markedAsMercenary].
	
]

{ #category : 'as yet unclassified' }
Ship >> receiveSpeedCardEffect [
	self increaseBonusThrow .
]

{ #category : 'as yet unclassified' }
Ship >> receiveThis: aCard [

	cards add: aCard
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

{ #category : 'removing' }
Ship >> removeAccelerationCardEffect [
	self decreaseBonusThrow.
]

{ #category : 'removing' }
Ship >> removeSpeedCardEffect [
	self decreaseBonusThrow .
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
Ship >> throwDicesWith: aDiceBucket [

	| count |
	count := 0.
	bonusBattle do: [ :mercenaryShip |
		count := count + (mercenaryShip helpToFightWith: aDiceBucket) ].
	^ aDiceBucket throw + count
]

{ #category : 'as yet unclassified' }
Ship >> turnsThatHasToSkip [

	^ turnsToSkip
]

{ #category : 'as yet unclassified' }
Ship >> use: aCard with: aShip [

	| index |
	index := cards indexOf: (cards
			          detect: [ :card | card class = aCard class ]
			          ifNone: [
			          Error signal:
				          'You can not use a card that you do not have' ]).
	aCard applyTo: self using: aShip.
	cards removeAt: index
]

{ #category : 'as yet unclassified' }
Ship >> use: aCard with: aShip in:aGame [

	| index |
	index := cards indexOf: (cards value
			          detect: [ :card | card class = aCard class ]
			          ifNone: [
			          Error signal:
				          'You can not use a card that you do not have' ]).
	aCard applyTo: self using: aShip in: aGame.
	aGame addToActiveCardsThisCard: aCard .
	cards removeAt: index.
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
