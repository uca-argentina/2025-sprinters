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
	typesOfCards add: RedoCard new.
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

{ #category : 'tests' }
CardTest >> test006WhenShip1FightToShip3UsingShip2AsMErcenaryAndShip3WonThenShip1AndShip2Loss1Shield [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 |
	aDice := LoadedDice withSequence: #( 1 3 1 7 2 4 ).
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
	self assert: ((aGame findShipBy: ship2) shields) + ((aGame findShipBy: ship1) shields) equals: 4.
]

{ #category : 'tests' }
CardTest >> test007WhenShip3AndShip1WanttheSameShipAsMercenaryThenRaiseError [

	| aDice dices aDiceBucket ship2 ship3 distributions amountOfCells aWorm aBoard laps ship1 ships typesOfCards aGame aCard |
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
	self
		should: [ aGame shipNamed: ship3 useCard: aCard with: ship2 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'You can not use this ship as a mercenary' ]
]

{ #category : 'tests' }
CardTest >> test008WhenUseAccelerationCardThenAllThrowsIncrementsBy1 [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 |
	aDice := LoadedDice withSequence: #( 1 2 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
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
	typesOfCards add: (FixedCard withTypeOfCard: AccelerationCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	aCard := AccelerationCard new.
	aGame shipNamed: ship1 useCard: aCard with: ship1.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) position  equals: 3.
	self assert: (aGame findShipBy: ship2) position  equals: 4.
	self assert: (aGame findShipBy: ship3) position  equals: 5.
]

{ #category : 'tests' }
CardTest >> test009WhenUseCancellationCardThenRemoveSpeedCard [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aSpeedCard aCancellationCard aFixedCardFactory |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
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
	typesOfCards add: (FixedCard withTypeOfCard: SpeedCard new).
	typesOfCards add: (FixedCard withTypeOfCard: CancellationCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	aSpeedCard := SpeedCard new.
	aFixedCardFactory := FixedCardFactory withTypes: typesOfCards.
	(aGame findShipBy: ship1) recieveCardsFrom: aFixedCardFactory.
	aGame shipNamed: ship1 useCard: aSpeedCard with: ship1.
	aCancellationCard := CancellationCard newWithCard: aSpeedCard.
	aGame shipNamed: ship1 useCard: aCancellationCard with: ship1 .
	aGame playTurn.

	self assert: (aGame findShipBy: ship1) position equals: 4.
]

{ #category : 'tests' }
CardTest >> test010WhenUseCancellationCardWithAccelerationThenRemoveAcceleration [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aAccelerationCard aCancellationCard aFixedCardFactory ship2 |
	aDice := LoadedDice withSequence: #( 1 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: AccelerationCard new).
	typesOfCards add: (FixedCard withTypeOfCard: CancellationCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	aAccelerationCard := AccelerationCard new.
	aFixedCardFactory := FixedCardFactory withTypes: typesOfCards.
	(aGame findShipBy: ship1) recieveCardsFrom: aFixedCardFactory.
	aGame shipNamed: ship1 useCard: aAccelerationCard with: ship1.
	aCancellationCard := CancellationCard newWithCard: aAccelerationCard.
	
	aGame playTurn.
	aGame shipNamed: ship1 useCard: aCancellationCard with: ship1 .
	aGame playTurn .
	self assert: (aGame findShipBy: ship1) position equals: 3.
	self assert: (aGame findShipBy: ship2) position equals: 4.
]

{ #category : 'tests' }
CardTest >> test011WhenUseCancellationCardWithMercenaryThenRemoveMercenary [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aMercenaryCard aCancellationCard aFixedCardFactory ship2 ship3|
	aDice := LoadedDice withSequence: #( 1 3 1 5 2 4 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
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
	typesOfCards add: (FixedCard withTypeOfCard: CancellationCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	aMercenaryCard := MercenaryCard new.
	aFixedCardFactory := FixedCardFactory withTypes: typesOfCards.
	(aGame findShipBy: ship1) recieveCardsFrom: aFixedCardFactory.
	aGame shipNamed: ship1 useCard: aMercenaryCard with: ship2.
	aCancellationCard := CancellationCard newWithCard: aMercenaryCard.
	aGame shipNamed: ship1 useCard: aCancellationCard with: ship1 .
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) shields equals: 2.
	self assert: (aGame findShipBy: ship2) isSomeoneMercenary equals: false.
]

{ #category : 'tests' }
CardTest >> test012WhenUseCancellationCardAndNoActiveCardsThenRaiseError [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aSpeedCard aCancellationCard aFixedCardFactory |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
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
	typesOfCards add: (FixedCard withTypeOfCard: CancellationCard new).

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	aSpeedCard := SpeedCard new.
	aCancellationCard := CancellationCard newWithCard: aSpeedCard.
	self
		should: [aGame shipNamed: ship1 useCard: aCancellationCard with: ship1 . ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'This card must be played when there is at least one active card' ]
]

{ #category : 'tests' }
CardTest >> test013WhenUseREDOCardThenItTakesTheEffectOfTheLastCardUsed [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard cardGiver |
	aDice := LoadedDice withSequence: #( 3 2 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	cardGiver := FixCardGiver with: RedoCard new.
	distributions add: (Distribution at: cardGiver with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: AccelerationCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: typesOfCards.
	acceleration := AccelerationCard new.
	redocard := RedoCard new.
	aGame shipNamed: ship1 useCard: acceleration with: ship1.
	aGame playTurn.
	aGame shipNamed: ship1 useCard: redocard with: ship1.
	aGame playTurn.
	self assert: (aGame findShipBy: ship2) position equals: 5
]
