Class {
	#name : 'EffectsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectsTest >> test001WhenApplyBlackHoleEffectToShipThenShipMove4Cells [

	| ships dices aDice aDiceBucket aWorm aBoard aGame ship1 distributions amountOfCells effect |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 9.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	amountOfCells := 10.
	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	ship1 move: 6.
	effect := (distributions at: 1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 showPosition equals: 3
]

{ #category : 'tests' }
EffectsTest >> test002WhenApplyBlackHoleEffectToShipWitchISInCell2ThenShipPositionNeverBeNegative [

	| ships dices aDice aDiceBucket aWorm aBoard aGame ship1 effect distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	ship1 move: 2.
	effect := (distributions at:1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 showPosition equals: 1
]

{ #category : 'tests' }
EffectsTest >> test003WhenApplyHyperSpaceJumpEffectToShipThenShipPositionIs4 [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperSpaceJump with: 1).
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	effect := (distributions at:1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 showPosition equals: 5
]

{ #category : 'tests' }
EffectsTest >> test004WhenApplyHyperSpaceJumpEffectToShipThenShipShieldsAre2 [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 distributions |
	effect := HyperSpaceJump new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperSpaceJump with: 1).
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	effect := (distributions at:1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 showShields equals: 2
]

{ #category : 'tests' }
EffectsTest >> test005WhenApplyMoonWalkEffectToShip1ThenShip2MoveNPositionBackward [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 n ship2 distributions |
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
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 2.
	ship1 := aGame ships at: 1.
	ship2 := aGame ships at: 2.
	ship2 move: 13 in: aBoard .
	effect := (distributions at: 1) cellClass.

	effect applyTo: ship1 in: aGame.
	self assert: ship2 showPosition equals: 1
]

{ #category : 'tests' }
EffectsTest >> test006WhenApplyMoonWalkEffectToShip1ThenAllShipsToPositionZero [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 ship2 distributions |
	effect := AtomicBomb.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: AtomicBomb with: 1).
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4.
	ship1 := aGame ships at: 1.
	ship2 := aGame ships at: 2.
	ship2 move: 23 in:aBoard.
	effect := (distributions at:1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: (ship1 showPosition + ship2 showPosition) equals: 2
]

{ #category : 'tests' }
EffectsTest >> test007WhenApplyAtomicBombEffectToShipThenAllShipPositionAreZeroButLapsNotChange [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 assertedResult ship2 distributions |
	effect := AtomicBomb.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: AtomicBomb with: 1).
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4.
	ship1 := aGame ships at: 1.
	ship2 := aGame ships at: 2.
	ship2 move: 23 in:aBoard.
	effect := (distributions at:1) cellClass.
	effect applyTo: ship1 in: aGame.
	self assert: ship2 showLaps equals: 2
]

{ #category : 'tests' }
EffectsTest >> test008WhenApplyAtomicBombEffectToShipThenAllShipLoseOneShield [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 assertedResult ship2 distributions |
	effect := AtomicBomb.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: effect with: 1).

	aBoard := Board with: 10 and: aWorm has: distributions.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4.
	ship1 := aGame ships at: 1.
	aGame playTurn.
	self assert: ship1 showShields equals: 2
]

{ #category : 'tests' }
EffectsTest >> test009WhenCreatHuperJumpEffectToShipThenItMoveaParsec [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 parsecsToMove amountOfCells aX aY distributions |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: 8.
	parsecsToMove add: 6.
	parsecsToMove add: 3.

	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aX := 1.
	aY := 3.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperJump with: 1).
	
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4.
	ship1 := aGame ships at: 1.
	effect := (distributions at:1) cellClass.
	ship1 move: 4 in: aBoard.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 showPosition equals: 10.
]

{ #category : 'tests' }
EffectsTest >> test010WhenCreatHuperJumpEffectToShip1andShip2ThenShipsPositionAreDifferent [

		| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 parsecsToMove amountOfCells aX aY distributions ship2 |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: 8.
	parsecsToMove add: 6.
	parsecsToMove add: 3.

	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aX := 1.
	aY := 3.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperJump with: 1).
	
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 4.
	ship1 := aGame ships at: 1.
	ship2 := aGame ships at: 2.
	effect := (distributions at:1) cellClass.
	effect applyTo: ship1 in: aGame.
	effect applyTo: ship2 in: aGame.
	self assert: (ship1 showPosition + ship2 showPosition) equals: 11.
]

{ #category : 'tests' }
EffectsTest >> test011WhenCreatHuperJumpEffectWithCellsLessThanZeroThenRaiseError [

	| parsecsToMove |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: 8.
	parsecsToMove add: -6.
	parsecsToMove add: 3.

	self
		should: [ HyperJump with: parsecsToMove ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Parsecs to move must to be positive' ]
]

{ #category : 'tests' }
EffectsTest >> test012WhenCreatHuperJumpEffectWithCellsHaveToBeLessThanThePreviusThenRaiseError [

	| parsecsToMove |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: 8.
	parsecsToMove add: 10.
	parsecsToMove add: 3.

	self
		should: [ HyperJump with: parsecsToMove ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Parsecs have to be less than the earlier one' ]
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
