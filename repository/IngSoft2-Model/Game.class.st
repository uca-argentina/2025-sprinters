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
		'battleManager'
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
Game class >> with: aCircularBoard using: aLoadedDice andShipsNamed: shipsName until: anInteger [

	shipsName ifEmpty: [
		^ Error signal: 'List of ships must not be empty.' ].
	self validateUniqueNames: shipsName.

	^ self new
		  initializeWith: aCircularBoard
		  using: aLoadedDice
		  andShipsNamed: shipsName
		  until: anInteger
]

{ #category : 'as yet unclassified' }
Game >> applyAtomicEffectOn: aShip [ 
	ships do:[ :ship | ship receiveAtomicBombEffect]
]

{ #category : 'as yet unclassified' }
Game >> applyBlackHoleEffectOn: aShip [

	aShip receiveBlackHoleEffectFrom: board 
]

{ #category : 'as yet unclassified' }
Game >> applyHyperJumEffectOn: aShip moving: cellsToJump [

	aShip receiveHyperJumpIn: board moving: cellsToJump
]

{ #category : 'as yet unclassified' }
Game >> applyHyperSpaceJumpEffectOn: aShip [

	aShip recieveHyperSpaceJumpIn: board
]

{ #category : 'as yet unclassified' }
Game >> applyMoonWalkEffectOn: aShip moving: numberOfCells [
	 ships do: [ :otherShip |
		otherShip ~~ aShip ifTrue: [
			otherShip move: numberOfCells * -1 in: board ] ]
]

{ #category : 'accessing' }
Game >> board [

	^ board
]

{ #category : 'as yet unclassified' }
Game >> currentStatus [

	^ status
]

{ #category : 'as yet unclassified' }
Game >> currentTopPlayer [

	^ self shipsSortedByPosition at: 1.
]

{ #category : 'initialization' }
Game >> initializeWith: aCircularBoard using: aDiceBucket andShipsNamed: shipsNames until: numberOfLaps [

	| cardFactory |
	board := aCircularBoard with: numberOfLaps.
	ships := shipsNames collect: [ :aName | Ship create: aName ].
	bucketOfDices := aDiceBucket.
	status := Started new.
	turnManager := TurnManager with: ships.
	battleManager := BattleManager with: aDiceBucket
]

{ #category : 'testing' }
Game >> isBefore: shipA than: shipB [

	^ (ships indexOf: shipA) < (ships indexOf: shipB)
]

{ #category : 'as yet unclassified' }
Game >> play [

	status play:self.

	^ 'Game over'
]

{ #category : 'as yet unclassified' }
Game >> playTurn [

	| actualShip effect positionToMove shipsInSamePosition |
	actualShip := turnManager nextShip.
	positionToMove := bucketOfDices throw.
	actualShip move: positionToMove in: board.
	effect := board effectOnPosition: actualShip position.
	effect applyTo: actualShip in: self.
	shipsInSamePosition := ships select: [ :ship |
		                       ship ~~ actualShip and: [
			                       ship position = actualShip position and:
				                       ship laps = actualShip laps ] ].
	shipsInSamePosition do: [ :enemy |
		battleManager fightBetween: actualShip and: enemy ].
	self someShipWon
]

{ #category : 'accessing' }
Game >> ships [
	^ ships
]

{ #category : 'as yet unclassified' }
Game >> shipsSortedByPosition [

	^ ships copy sort: [ :a :b | a isAheadOf: b ]
]

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
Game >> showShipsPositions [

	| result |
	result := Dictionary new.
	ships do: [ :ship | result at: ship name put: ship position ].
	^ result
]

{ #category : 'as yet unclassified' }
Game >> showWinner [

	^ status showWinner: self
]

{ #category : 'as yet unclassified' }
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
