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
