Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> test000WhenCreateShipThenPositionEqualsOne [

	| aShip aLoadedDice |
	aLoadedDice := LoadedDice withSequence: #( 1 ).
	aShip := Ship create: 'ship 1'.

	self assert: aShip position equals: 1
]

{ #category : 'tests' }
ShipTest >> test001WhenShipReceiveANumberThenMovesThatAmount [

	| aLoadedDice ship1 aWorm distributions aBoard |
	aLoadedDice := LoadedDice withSequence: #( 3 ).
	ship1 := Ship create: 'Ship1'.
	aWorm := Worm with: 1 and: 2.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board
		                  with: 5
		                  and: aWorm
		                  has: distributions
		                  andTotalParsec: 20.
	ship1 move: 3 in: aBoard.

	self assert: ship1 position equals: 4.
]

{ #category : 'tests' }
ShipTest >> test002WhenCreateAShipWithNameThenReturnShipsName [

	| aShip shipName |
	shipName := 'Ship 1'.
	aShip := Ship create: shipName.

	self assert: aShip name equals: shipName
]

{ #category : 'tests' }
ShipTest >> test003WhenCreateAShipWithNameThatIsNotAStringThenRaiceError [

	| shipName |
	shipName := 124.
	self
		should: [ Ship create: shipName ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Ship´s name must be a string.' ]
]

{ #category : 'tests' }
ShipTest >> test004WhenShip1PositionIsLastOneAndThrow1ThenShip1StartFromTheBeginning [

	| ship1 aCircularBoard dice amountOfCells aX aY aWorm distributions |
	dice := LoadedDice withSequence: #( 4 1 ).
	ship1 := Ship create: 'Ship1'.
	amountOfCells := 4.
	aX := 1.
	aY := 2.
	aWorm := Worm with: aX and: aY.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aCircularBoard := Board
		                  with: amountOfCells
		                  and: aWorm
		                  has: distributions
		                  andTotalParsec: 20.
	aCircularBoard with: 2.
	ship1 move: (dice throw) in: aCircularBoard.
	self assert: ship1 position equals: 2
]

{ #category : 'tests' }
ShipTest >> test005WhenShip1Moves12CellsInABoardWith5CellsThenShip1Has2Laps [

	| ship1 aCircularBoard dice aWorm distributions |
	dice := LoadedDice withSequence: #( 16 ).
	ship1 := Ship create: 'Ship1'.

	aWorm := Worm with: 1 and: 2.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aCircularBoard := Board
		                  with: 5
		                  and: aWorm
		                  has: distributions
		                  andTotalParsec: 20.
	aCircularBoard with: 3.
	ship1 move: (dice throw) in: aCircularBoard.
	self assert: ship1 laps equals: 3
]

{ #category : 'tests' }
ShipTest >> test006WhenShip1IsInFinalLapThenWinnerIsShip1 [

	| ship1 ships laps aGame aDice dices aDiceBucket amountOfCells aWorm distributions aBoard |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	ship1 := 'Ship1'.
	ships add: ship1.
	aDice := LoadedDice withSequence: #( 11 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 5.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).

	aBoard := aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 3.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.
	aGame play.

	self assert: aGame showWinner name equals: 'Ship1'
]

{ #category : 'tests' }
ShipTest >> test007WhenShipThrow11AndBoardHas5CellsThenShipWinAt2LapsReturnsTrue [

	| ship1 aLoadedDice aCircularBoard ships laps aWorm distributions |
	ships := OrderedCollection new.
	aLoadedDice := LoadedDice withSequence: #( 11 ).
	ship1 := Ship create: 'Ship1'.
	aWorm := Worm with: 1 and: 2.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aCircularBoard := Board
		                  with: 5
		                  and: aWorm
		                  has: distributions
		                  andTotalParsec: 20.
	aCircularBoard with: 2.
	ship1 move: (aLoadedDice throw) in: aCircularBoard.
	laps := 2.

	self assert: (ship1 winAt: aCircularBoard until: laps) equals: true
]

{ #category : 'tests' }
ShipTest >> test008WhenShipIsCreatedThenShipShieldsAre3 [

	| ship1  |
	ship1 := Ship create: 'Ship1'.

	self assert: ship1 shields equals: 3
]

{ #category : 'tests' }
ShipTest >> test009WhenShipIsCreatedAndThenLoseAShieldThenShipShieldsAre2 [

	| ship1  |
	ship1 := Ship create: 'Ship1'.
	ship1 loseShield.
	self assert: ship1 shields equals: 2
]

{ #category : 'tests' }
ShipTest >> test010WhenShipRecoverItsShieldsThenShipShieldsAre3 [

	| ship1  |
	ship1 := Ship create: 'Ship1'.
	ship1 recoverShields.
	self assert: ship1 shields equals: 3
]

{ #category : 'tests' }
ShipTest >> test011WhenShipIsCreatedThenItCanPlay [

	| ship1  |
	ship1 := Ship create: 'Ship1'.
	self assert: ship1 canPlay equals: true
]

{ #category : 'tests' }
ShipTest >> test012WhenShipLoseAllItsShieldsThenItCanNotPlay [

	| ship1  |
	ship1 := Ship create: 'Ship1'.
	ship1 loseShield .
	ship1 loseShield .
	ship1 loseShield .
	self assert: ship1 canPlay equals: false
]

{ #category : 'tests' }
ShipTest >> test013WhenShipRecoverItsShieldsThenItCanPlay [

	| ship1  |
	ship1 := Ship create: 'Ship1'.
	ship1 loseShield .
	ship1 loseShield .
	ship1 loseShield .
	ship1 recoverShields .
	self assert: ship1 canPlay equals: true
]

{ #category : 'tests' }
ShipTest >> test014WhenShipHas2TurnToSkipAndHAsSkipped1TurnThenItHas1TurnToSkip [

	| ship1 ships ship2 ship3 turnManager actualShip |
	ships := OrderedCollection new.
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	ship3 := Ship create: 'ship3'.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	ship1 loseShield.
	ship1 loseShield.
	ship1 loseShield.
	turnManager := TurnManager with: ships.
	actualShip := turnManager nextShip.
	self assert: ship1 turnsThatHasToSkip equals: 1
]

{ #category : 'tests' }
ShipTest >> test015WhenShipIsInPosition5AndReceiveBlackHoleEffectThenPositionIs1 [

	| ships dices aDice aDiceBucket amountOfCells aWorm distributions aBoard laps aGame |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #(6).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	aBoard := aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 3.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.

	aGame playTurn.
	self assert: (aGame ships at:1) position equals: 3
]

{ #category : 'tests' }
ShipTest >> test016WhenShipChoiceToNotPlayThenShipRecoverShield [

	| ships dices aDice aDiceBucket amountOfCells aWorm distributions aBoard laps aGame |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 5 3 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperSpaceJump with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame skipTurnForShipNamed: 'ship 1'.
	aGame playTurn.
	self assert: (aGame ships at: 1) shields equals: 2
]
