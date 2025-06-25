Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#instVars : [
		'typesOfCards'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test000WhenPlayGameThenWinnerShowWinnerIsNotNill [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).

	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	aGame play.
	self assert: aGame showWinner isNotNil
]

{ #category : 'tests' }
GameTest >> test001WhenPlayGameThenReturnGameOver [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).


	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).

	self assert: aGame play equals: 'Game over'
]

{ #category : 'tests' }
GameTest >> test002WhenPlayGameWithOneShipThenReturnWinner [

	| listOfDices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships distributions typesOfCards |
	ships := OrderedCollection new.
	listOfDices := OrderedCollection new.
	ships add: 'shipOne'.
	aDice := Dice with: 5.
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	aGame play.
	self assert: aGame showWinner name equals: 'shipOne'
]

{ #category : 'tests' }
GameTest >> test003WhenSomeShipWinThenShowPositions [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships assertedResult distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 5 8 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	ships add: 'ship 1'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	aGame play.
	assertedResult := Dictionary new.
	assertedResult at: 'ship 1' put: 10.
	self assert: aGame showShipsPositions equals: assertedResult
]

{ #category : 'tests' }
GameTest >> test004When2ShipsPlayAndShipOneWonThenReturnPositions [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships assertedResult distributions typesOfCards |
	ships := OrderedCollection new.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	(aGame ships at: 1) move: 10 in: aBoard.
	(aGame ships at: 2) move: 5 in: aBoard.
	aGame play.
	assertedResult := Dictionary new.
	assertedResult at: 'ship 1' put: 10.
	assertedResult at: 'ship 2' put: 6.
	self assert: aGame showShipsPositions equals: assertedResult
]

{ #category : 'tests' }
GameTest >> test005When2ShipsWithSameNameAddedInAListThenRaiseError [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm ships distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).

	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 1'.

	self
		should: [
			Game
				with: aBoard
				using: aDiceBucket
				andShipsNamed: ships
				until: 1 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Ship´s name must not be reapeated.' ]
]

{ #category : 'tests' }
GameTest >> test006WhenCreateGamewithEmptyShipsThenRaiseError [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm ships distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).

	self
		should: [
			Game
				with: aBoard
				using: aDiceBucket
				andShipsNamed: ships
				until: 0 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'List of ships must not be empty.' ]
]

{ #category : 'tests' }
GameTest >> test007WhenCreateGameThenGameCreateShips [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).

	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).

	self assert: (aGame ships at: 1) position equals: 1
]

{ #category : 'tests' }
GameTest >> test008WhenGameHasPlayedThenShowRanking [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps assertedResult distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 6 10 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 1.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps
		         having: (FixedCardFactory with: typesOfCards).

	(aGame ships at: 2) move: 10 in: aBoard.
	aGame play.
	assertedResult := OrderedCollection new.
	assertedResult add: 'ship 2'.
	assertedResult add: 'ship 1'.
	self assert: aGame showRanking equals: assertedResult
]

{ #category : 'tests' }
GameTest >> test009WhenGameHasPlayedWithLoadedDiceThenShowShipSortedByPositionReturnShip1AtFirst [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps result distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 10 7 20 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	result := aGame shipsSortedByPosition.
	self assert: (result at: 1) name equals: 'ship 3'
]

{ #category : 'tests' }
GameTest >> test010WhenGameHasNotPlayedThenShowRankingRaiseError [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         having: (FixedCardFactory with: typesOfCards).
	self
		should: [ aGame showRanking ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals:
				'The Game has not been played yet so it doesn`t have a ranking' ]
]

{ #category : 'tests' }
GameTest >> test011WhenShipIsOnCellWithEffectThenReceiveEffect [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions typesOfCards |
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
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps
		         having: (CardFactory with: typesOfCards).
	aGame playTurn.
	self assert: (aGame ships at: 1) position equals: 3
]

{ #category : 'tests' }
GameTest >> test012WhenBoardIsCreatedThenEffectsAreDistributedAccordingToProbability [

	| board amountOfCells worm distributions cardEffectCount blackHoleCount noEffectCount totalCells tolerance distanceToMove effect name hyperSpaceCount hyperJumpCount moonWalkCount atomicBombCount |
	amountOfCells := 1000.
	worm := Worm with: 2 and: 4.
	distanceToMove := OrderedCollection new.
	distanceToMove add: (Distance lightYear: 27).
	distanceToMove add: (Distance lightYear: 18).
	distanceToMove add: (Distance lightYear: 9).
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 0.38).
	distributions add: (Distribution at: CardGiver with: 0.10).
	distributions add: (Distribution at: BlackHole with: 0.20).
	distributions add: (Distribution at: HyperSpaceJump with: 0.20).
	distributions add: (Distribution at: MoonWalk with: 0.10).
	distributions add:
		(Distribution at: (HyperJump with: distanceToMove) with: 0.08).
	distributions add: (Distribution at: AtomicBomb with: 0.02).

	board := Board
		         with: amountOfCells
		         and: worm
		         has: distributions
		         basedOn: (Distance parsecs: 20).

	cardEffectCount := board amountOfCellsOf: 'CardGiver' .
	blackHoleCount := board  amountOfCellsOf: 'BlackHole' .
	noEffectCount := board  amountOfCellsOf:  'NoEffect' .
	hyperSpaceCount := board  amountOfCellsOf: 'HyperSpaceJump' .
	hyperJumpCount := board  amountOfCellsOf: 'HyperJump' .
	moonWalkCount := board  amountOfCellsOf:  'MoonWalk' .
	atomicBombCount := board  amountOfCellsOf:  'AtomicBomb' .

	totalCells := amountOfCells.
	tolerance := 0.05. "5% de margen de error\"

	self assert: cardEffectCount / totalCells >=( 0.10 - tolerance).
	self assert: cardEffectCount / totalCells <= (0.10 + tolerance).

	self assert: blackHoleCount / totalCells >= (0.20 - tolerance).
	self assert: blackHoleCount / totalCells <= (0.20 + tolerance).

	self assert: noEffectCount / totalCells >= (0.38 - tolerance).
	self assert: noEffectCount / totalCells <= (0.38 + tolerance)
]

{ #category : 'tests' }
GameTest >> test012WhenShipIsOnCellWithNoEffectThenDoNotReceiveEffect [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions typesOfCards |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps
		         having: (CardFactory with: typesOfCards).
	aGame playTurn.
	self assert: (aGame ships at: 1) position equals: 6
]

{ #category : 'tests' }
GameTest >> test013WhenTwoShipsAreInTheSameCellWithEffectThenTheyDoNotBattle [

	| aDice aBoard amountOfCells aWorm aGame ships laps distributions dices1 typesOfCards aDiceBucket1 dices2 aDiceBucket2 ship1 ship2 ship aDiceBucket |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 6 3 3 5 ).
	dices1 add: aDice.
	aDiceBucket1 := DiceBucket with: dices1.
	aDice := LoadedDice with: 4.
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships add: ship1.
	ships add: ship2.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket1
		         andShipsNamed: ships
		         until: laps
		         having: (CardFactory with: typesOfCards).
	aGame playTurn.
	aGame playTurn.
	ship := aGame ships at: 1.
	self assert: ship shields + ship position equals: 6
]

{ #category : 'tests' }
GameTest >> test014WhenShipIsMovedBecauseAnEffectToACallWithEffectThenShipSoNotReceiveTheSecondEffect [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions ship1 |
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
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps
		         having: (CardFactory with: typesOfCards).
	ship1 := aGame ships at: 1.
	aGame playTurn. " la nave se mueve 5  y cae en una celda 14 con efecto, efecto lo mueve a la posiion 10 , en la posicion hay un Blackhol e pero no debe moverse mas "
	self assert: ship1 position equals: 3
]

{ #category : 'tests' }
GameTest >> test015WhenShipIsMovedBecauseAnEffectAndItdNewPositionHasAnotherShipThenFight [

	| aDice aBoard amountOfCells aWorm aGame ships laps distributions ship1 dices1 aDiceBucket1 ship2 |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 14 3 ).
	dices1 add: aDice.
	aDiceBucket1 := DiceBucket with: dices1.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships add: ship1.
	ships add: ship2.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket1
		         andShipsNamed: ships
		         until: laps
		         having: (CardFactory with: typesOfCards).
	aGame playTurn. " la nave se mueve 5  y cae en una celda 14 con efecto, efecto lo mueve a la posiion 10 , en la posicion hay un Blackhol e pero no debe moverse mas "
	self assert: (aGame ships at: 1) position equals: 1
]

{ #category : 'tests' }
GameTest >> test016WhenShipIsMovedBecauseAnEffectAndItAppearOnWormHoleThenITDoNotTransferThrowTheWormHole [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions ship1 dices1 aDiceBucket1 dices2 aDiceBucket2 ship2 |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 7 5 ).
	dices1 add: aDice.
	aDiceBucket1 := DiceBucket with: dices1.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships add: ship1.
	ships add: ship2.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket1
		         andShipsNamed: ships
		         until: laps
		         having: (CardFactory with: typesOfCards).
	aGame playTurn.
	self assert: (aGame ships at: 1) position equals: 4
]

{ #category : 'tests' }
GameTest >> test017WhenGameIsCreatedThenAShipFromCollectionWins [

	| board amountOfCells worm distributions cardEffectCount blackHoleCount noEffectCount totalCells tolerance distanceToMove effect name hyperSpaceCount hyperJumpCount moonWalkCount atomicBombCount aDice dices1 aDiceBucket1 aWorm laps ship1 ship2 ships ship3 ship4 aGame aBoard winner |
	amountOfCells := 5.
	worm := Worm with: 2 and: 4.
	distanceToMove := OrderedCollection new.
	distanceToMove add: (Distance lightYear: 27).
	distanceToMove add: (Distance lightYear: 18).
	distanceToMove add: (Distance lightYear: 9).
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 0.38).
	distributions add: (Distribution at: CardGiver with: 0.10).
	distributions add: (Distribution at: BlackHole with: 0.20).
	distributions add: (Distribution at: HyperSpaceJump with: 0.20).
	distributions add: (Distribution at: MoonWalk with: 0.10).
	distributions add:
		(Distribution at: (HyperJump with: distanceToMove) with: 0.08).
	distributions add: (Distribution at: AtomicBomb with: 0.02).

	aBoard := Board
		          with: amountOfCells
		          and: worm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	aDice := Dice with: 6.
	dices1 := OrderedCollection new.
	dices1 add: aDice.
	aDiceBucket1 := DiceBucket with: dices1.
	amountOfCells := 5.
	aWorm := Worm with: 2 and: 4.
	ships := OrderedCollection new.
	laps := 3.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships add: ship1.
	ships add: ship2.
	ship3 := 'ship 3'.
	ship4 := 'ship 4'.
	ships add: ship3.
	ships add: ship4.
	typesOfCards := OrderedCollection new.
	typesOfCards add: (FixedCard withTypeOfCard: MercenaryCard new).
	aGame := Game
		         with: aBoard
		         using: aDiceBucket1
		         andShipsNamed: ships
		         until: laps
		         having: (CardFactory with: typesOfCards).
	aGame play.
	ships := #( 'ship 1' 'ship 2' 'ship 3' 'ship 4' ).
	winner := aGame showWinner.
	self assert: (ships includes: winner name)
]
