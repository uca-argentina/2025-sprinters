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
Game class >> with: aBoard using: aDiceBucket andShipsNamed: shipsNames [

	| listOfShips |
	shipsNames size = 0 ifTrue: [
		^ Error signal: 'List of ships must not be empty.' ].
	listOfShips := Set new.
	shipsNames do: [ :ship | listOfShips add: ship ].
	listOfShips size = shipsNames size ifFalse: [
		^ Error signal: 'Ship´s name must not be reapeated.' ].
	^ self new
		  initializeWith: aBoard
		  using: aDiceBucket
		  andShipsNamed: shipsNames
]

{ #category : 'as yet unclassified' }
Game class >> with: aCircularBoard using: aLoadedDice andShipsNamed: aCollection until: anInteger [

	^ self new 
		  initializeWith: aCircularBoard
		  using: aLoadedDice
		  andShipsNamed: aCollection
		  until: anInteger
]

{ #category : 'as yet unclassified' }
Game >> applyAtomicEffectOn: aShip [ 
	ships do:[ :ship | ship receiveAtomicBombEffect]
]

{ #category : 'as yet unclassified' }
Game >> applyBlackHoleEffectOn: aShip [

	aShip receiveBlackHoleEffectFrom: self
]

{ #category : 'as yet unclassified' }
Game >> applyHyperJumEffectOn: aShip moving: parsecsToJump [

	aShip receiveHyperJumpIn: board moving: parsecsToJump
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
Game >> initializeWith: aBoard  using: aDiceBucket andShipsNamed: shipsNames [

	board := aBoard.
	ships := shipsNames collect: [ :aName | Ship create: aName with:aDiceBucket].
	status := Started new.
	turnManager:= TurnManager with:ships.
	battleManager :=BattleManager new.
]

{ #category : 'initialization' }
Game >> initializeWith: aCircularBoard using: aDiceBucket andShipsNamed: shipsNames until: numberOfLaps [

	board := aCircularBoard with:numberOfLaps .
	ships := shipsNames collect: [ :aName | Ship create: aName with:aDiceBucket ].
	status := Started new.
	turnManager:= TurnManager with:ships.
	battleManager :=BattleManager .
	
	
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

	| actualShip effect |
	actualShip := turnManager nextShip.
	actualShip moveIn: board.
	effect := board effectOnPosition: actualShip position.
	effect applyTo: actualShip in: self.
	(ships select: [ :ship |
		 ship ~~ actualShip and: [
			 ship position = actualShip position ] ]) do: [ :enemy |
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
Game >> someShipWon [

	| laps |
	laps := board laps.
	winner := ships
		          detect: [ :ship |
			          laps isNil
				          ifTrue: [ ship winAt: board ]
				          ifFalse: [ ship winAt: board until: laps ] ]
		          ifNone: [ nil ].

	winner ifNotNil:[status:=Finished new]
]
