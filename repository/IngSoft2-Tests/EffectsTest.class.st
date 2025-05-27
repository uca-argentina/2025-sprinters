Class {
	#name : 'EffectsTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectsTest >> test001WhenApplyBlackHoleEffectToShipThenShipMove4Cells [

	| blackhole ships dices aDice aDiceBucket aWorm aBoard aGame ship1 |
	blackhole := BlackHole new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	ship1 move:5.
	blackhole applyTo: ship1 in: aGame.
	self assert: ship1 showPosition equals: 1
]

{ #category : 'tests' }
EffectsTest >> test002WhenApplyBlackHoleEffectToShipWitchISInCell2ThenShipPositionNeverBeNegative [

	| blackhole ships dices aDice aDiceBucket aWorm aBoard aGame ship1 |
	blackhole := BlackHole new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	ship1 move: 2.
	blackhole applyTo: ship1 in: aGame.
	self assert: ship1 showPosition equals: 0
]

{ #category : 'tests' }
EffectsTest >> test003WhenApplyHyperSpaceJumpEffectToShipThenShipPositionIs4 [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 |
	effect := HyperSpaceJump new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 showPosition equals: 4
]

{ #category : 'tests' }
EffectsTest >> test004WhenApplyHyperSpaceJumpEffectToShipThenShipShieldsAre2 [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 |
	effect := HyperSpaceJump new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	effect applyTo: ship1 in: aGame.
	self assert: ship1 showShields equals: 2
]

{ #category : 'tests' }
EffectsTest >> test005WhenApplyMoonWalkEffectToShip1ThenShip2MoveNPositionBackward [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 n ship2 |
	n:=2.
	effect := MoonWalk move:n.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
	aBoard := Board with: 10.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	ship1 := aGame ships at: 1.
	ship2 := aGame ships at: 2.
	ship2 move:3.
	effect applyTo: ship1 in: aGame.
	self assert: ship2 showPosition equals: 1
]

{ #category : 'tests' }
EffectsTest >> test006WhenCreateMoonWalkEffectWithLessOrEqualZeroCellsThenRaiseError [

	self
		should: [ MoonWalk move: -3 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Amount of cells must be greater than zero' ]
]

{ #category : 'tests' }
EffectsTest >> test007WhenApplyAtomicBombEffectToShipThenAllShipPositionAreZeroButLapsNotChange [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 assertedResult ship2 |
	effect := AtomicBomb new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
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
	effect applyTo: ship1 in: aGame.
	self assert: ship2 showLaps equals: 2
]

{ #category : 'tests' }
EffectsTest >> test008WhenApplyAtomicBombEffectToShipThenAllShipLoseOneShield [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 assertedResult ship2 |
	effect := AtomicBomb new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	aWorm := Worm with: 2 and: 8.
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
	aGame playTurn.
	effect applyTo: ship1 in: aGame.
	self assert: ship2 showShields equals: 2
]

{ #category : 'tests' }
EffectsTest >> test009WhenCreatHuperJumpEffectToShipThenItMoveaParsec [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 parsecsToMove amountOfCells aX aY distributions |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: 8.
	parsecsToMove add: 6.
	parsecsToMove add: 3.
	effect := HyperJump with: parsecsToMove.

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
	distributions add: (Distribution at: NoEffect with: 0.4).
	distributions add: (Distribution at: BlackHole with: 0.6).

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
	effect applyTo: ship1 in: aGame.
	self assert: ship1 showPosition equals: 4
]

{ #category : 'tests' }
EffectsTest >> test010WhenCreatHuperJumpEffectToShip1andShip2ThenShipsPositionAreDifferent [

	| effect ships dices aDice aDiceBucket aWorm aBoard aGame ship1 assertedResult ship2 parsecsToMove amountOfCells aX aY distributions |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: 8.
	parsecsToMove add: 6.
	parsecsToMove add: 3.
	effect := HyperJump with: parsecsToMove.

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
	distributions add: (Distribution at: NoEffect with: 0.4).
	distributions add: (Distribution at: BlackHole with: 0.6).

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
	effect applyTo: ship1 in: aGame.
	effect applyTo: ship2 in: aGame.
	self assert: ship2 showPosition equals: 3
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
EffectsTest >> test013WhenCreatHuperJumpThenReturnName [

	| parsecsToMove effect |
	parsecsToMove := OrderedCollection new.
	parsecsToMove add: 8.
	parsecsToMove add: 6.
	parsecsToMove add: 3.

	effect := HyperJump with: parsecsToMove.
	self assert: effect showName equals: 'Hyper Jump'
]

{ #category : 'tests' }
EffectsTest >> test014WhenCreatAtomicBombThenReturnName [

	| parsecsToMove effect |
	effect := AtomicBomb new.
	self assert: effect showName equals: 'Atomic Bomb'
]

{ #category : 'tests' }
EffectsTest >> test015WhenCreatMoonWalkThenReturnName [

	| parsecsToMove effect |
	effect := MoonWalk new.
	self assert: effect showName equals: 'Moon Walk'
]

{ #category : 'tests' }
EffectsTest >> test016WhenCreatHyperSpaceJumpThenReturnName [

	| parsecsToMove effect |
	effect := HyperSpaceJump new.
	self assert: effect showName equals: 'Hyper Space Jump'
]
