Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'winner',
		'board',
		'bucketOfDices',
		'ships',
		'status',
		'turnManager',
		'battleManager',
		'cards',
		'activeCards',
		'historicalCards',
		'historicalEffects'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> validateUniqueNames: ships [

	| uniqueNames duplicatedNames |
	uniqueNames := Set new.
	duplicatedNames := OrderedCollection new.

	ships do: [ :shipName |
		(uniqueNames includes: shipName)
			ifTrue: [ duplicatedNames add: shipName ]
			ifFalse: [ uniqueNames add: shipName ] ].

	duplicatedNames isEmpty ifFalse: [
		^ Error signal: 'Ship´s name must not be reapeated.' ].

	^ ships
]

{ #category : 'as yet unclassified' }
Game class >> with: aBoard using: aLoadedDice andShipsNamed: shipsName until: laps having: aCardDeck [ 
	shipsName ifEmpty: [
		^ Error signal: 'List of ships must not be empty.' ].
	self validateUniqueNames: shipsName.

	^ self new
		  initializeWith: aBoard
		  using: aLoadedDice
		  andShipsNamed: shipsName
		  until: laps
		  having: aCardDeck.
]

{ #category : 'adding' }
Game >> addToActiveCardsThisCard: aCard [ 
	activeCards add: aCard .
]

{ #category : 'playing' }
Game >> applyAccelerationCardEffect [
	ships do: [:ship | ship increaseBonusThrow  ].
]

{ #category : 'playing' }
Game >> applyAtomicEffectOn: aShip [ 
	ships do:[ :ship | ship receiveAtomicBombEffect]
]

{ #category : 'playing' }
Game >> applyBlackHoleEffectOn: aShip [

	aShip receiveBlackHoleEffectFrom: board 
]

{ #category : 'playing' }
Game >> applyCancellationCardEffect [
	self shouldBeImplemented.
]

{ #category : 'as yet unclassified' }
Game >> applyCancellationCardEffectOn: aPermanentCard [ 
	| aCard chosenCard|
	aCard :=activeCards detect: [:card | card = aPermanentCard ] .
	aCard ifNil: [ Error signal: 'active cards does not have that Permanent Card' ].
	aCard removePermanentEffect.
	activeCards remove: aCard .
]

{ #category : 'playing' }
Game >> applyHyperJumEffectOn: aShip moving: cellsToJump [

	aShip receiveHyperJumpIn: board moving: cellsToJump
]

{ #category : 'playing' }
Game >> applyHyperSpaceJumpEffectOn: aShip [

	aShip recieveHyperSpaceJumpIn: board
]

{ #category : 'playing' }
Game >> applyMoonWalkEffectOn: aShip moving: numberOfCells [
	 ships do: [ :otherShip |
		otherShip ~~ aShip ifTrue: [
			otherShip move: numberOfCells * -1 in: board ] ].
]

{ #category : 'playing' }
Game >> applyRedoCardEffectOn: aShip [

	| realCard  |
	historicalCards isEmpty ifTrue: [
		^ Error signal: 'There are no cards played before.' ].

	realCard := historicalCards reversed
		            detect: [ :each | each isRedo not ]
		            ifNone: [ ^ Error signal: 'No real card to redo.' ].

	realCard applyTo: aShip using:aShip in: self
]

{ #category : 'playing' }
Game >> applyRepeatCardEffectOn: aShip [

	| effect |
	effect := historicalEffects.
	effect applyTo: aShip in: self
]

{ #category : 'accessing' }
Game >> board [

	^ board
]

{ #category : 'accessing' }
Game >> currentStatus [

	^ status
]

{ #category : 'accessing' }
Game >> currentTopPlayer [

	^ self shipsSortedByPosition at: 1.
]

{ #category : 'accessing' }
Game >> findShipBy: aName [

	^ ships detect: [ :ship | ship name = aName ]
]

{ #category : 'initialization' }
Game >> initializeWith: aCircularBoard using: aDiceBucket andShipsNamed: shipsNames until: numberOfLaps having: cardTypes [

	| cardFactory |
	board := aCircularBoard with: numberOfLaps.
	ships := shipsNames collect: [ :aName | Ship create: aName ].
	ships do: [ :ship | ship recieveCardsFrom: cardTypes ].
	bucketOfDices := aDiceBucket.
	status := Started creation.
	turnManager := TurnManager with: ships.
	battleManager := BattleManager with: aDiceBucket.
	activeCards := OrderedCollection new.
	historicalCards := OrderedCollection new.
	historicalEffects := NoEffect new.
]

{ #category : 'testing' }
Game >> isBefore: shipA than: shipB [

	^ (ships indexOf: shipA) < (ships indexOf: shipB)
]

{ #category : 'accessing' }
Game >> permanentCardsPlayed [
	^ activeCards .
]

{ #category : 'playing' }
Game >> play [

	status play:self.

	^ 'Game over'
]

{ #category : 'playing' }
Game >> playTurn [

	| actualShip effect positionToMove shipsInSamePosition name |
	status markAsPlaying.
	actualShip := turnManager nextShip.
	positionToMove := bucketOfDices throw + actualShip giveBonusThrow.
	actualShip move: positionToMove in: board.
	effect := board effectOnPosition: actualShip position.
	name := effect className.
	name = 'CardGiver' ifFalse: [ historicalEffects := effect ].
	effect applyTo: actualShip in: self.
	shipsInSamePosition := ships select: [ :ship |
		                       ship ~~ actualShip and: [
			                       ship position = actualShip position and:
				                       ship laps = actualShip laps ] ].
	shipsInSamePosition do: [ :enemy |
		((actualShip hasAsMercery: enemy name) or: [
			 enemy hasAsMercery: actualShip name ]) ifFalse: [
			battleManager fightBetween: actualShip and: enemy ] ].
	self someShipWon
]

{ #category : 'playing' }
Game >> shipNamed: aShip1 useCard: aCard with: aShip2 [

	| ship1 ship2 |
	ship1 := self findShipBy: aShip1.
	ship2 := self findShipBy: aShip2.
	ship1 use: aCard with: ship2 in: self.
	historicalCards add: aCard
]

{ #category : 'accessing' }
Game >> ships [
	^ ships
]

{ #category : 'accessing' }
Game >> shipsSortedByPosition [

	^ ships copy sort: [ :a :b | a isAheadOf: b ]
]

{ #category : 'accessing' }
Game >> showRanking [

	| top ranking sorted |
	status isFinished
		ifTrue: [
			top := 1.
			ranking := OrderedCollection new.
			sorted := self shipsSortedByPosition.

			[ top <= 3 and: [ top <= sorted size ] ] whileTrue: [
				ranking add: (sorted at: top) name.
				top := top + 1 ].
			^ ranking ]
		ifFalse: [
			Error signal:
				'The Game has not been played yet so it doesn`t have a ranking' ]
]

{ #category : 'playing' }
Game >> showShipsPositions [

	| result |
	result := Dictionary new.
	ships do: [ :ship | result at: ship name put: ship position ].
	^ result
]

{ #category : 'accessing' }
Game >> showWinner [

	^ status showWinner: self
]

{ #category : 'playing' }
Game >> skipTurnForShipNamed: shipName [ 
	turnManager skipTurnForShipNamed: shipName.
]

{ #category : 'as yet unclassified' }
Game >> someShipWon [

	| laps |
	laps := board laps.
	winner := ships detect: [ :ship | ship winAt: board ] ifNone: [ nil ].
	winner ifNotNil: [ status := Finished new ]
]
