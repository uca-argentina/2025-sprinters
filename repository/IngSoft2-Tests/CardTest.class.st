Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test000WhenCreateSpeedCardThenShipSumOneInItThrow [

	| aDice dices aDiceBucket amountOfCells aWorm distributions aBoard ships aGame |
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
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1.
	self assert: (aGame ships at: 1) cards size equals: 2
]

{ #category : 'tests' }
CardTest >> test001WhenUseSpeedCardThenApplyItEffect [

	| aDice dices aDiceBucket amountOfCells aWorm distributions aBoard ships aGame ship fixedCardFactory |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	fixedCardFactory := FixedCardFactory with: SpeedCard.
	ship := Ship
		        create: 'ship'
		        with: aDiceBucket
		        andReceiveCardsFrom: fixedCardFactory.
	ship use: SpeedCard.
	self assert: ship throwBucket equals: 7
]

{ #category : 'tests' }
CardTest >> test002WhenShipWantsTOPlayThatITDOesNotHaveThenRaiseError [

	| aDice dices aDiceBucket ship |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	ship := Ship
		        create: 'ship'
		        with: aDiceBucket
		        andReceiveCardsFrom: (FixedCardFactory with: MercenaryCard).

	self
		should: [ ship use: SpeedCard ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'You can not play a card that you do not have' ]
]

{ #category : 'tests' }
CardTest >> test003WhenShipUseMercenaryCardWithShip2ThenTheyDoNotBattle [

	| aDice dices aDiceBucket ship ship1 ship2 ship3 mercenary battleManager ships amountOfCells aWorm distributions aBoard laps aGame |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 6 ).
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
	ships add: 'ship 2'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.
	aGame shipNamed: 'ship 1' useCard: MercenaryCard with: 'ship 2'.
	aGame playTurn.
	aGame playTurn.
	self assert: ship1 shields equals: mercenary shields
]
