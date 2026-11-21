Class {
	#name : 'EffectsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectsTest >> test001WhenApplyBlackHoleEffectToShipThenShipMove4Cells [

	| effects aGame |
	effects := (1 to: 10) collect: [ :cell | NoEffect new ].
	effects at: 7 put: BlackHole new.
	aGame := GameBuilder new
		         diceSequence: #( 6 );
		         effects: effects;
		         wormHoleBetween: 9 and: 10;
		         build.
	aGame playTurn. "cae en 7 (BlackHole) y retrocede 4"
	self assert: (aGame positionOf: 'ship 1') equals: 3
]

{ #category : 'tests' }
EffectsTest >> test002WhenApplyBlackHoleEffectNearTheStartThenShipPositionIsNeverLessThanOne [

	| effects aGame |
	effects := (1 to: 10) collect: [ :cell | NoEffect new ].
	effects at: 3 put: BlackHole new.
	aGame := GameBuilder new
		         diceSequence: #( 2 );
		         effects: effects;
		         wormHoleBetween: 9 and: 10;
		         build.
	aGame playTurn. "cae en 3 (BlackHole): 3 - 4 seria -1, queda en 1"
	self assert: (aGame positionOf: 'ship 1') equals: 1
]

{ #category : 'tests' }
EffectsTest >> test003WhenShipLandsOnAHyperSpaceJumpThenItMoves4CellsAndLosesAShield [

	| effects aGame |
	effects := (1 to: 10) collect: [ :cell | NoEffect new ].
	effects at: 3 put: HyperSpaceJump new.
	aGame := GameBuilder new
		         diceSequence: #( 2 );
		         effects: effects;
		         wormHoleBetween: 9 and: 10;
		         build.
	aGame playTurn. "cae en 3 (HyperSpaceJump) -> 7"
	self assert: (aGame positionOf: 'ship 1') equals: 7.
	self assert: (aGame shieldsOf: 'ship 1') equals: 2
]

{ #category : 'tests' }
EffectsTest >> test005WhenApplyMoonWalkEffectToShip1ThenShip2MoveNPositionBackward [

	| effects aGame |
	effects := (1 to: 10) collect: [ :cell | NoEffect new ].
	effects at: 6 put: (MoonWalk move: 10).
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 1 13 4 );
		         effects: effects;
		         wormHoleBetween: 9 and: 10;
		         laps: 2;
		         build.
	aGame playTurn. "ship 1 cae en 2"
	aGame playTurn. "ship 2: 1 + 13 = celda 4 de la vuelta 2"
	aGame playTurn. "ship 1 cae en 6 (MoonWalk): ship 2 retrocede 10"
	self assert: (aGame positionOf: 'ship 2') equals: 4.
	self assert: (aGame lapOf: 'ship 2') equals: 1.
	self assert: (aGame positionOf: 'ship 1') equals: 6
]

{ #category : 'tests' }
EffectsTest >> test007WhenApplyAtomicBombEffectToShipThenAllShipPositionAreOneButLapsNotChange [

	| aGame |
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 12 );
		         allCellsWith: AtomicBomb new;
		         wormHoleBetween: 9 and: 10;
		         laps: 3;
		         build.
	aGame playTurn. "ship 1: 1 + 12 = 13 -> celda 3 de la vuelta 2 -> AtomicBomb"
	self assert: (aGame positionOf: 'ship 1') equals: 1.
	self assert: (aGame lapOf: 'ship 1') equals: 2.
	self assert: (aGame positionOf: 'ship 2') equals: 1.
	self assert: (aGame lapOf: 'ship 2') equals: 1
]

{ #category : 'tests' }
EffectsTest >> test008WhenApplyAtomicBombEffectToShipThenAllShipLoseOneShield [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 10 );
		         allCellsWith: AtomicBomb new;
		         laps: 4;
		         build.
	aGame playTurn.
	self assert: (aGame shieldsOf: 'ship 1') equals: 2
]

{ #category : 'tests' }
EffectsTest >> test009WhenCreatHuperJumpEffectToShipThenItMoveaParsec [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 2 );
		         allCellsWith: (HyperJump with: {
						          (Distance parsecs: 8).
						          (Distance parsecs: 6).
						          (Distance parsecs: 3) });
		         build.
	aGame playTurn. "cae en 3, salta 8 parsecs = 4 celdas"
	self assert: (aGame positionOf: 'ship 1') equals: 7
]

{ #category : 'tests' }
EffectsTest >> test010WhenTwoShipsFallOnTheSameHyperJumpThenEachOneJumpsTheNextDistance [

	| aGame |
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 3 );
		         allCellsWith: (HyperJump with: {
						          (Distance parsecs: 8).
						          (Distance parsecs: 6).
						          (Distance parsecs: 3) });
		         wormHoleBetween: 9 and: 10;
		         build.
	aGame playTurn. "ship 1: cae en 4, salta 8 parsecs = 4 celdas"
	aGame playTurn. "ship 2: cae en 4, salta 6 parsecs = 3 celdas"
	self assert: (aGame positionOf: 'ship 1') equals: 8.
	self assert: (aGame positionOf: 'ship 2') equals: 7
]

{ #category : 'tests' }
EffectsTest >> test011WhenCreatHuperJumpEffectWithCellsLessThanZeroThenRaiseError [

	| parsecsToMove |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: (Distance parsecs: 8).
	parsecsToMove add: (Distance parsecs: -6).
	parsecsToMove add: (Distance parsecs: 3).

	self
		should: [ HyperJump with: parsecsToMove ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Parsecs and lightYears to move must to be positive' ]
]

{ #category : 'tests' }
EffectsTest >> test012WhenCreatHuperJumpEffectWithCellsHaveToBeLessThanThePreviusThenRaiseError [

	| lightYearToMove |
	lightYearToMove := OrderedCollection new.
	lightYearToMove add: (Distance lightYear: 8).
	lightYearToMove add: (Distance lightYear: 10).
	lightYearToMove add: (Distance lightYear: 3).

	self
		should: [ HyperJump with: lightYearToMove ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Parsecs and lightYears have to be less than the earlier one' ]
]

{ #category : 'tests' }
EffectsTest >> test014WhenCreatHyperJumpWithParsecsrEffectToShipThenItMovesParsecs [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 2 );
		         cells: 20;
		         length: (Distance parsecs: 60);
		         allCellsWith: (HyperJump with: {
						          (Distance parsecs: 9).
						          (Distance parsecs: 6).
						          (Distance parsecs: 3) });
		         build.
	aGame playTurn. "cae en 3, salta 9 parsecs = 3 celdas"
	self assert: (aGame positionOf: 'ship 1') equals: 6
]

{ #category : 'tests' }
EffectsTest >> test015WhenCreatHyperJumpLightYearEffectToShipThenItMovesPrrsecs [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 2 );
		         cells: 20;
		         length: (Distance lightYear: 180);
		         allCellsWith: (HyperJump with: {
						          (Distance lightYear: 27).
						          (Distance lightYear: 18).
						          (Distance lightYear: 9) });
		         build.
	aGame playTurn. "cae en 3, salta 27 años luz = 9 parsecs = 3 celdas"
	self assert: (aGame positionOf: 'ship 1') equals: 6
]
