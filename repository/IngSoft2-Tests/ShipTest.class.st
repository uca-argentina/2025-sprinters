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

	| aBoard ship1 |
	aBoard := Board
		          withEffects: (Array new: 5 withAll: NoEffect new)
		          wormHole: (Worm with: 1 and: 2)
		          laps: 1
		          length: (Distance parsecs: 20).
	ship1 := Ship create: 'Ship1'.
	aBoard move: ship1 by: 3.
	self assert: ship1 position equals: 4
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

	| aCircularBoard ship1 |
	aCircularBoard := Board
		                  withEffects: (Array new: 4 withAll: NoEffect new)
		                  wormHole: (Worm with: 2 and: 3)
		                  laps: 2
		                  length: (Distance parsecs: 20).
	ship1 := Ship create: 'Ship1'.
	aCircularBoard move: ship1 by: 4. "1 + 4 = 5: da la vuelta y queda en 1"
	self assert: ship1 position equals: 1
]

{ #category : 'tests' }
ShipTest >> test005WhenShip1Moves16CellsInABoardWith5CellsThenItIsOnLap4 [

	| aCircularBoard ship1 |
	aCircularBoard := Board
		                  withEffects: (Array new: 5 withAll: NoEffect new)
		                  wormHole: (Worm with: 1 and: 2)
		                  laps: 5
		                  length: (Distance parsecs: 20).
	ship1 := Ship create: 'Ship1'.
	aCircularBoard move: ship1 by: 16. "casilla 17 = celda 2 de la vuelta 4"
	self assert: ship1 laps equals: 4.
	self assert: ship1 position equals: 2
]

{ #category : 'tests' }
ShipTest >> test006WhenShip1IsInFinalLapThenWinnerIsShip1 [

	| aGame |
	aGame := GameBuilder new
		         shipsNamed: #( 'Ship1' );
		         diceSequence: #( 11 );
		         cells: 5;
		         allCellsWith: BlackHole new;
		         laps: 3;
		         build.
	aGame play.
	self assert: aGame winner equals: 'Ship1'
]

{ #category : 'tests' }
ShipTest >> test007WhenShipThrow11AndBoardHas5CellsThenShipWinAt2LapsReturnsTrue [

	| aCircularBoard ship1 |
	aCircularBoard := Board
		                  withEffects: (Array new: 5 withAll: NoEffect new)
		                  wormHole: (Worm with: 1 and: 2)
		                  laps: 2
		                  length: (Distance parsecs: 20).
	ship1 := Ship create: 'Ship1'.
	aCircularBoard move: ship1 by: 11. "1+11 -- 12, 12 % 5 = 2"
	self assert: (ship1 winAt: aCircularBoard)
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

	| ship1 |
	ship1 := Ship create: 'Ship1'.
	ship1 loseShield.
	ship1 restoreShields.
	self assert: ship1 shields equals: 3
]

{ #category : 'tests' }
ShipTest >> test016WhenShipInTurnSkipsItsTurnThenItRecoversItsShieldsAndDoesNotMove [

	| aGame  |
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 5 2 );
		         allCellsWith: HyperSpaceJump new;
		         wormHoleBetween: 9 and: 10;
		         laps: 3;
		         build.

	aGame playTurn. "ship 1: cae en 6 (HyperSpaceJump) -> 10, le quedan 2 escudos"
	aGame playTurn. "ship 2: cae en 3 (HyperSpaceJump) -> 7, le quedan 2 escudos"
	aGame skipTurn. "le toca a ship 1: no tira y recupera sus escudos"
	aGame playTurn. "le toca a ship 2: 7 + 5 = celda 2 de la vuelta 2 (HyperSpaceJump) -> 6"
	self assert: (aGame shieldsOf: 'ship 1') equals: 3.
	self assert: (aGame positionOf: 'ship 1') equals: 10.
	self assert: (aGame positionOf: 'ship 2') equals: 6.
	self assert: (aGame lapOf: 'ship 2') equals: 2
]

{ #category : 'tests' }
ShipTest >> test017WhenShipMovesMoreCellsThanCellsInBoardThenItActualPositionIs1 [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 10 );
		         laps: 3;
		         build.
	aGame playTurn. "1 + 10 = 11: da la vuelta y queda en 1"
	self assert: (aGame positionOf: 'ship 1') equals: 1
]

{ #category : 'tests' }
ShipTest >> test018WhenShipMovesToLastCellInLapThanCellsInBoardThenItIsInLastCell [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 9 );
		         laps: 3;
		         build.
	aGame playTurn.
	self assert: (aGame positionOf: 'ship 1') equals: 10
]

{ #category : 'tests' }
ShipTest >> test019WhenShipMovesByEffectAndItIsInEarlyCellsThenLapsStayZeroAndNoNegative [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 1 );
		         allCellsWith: BlackHole new;
		         wormHoleBetween: 4 and: 5;
		         laps: 3;
		         build.
	aGame playTurn. "cae en 2, el BlackHole lo lleva a 1 sin perder la vuelta"
	self assert: (aGame lapOf: 'ship 1') equals: 1
]
