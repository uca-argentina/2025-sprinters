Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test000WhenCreateSpeedCardThenShipSumOneInItThrow [

	| aDice dices aDiceBucket amountOfCells aWorm distributions aBoard ships aGame typesOfCards cards |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	ships := OrderedCollection new.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    andTotalParsec: 20.
	ships add: 'ship 1'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: InstantCard new.
	typesOfCards add: PermanentCard new.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
					having: typesOfCards .
	self assert: (aGame ships at: 1) cards size equals: 2
]

{ #category : 'tests' }
CardTest >> test001WhenUseSpeedCardFromDeckThenApplyItEffect [

	| aDice dices aDiceBucket ship fixedCardFactory distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard cards typesOfCards |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10. 
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 1.
	ship1 := 'ship 1'.
	ships := OrderedCollection new.
	ships add: ship1.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: (SpeedCard new)).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
					having: typesOfCards .
	aCard := SpeedCard new.
	aGame shipNamed: ship1 useCard: aCard with: ship1.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) position equals: 8
]

{ #category : 'tests' }
CardTest >> test002WhenShipWantsToPlayThatItDoesNotHaveThenRaiseError [

	| aDice dices aDiceBucket ship distributions amountOfCells aWorm aBoard laps ship1 ships typesOfCards aGame aCard |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 1.
	ship1 := 'ship 1'.
	ships := OrderedCollection new.
	ships add: ship1.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	aCard := SpeedCard new.

	self
		should: [ aGame shipNamed: ship1 useCard: aCard with: ship1 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'You can not use a card that you do not have' ]
]

{ #category : 'tests' }
CardTest >> test003WhenShipUseMercenaryCardWithShip2ThenTheyDoNotBattle [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards mercenary |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 1.
	ship1 := 'ship 1'.
	mercenary := 'mercenary'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: mercenary.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	aCard := MercenaryCard new.
	aGame shipNamed: ship1 useCard: aCard with: mercenary.
	aGame playTurn.
	aGame playTurn.
	self
		assert: (aGame findShipBy: ship1) shields
		equals: (aGame findShipBy: mercenary) shields
]

{ #category : 'tests' }
CardTest >> test004WhenAShipUseSpeedCardThenIsRemovedFromDeckOfShip [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10. 
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 1.
	ship1 := 'ship 1'.
	ships := OrderedCollection new.
	ships add: ship1.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: (SpeedCard new)).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
					having: typesOfCards .
	aCard := SpeedCard new.
	aGame shipNamed: ship1 useCard: aCard with: ship1.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) cards size equals: 1
]

{ #category : 'tests' }
CardTest >> test005WhenShip1FightToShip3UsingShip2AsMErcenaryThenShip1WinTheBattle [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 |
	aDice := LoadedDice withSequence: #( 1 3 1 5 2 4 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ship3 := 'ship 3'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	aCard := MercenaryCard new.
	aGame shipNamed: ship1 useCard: aCard with: ship2.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame findShipBy: ship3) shields equals: 2
]
