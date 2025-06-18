Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test000WhenPlayGameThenWinnerShowWinnerIsNotNill [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board with: amountOfCells and: aWorm has: distributions.

	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships.
	aGame play.
	self assert: ((aGame currentStatus) showWinner:aGame) isNotNil
]

{ #category : 'tests' }
GameTest >> test001WhenPlayGameThenReturnGameOver [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board with: amountOfCells and: aWorm has: distributions.


	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships.

	self assert: aGame play equals: 'Game over'
]

{ #category : 'tests' }
GameTest >> test002WhenPlayGameWithOneShipThenReturnWinner [

	| listOfDices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships distributions |
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
	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	aGame := Game with: aBoard using: aDiceBucket andShipsNamed: ships.
	aGame play.
	self assert: ((aGame currentStatus) showWinner:aGame) name equals: 'shipOne'
]

{ #category : 'tests' }
GameTest >> test003WhenSomeShipWinThenShowPositions [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships assertedResult distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships.
	aGame play.
	assertedResult := Dictionary new.
	assertedResult at: 'ship 1' put: 10.
	self assert: aGame showShipsPositions equals: assertedResult
]

{ #category : 'tests' }
GameTest >> test004When2ShipsPlayAndShipOneWonThenReturnPositions [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships assertedResult distributions |
	ships := OrderedCollection new.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #(5).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	aGame := Game with: aBoard using: aDiceBucket andShipsNamed: ships.
	(aGame ships at: 1) move: 10.
	(aGame ships at: 2) move: 5.
	aGame play.
	assertedResult := Dictionary new.
	assertedResult at: 'ship 1' put: 10.
	assertedResult at: 'ship 2' put: 6.
	self assert: aGame showShipsPositions equals: assertedResult
]

{ #category : 'tests' }
GameTest >> test005When2ShipsWithSameNameAddedInAListThenRaiseError [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm ships |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells and: aWorm.

	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 1'.

	self
		should: [
		Game with: aBoard using: aDiceBucket andShipsNamed: ships ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Ship´s name must not be reapeated.' ]
]

{ #category : 'tests' }
GameTest >> test006WhenCreateGamewithEmptyShipsThenRaiseError [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm ships |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells and: aWorm.


	self
		should: [
		Game with: aBoard using: aDiceBucket andShipsNamed: ships ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'List of ships must not be empty.' ]
]

{ #category : 'tests' }
GameTest >> test007WhenCreateGameThenGameCreateShips [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells and: aWorm.

	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game with: aBoard using: aDiceBucket andShipsNamed: ships.

	self assert: (aGame ships at: 1) position equals: 1
]

{ #category : 'tests' }
GameTest >> test008WhenGameHasPlayedThenShowRanking [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps assertedResult distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 6 10 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	laps := 1.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.

	(aGame ships at: 2) move: 10 in: aBoard.
	aGame play.
	assertedResult := OrderedCollection new.
	assertedResult add: 'ship 2'.
	assertedResult add: 'ship 1'.
	self assert: aGame showRanking equals: assertedResult
]

{ #category : 'tests' }
GameTest >> test009WhenGameHasPlayedWithLoadedDiceThenShowShipSortedByPositionReturnShip1AtFirst [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps assertedResult result ship1 ship2 ship3 |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with: 10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells.
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.
	ship1 := aGame ships at: 1.
	ship2 := aGame ships at: 2.
	ship3 := aGame ships at: 3.
	ship2 move: 10.
	ship1 move: 7.
	ship3 move: 20.
	result := aGame shipsSortedByPosition.
	self assert: (result at: 1) name equals: 'ship 3'
]

{ #category : 'tests' }
GameTest >> test010WhenGameHasNotPlayedThenShowRankingRaiseError [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps assertedResult |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice with:10.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells.
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.
	self
		should: [
		 aGame showRanking ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'The Game has not been played yet so it doesn`t have a ranking' ]
]

{ #category : 'tests' }
GameTest >> test011WhenShipIsOnCellWithEffectThenReceiveEffect [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #(6).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).

	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.
	aGame playTurn.
	self assert: (aGame ships at: 1) position equals: 3
]

{ #category : 'tests' }
GameTest >> test012WhenShipIsOnCellWithNoEffectThenDoNotReceiveEffect [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #(5).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).

	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.
	aGame playTurn.
	self assert: (aGame ships at: 1) position equals: 6
]

{ #category : 'tests' }
GameTest >> test013WhenTwoShipsAreInTheSameCellWithEffectThenTheyDoNotBattle [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions dices1 aDiceBucket1 dices2 aDiceBucket2 ship1 ship2 |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice := LoadedDice withSequence: #(6).
	dices1 add: aDice.
	aDiceBucket1 := DiceBucket with: dices1.
	aDice := LoadedDice with: 4.
	dices2 := OrderedCollection new.
	dices2 add: aDice.
	aDiceBucket2 := DiceBucket with: dices2.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).

	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	laps := 3.
	ship1 := Ship create: 'ship 1' with: aDiceBucket1.
	ship2 := Ship create: 'ship 2' with: aDiceBucket2.
	ships add: ship1.
	ships add:ship2.
	aGame := FixGame
		         with: aBoard
		         using: aDiceBucket1
		         andShipsNamed: ships
		         until: laps.
	ship2 move: 6 in: aBoard.
	aGame playTurn.
	self
		assert: ship1 showShields + ship1 position
		equals: 6
]

{ #category : 'tests' }
GameTest >> test014WhenShipIsMovedBecauseAnEffectToACallWithEffectThenShipSoNotReceiveTheSecondEffect [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions ship1 |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #(6).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).

	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	laps := 3.
	ships add: 'ship 1'.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps.
	ship1 := aGame ships at: 1.
	aGame playTurn. " la nave se mueve 5  y cae en una celda 14 con efecto, efecto lo mueve a la posiion 10 , en la posicion hay un Blackhol e pero no debe moverse mas "
	self assert: ship1 position equals: 3
]

{ #category : 'tests' }
GameTest >> test015WhenShipIsMovedBecauseAnEffectAndItdNewPositionHasAnotherShipThenFight [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships laps distributions ship1 dices1 aDiceBucket1 dices2 aDiceBucket2 ship2 |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 14 3 ).
	dices1 add: aDice.
	aDiceBucket1 := DiceBucket with: dices1.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).

	aBoard := Board with: amountOfCells and: aWorm has: distributions.
	laps := 3.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships add: ship1.
	ships add: ship2.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket1
		         andShipsNamed: ships
		         until: laps.
	aGame playTurn. " la nave se mueve 5  y cae en una celda 14 con efecto, efecto lo mueve a la posiion 10 , en la posicion hay un Blackhol e pero no debe moverse mas "
	self assert: (aGame ships at:1) position equals: 1
]
