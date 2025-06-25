Class {
	#name : 'EffectsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectsTest >> test001WhenApplyBlackHoleEffectToShipThenShipMove4Cells [

	| ships dices aDice aDiceBucket aWorm aBoard aGame ship1 distributions amountOfCells effect typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 9.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	amountOfCells := 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	ship1 move: 6 in: aBoard.
	effect := (distributions at: 1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 position equals: 3
]

{ #category : 'tests' }
EffectsTest >> test002WhenApplyBlackHoleEffectToShipWitchISInCell2ThenShipPositionNeverBeNegative [

	| ships dices aDice aDiceBucket aWorm aBoard aGame ship1 effect distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	aBoard := Board
		          with: 10
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	ship1 move: 2 in: aBoard.
	effect := (distributions at: 1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 position equals: 1
]

{ #category : 'tests' }
EffectsTest >> test003WhenApplyHyperSpaceJumpEffectToShipThenShipPositionIs4 [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperSpaceJump with: 1).
	aBoard := Board
		          with: 10
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	effect := (distributions at: 1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 position equals: 5
]

{ #category : 'tests' }
EffectsTest >> test004WhenApplyHyperSpaceJumpEffectToShipThenShipShieldsAre2 [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 distributions typesOfCards |
	effect := HyperSpaceJump new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperSpaceJump with: 1).
	aBoard := Board
		          with: 10
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	effect := (distributions at: 1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 shields equals: 2
]

{ #category : 'tests' }
EffectsTest >> test005WhenApplyMoonWalkEffectToShip1ThenShip2MoveNPositionBackward [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 n ship2 distributions typesOfCards |
	n := 2.
	"effect := MoonWalk move:n."
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: MoonWalk with: 1).
	aBoard := Board
		          with: 10
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 2
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	ship2 := aGame ships at: 2.
	ship2 move: 13 in: aBoard.
	effect := (distributions at: 1) cellClass.

	effect applyTo: ship1 in: aGame.
	self assert: ship2 position equals: 1
]

{ #category : 'tests' }
EffectsTest >> test006WhenApplyMoonWalkEffectToShip1ThenAllShipsToPositionZero [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 ship2 distributions typesOfCards |
	effect := AtomicBomb.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: AtomicBomb with: 1).
	aBoard := Board
		          with: 10
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	ship2 := aGame ships at: 2.
	ship2 move: 23 in: aBoard.
	effect := (distributions at: 1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 position + ship2 position equals: 2
]

{ #category : 'tests' }
EffectsTest >> test007WhenApplyAtomicBombEffectToShipThenAllShipPositionAreZeroButLapsNotChange [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 assertedResult ship2 distributions typesOfCards |
	effect := AtomicBomb.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 0 23 10 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: AtomicBomb with: 1).
	aBoard := Board
		          with: 10
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4
		         having: (FixedCardFactory with: typesOfCards).
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame ships at: 2) laps equals: 2
]

{ #category : 'tests' }
EffectsTest >> test008WhenApplyAtomicBombEffectToShipThenAllShipLoseOneShield [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 distributions typesOfCards |
	effect := AtomicBomb.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 10 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: effect with: 1).

	aBoard := Board
		          with: 10
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	aGame playTurn.
	self assert: ship1 shields equals: 2
]

{ #category : 'tests' }
EffectsTest >> test009WhenCreatHuperJumpEffectToShipThenItMoveaParsec [

	| ships dices aDice aDiceBucket aWorm aBoard aGame ship1 parsecsToMove amountOfCells aX aY distributions typesOfCards |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: (Distance parsecs: 8).
	parsecsToMove add: (Distance parsecs: 6).
	parsecsToMove add: (Distance parsecs: 3).

	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 2 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aX := 2.
	aY := 9.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add:
		(Distribution at: (HyperJump with: parsecsToMove) with: 1).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	aGame playTurn.
	self assert: ship1 position equals: 7
]

{ #category : 'tests' }
EffectsTest >> test010WhenCreatHyperJumpEffectToShip1andShip2ThenShipsPositionAreDifferent [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 parsecsToMove amountOfCells aX aY distributions ship2 typesOfCards |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: (Distance parsecs: 8).
	parsecsToMove add: (Distance parsecs: 6).
	parsecsToMove add: (Distance parsecs: 3).

	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 3 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aX := 1.
	aY := 3.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add:
		(Distribution at: (HyperJump with: parsecsToMove) with: 1).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4
		         having: (FixedCardFactory with: typesOfCards).
	aGame playTurn.
	aGame playTurn.
	self
		assert: (aGame findShipBy: 'ship 1') position
			+ (aGame findShipBy: 'ship 2') position
		equals: 15
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
EffectsTest >> test013WhenHavingMoonwalkEffectThenHasNCells [

	| dices aDice aDiceBucket amountOfCells aWorm ships distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: MoonWalk with: 1).

	self assert: (distributions at: 1) cellClass numberOfCells equals: 10
]

{ #category : 'tests' }
EffectsTest >> test014WhenCreatHyperJumpWithParsecsrEffectToShipThenItMovesParsecs [

	| ships dices aDice aDiceBucket aWorm aBoard aGame ship1 amountOfCells aX aY distributions typesOfCards distanceToMove |
	distanceToMove := OrderedCollection new.
	distanceToMove add: (Distance parsecs: 9).
	distanceToMove add: (Distance parsecs: 6).
	distanceToMove add: (Distance parsecs: 3).

	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 2 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 20.
	aX := 2.
	aY := 9.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add:
		(Distribution at: (HyperJump with: distanceToMove) with: 1).
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 60).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	aGame playTurn.
	self assert: ship1 position equals: 6
]

{ #category : 'tests' }
EffectsTest >> test015WhenCreatHyperJumpLightYearEffectToShipThenItMovesPrrsecs [

	| ships dices aDice aDiceBucket aWorm aBoard aGame ship1 amountOfCells aX aY distributions typesOfCards distanceToMove |
	distanceToMove := OrderedCollection new.
	distanceToMove add: (Distance lightYear: 27).
	distanceToMove add: (Distance lightYear: 18).
	distanceToMove add: (Distance lightYear: 9).

	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 2 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 20.
	aX := 2.
	aY := 9.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add:
		(Distribution at: (HyperJump with: distanceToMove) with: 1).
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance lightYear: 180).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4
		         having: (FixedCardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	aGame playTurn.
	self assert: ship1 position equals: 6
]
