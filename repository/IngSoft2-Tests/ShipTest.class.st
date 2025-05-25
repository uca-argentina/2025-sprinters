Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> test000WhenCreateShipThenPositionEqualsZero [

| aShip |

aShip := Ship newShip.

self assert: aShip showPosition equals: 0.
]

{ #category : 'tests' }
ShipTest >> test001WhenShipReceiveANumberThenMovesThatAmount [

	| aShip diceGame |
	aShip := Ship newShip.
	diceGame := 2.
	aShip move: diceGame.

	self assert: aShip showPosition equals: diceGame
]

{ #category : 'tests' }
ShipTest >> test002WhenCreateAShipWithNameThenReturnShipsName [

	| aShip shipName |
	shipName := 'Ship 1'.
	aShip := Ship create: shipName.

	self assert: aShip showName equals: shipName
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
	| ship1 aLoadedDice aCircularBoard |
	ship1 :=Ship create: 'Ship1'.
	aCircularBoard := Board with: 5.
	aCircularBoard with: 2.
	aLoadedDice := LoadedDice with: 1.
	ship1 move: 5 in: aCircularBoard.
	ship1 move: aLoadedDice throw in: aCircularBoard .
	self assert: (ship1 showPosition ) equals: 1.
]

{ #category : 'tests' }
ShipTest >> test005WhenShip1Moves12CellsInABoardWith5CellsThenShip1Has2Laps [

	| ship1 aLoadedDice aCircularBoard |
	ship1 := Ship create: 'Ship1'.
	aCircularBoard := Board with: 5.
	aCircularBoard with: 3.
	aLoadedDice := LoadedDice with: 12.
	ship1 move: aLoadedDice throw in: aCircularBoard.
	self assert: ship1 showLaps equals: 3
]

{ #category : 'tests' }
ShipTest >> test006WhenShip1IsInFinalLapThenWinnerIsShip1 [

	| ship1 aLoadedDice aCircularBoard ships laps aGame |
	ships := OrderedCollection new.
	ship1 := 'Ship1'.
	ships add: ship1.
	aCircularBoard := Board with: 5.
	aLoadedDice := LoadedDice with: 11.
	laps:=3.
	aGame := Game
		         with: aCircularBoard
		         using: aLoadedDice
		         andShipsNamed: ships
		         until: laps.
	aGame play.

	self assert: (aGame currentStatus showWinner:aGame )showName equals: 'Ship1'
	



]

{ #category : 'tests' }
ShipTest >> test007WhenShipThrow11AndBoardHas5CellsThenShipWinAt2LapsReturnsTrue [

	| ship1 aLoadedDice aCircularBoard ships laps aGame cells |
	ships := OrderedCollection new.
	ship1 := Ship create: 'Ship1'.
	aCircularBoard := Board with: 5.
	aCircularBoard with: 3.
	aLoadedDice := LoadedDice with: 11.
	ship1 move: aLoadedDice throw in: aCircularBoard.
	laps := 2.

	self assert: (ship1 winAt: cells until: laps) equals: true
]

{ #category : 'tests' }
ShipTest >> test008WhenShipIsCreatedThenShipShieldsAre3 [

	| ship1  |
	ship1 := Ship create: 'Ship1'.

	self assert: ship1 showShields equals: 3
]

{ #category : 'tests' }
ShipTest >> test009WhenShipIsCreatedAndThenLoseAShieldThenShipShieldsAre2 [

	| ship1  |
	ship1 := Ship create: 'Ship1'.
	ship1 loseShield.
	self assert: ship1 showShields equals: 2
]

{ #category : 'tests' }
ShipTest >> test010WhenShipRecoverItsShieldsThenShipShieldsAre3 [

	| ship1  |
	ship1 := Ship create: 'Ship1'.
	ship1 recoverShields.
	self assert: ship1 showShields equals: 3
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
