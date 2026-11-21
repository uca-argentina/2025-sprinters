Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'bucketOfDices',
		'ships',
		'status',
		'turnManager',
		'battleManager',
		'cardManager',
		'effectManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validating' }
Game class >> validateUniqueNames: shipNames [

	shipNames asSet size = shipNames size ifFalse: [
		^ Error signal: 'Ship´s name must not be reapeated.' ].
	^ shipNames
]

{ #category : 'creation' }
Game class >> with: aBoard using: aDiceBucket andShipsNamed: shipNames deck: aDeck [

	shipNames ifEmpty: [ ^ Error signal: 'List of ships must not be empty.' ].
	self validateUniqueNames: shipNames.
	^ self new
		  initializeWith: aBoard
		  using: aDiceBucket
		  andShipsNamed: shipNames
		  deck: aDeck
]

{ #category : 'card rules' }
Game >> activate: anActiveCard [

	cardManager activate: anActiveCard
]

{ #category : 'cards' }
Game >> activeCards [

	^ cardManager activeCards
]

{ #category : 'battle' }
Game >> areAllied: aShip with: anotherShip [

	^ ((self mercenariesOf: aShip) includes: anotherShip) or: [
		  (self mercenariesOf: anotherShip) includes: aShip ]
]

{ #category : 'card rules' }
Game >> cancel: anActiveCard [

	cardManager cancel: anActiveCard
]

{ #category : 'cards' }
Game >> cardsOf: aShipName [

	^ (cardManager handOf: (self shipNamed: aShipName)) copy
]

{ #category : 'effects' }
Game >> cellsIn: aDistance [

	^ board cellsIn: aDistance
]

{ #category : 'effects' }
Game >> damage: aShip [

	aShip loseShield.
	aShip isDefenseless ifTrue: [ self penalize: aShip ]
]

{ #category : 'effects' }
Game >> damageAllShips [

	ships do: [ :ship | self damage: ship ]
]

{ #category : 'private' }
Game >> finish [

	status := Finished new
]

{ #category : 'private' }
Game >> finishIfSomeShipWon [

	(ships anySatisfy: [ :ship | ship winAt: board ]) ifTrue: [ self finish ]
]

{ #category : 'effects' }
Game >> giveCardTo: aShip [

	cardManager giveCardTo: aShip
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard using: aDiceBucket andShipsNamed: shipNames deck: aDeck [

	board := aBoard.
	ships := shipNames collect: [ :shipName | Ship create: shipName ].
	bucketOfDices := aDiceBucket.
	status := Started new.
	turnManager := TurnManager with: ships.
	battleManager := BattleManager new.
	effectManager := EffectManager new.
	cardManager := CardManager with: aDeck.
	ships do: [ :ship | cardManager dealInitialCardsTo: ship ]
]

{ #category : 'private' }
Game >> keepPlaying [

	status keepPlaying: self
]

{ #category : 'querying' }
Game >> lapOf: aShipName [

	^ (self shipNamed: aShipName) laps
]

{ #category : 'card rules' }
Game >> lastPlayedCard [

	^ cardManager lastPlayedCard
]

{ #category : 'private' }
Game >> leaderName [

	^ self shipsSortedByPosition first name
]

{ #category : 'battle' }
Game >> mercenariesOf: aShip [

	^ cardManager mercenariesOf: aShip
]

{ #category : 'effects' }
Game >> move: aShip by: anAmountOfCells [

	board move: aShip by: anAmountOfCells
]

{ #category : 'effects' }
Game >> moveAllShipsExcept: aShip by: anAmountOfCells [

	(ships copyWithout: aShip) do: [ :ship |
		board move: ship by: anAmountOfCells ]
]

{ #category : 'private' }
Game >> penalize: aShip [

	turnManager penalize: aShip turns: 2.
	aShip restoreShields
]

{ #category : 'playing' }
Game >> play [

	status play: self
]

{ #category : 'private' }
Game >> playNextTurn [

	| currentShip |
	currentShip := turnManager nextShip.
	board move: currentShip by: (self rollFor: currentShip).
	(currentShip winAt: board) ifTrue: [ ^ self finish ].
	effectManager
		apply: (board effectOnPosition: currentShip position)
		to: currentShip
		in: self.
	battleManager resolveBattlesOf: currentShip in: self.
	self finishIfSomeShipWon
]

{ #category : 'playing' }
Game >> playTurn [

	status playTurnOf: self
]

{ #category : 'querying' }
Game >> positionOf: aShipName [

	^ (self shipNamed: aShipName) position
]

{ #category : 'querying' }
Game >> positions [

	| result |
	result := Dictionary new.
	ships do: [ :ship | result at: ship name put: ship position ].
	^ result
]

{ #category : 'querying' }
Game >> ranking [

	^ status rankingOf: self
]

{ #category : 'card rules' }
Game >> repeatLastEffectOn: aShip [

	effectManager repeatLastEffectOn: aShip in: self
]

{ #category : 'private' }
Game >> resolveShip: aShipName plays: aCard targeting: aTarget [

	cardManager
		play: aCard
		by: (self shipNamed: aShipName)
		targeting: aTarget
		in: self
]

{ #category : 'battle' }
Game >> rollFor: aShip [

	^ bucketOfDices throw + (cardManager bonusFor: aShip)
]

{ #category : 'effects' }
Game >> sendAllShipsToStart [

	ships do: [ :ship | self sendToStart: ship ]
]

{ #category : 'effects' }
Game >> sendToStart: aShip [

	board moveToStart: aShip
]

{ #category : 'querying' }
Game >> shieldsOf: aShipName [

	^ (self shipNamed: aShipName) shields
]

{ #category : 'cards' }
Game >> ship: aShipName plays: aCard [

	self ship: aShipName plays: aCard targeting: aShipName
]

{ #category : 'cards' }
Game >> ship: aShipName plays: aCard targeting: aTarget [

	status ship: aShipName plays: aCard targeting: aTarget in: self
]

{ #category : 'private' }
Game >> shipNamed: aShipName [

	^ ships
		  detect: [ :ship | ship name = aShipName ]
		  ifNone: [ Error signal: 'There is no ship named ' , aShipName ]
]

{ #category : 'battle' }
Game >> shipsAt: aLocation [

	^ ships select: [ :ship | ship location = aLocation ]
]

{ #category : 'private' }
Game >> shipsSortedByPosition [

	^ ships copy sort: [ :a :b | a isAheadOf: b ]
]

{ #category : 'private' }
Game >> skipNextTurn [

	turnManager nextShip restoreShields
]

{ #category : 'playing' }
Game >> skipTurn [

	status skipTurnOf: self
]

{ #category : 'effects' }
Game >> teleport: aShip to: aCell [

	board teleport: aShip to: aCell
]

{ #category : 'private' }
Game >> topShipNames [

	^ ((self shipsSortedByPosition first: (3 min: ships size)) collect: [
		   :ship | ship name ]) asOrderedCollection
]

{ #category : 'card rules' }
Game >> validateIsAvailableAsMercenary: aShip [

	(cardManager isHired: aShip) ifTrue: [
		^ Error signal: 'You can not use this ship as a mercenary' ]
]

{ #category : 'card rules' }
Game >> validateTurnOf: aShip [

	turnManager shipInTurn == aShip ifFalse: [
		^ Error signal: 'Permanent cards can only be played during your turn' ]
]

{ #category : 'querying' }
Game >> winner [

	^ status winnerOf: self
]
