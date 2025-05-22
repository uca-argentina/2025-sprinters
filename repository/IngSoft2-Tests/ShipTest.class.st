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
	ship1 :=CircularShip create: 'Ship1'.
	aCircularBoard := CircularBoard with: 5.
	aLoadedDice := LoadedDice with: 1.
	ship1 move: 5 in: aCircularBoard.
	ship1 move: aLoadedDice throw in: aCircularBoard .
	self assert: (ship1 showPosition ) equals: 1.
]

{ #category : 'tests' }
ShipTest >> test005WhenShip1Moves12CellsInABoardWith5CellsThenShip1Has2Laps [
	| ship1 aLoadedDice aCircularBoard |
	ship1 :=CircularShip create: 'Ship1'.
	aCircularBoard := CircularBoard with: 5.
	aLoadedDice := LoadedDice with: 12.
	ship1 move: aLoadedDice throw in: aCircularBoard .
	self assert: (ship1 showLaps ) equals: 2.
]
