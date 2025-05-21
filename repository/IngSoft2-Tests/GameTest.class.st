Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test000WhenPlayGameThenWinnerShowWinnerIsNotNill [

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
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships.
	aGame play.
	self assert: aGame showWinner isNotNil
]

{ #category : 'tests' }
GameTest >> test001WhenPlayGameThenReturnGameOver [

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
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships.

	self assert: aGame play equals: 'Game over'
]

{ #category : 'tests' }
GameTest >> test002WhenPlayGameWithOneShipThenReturnWinner [

	|listOfDices aDice aDiceBucket  aBoard amountOfCells aWorm aGame listOfShips shipOne|
	
	listOfShips := OrderedCollection new.
	shipOne := Ship newShip.
	listOfDices := OrderedCollection new.
	listOfShips add: shipOne.
	aDice := Dice with: 5.
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells and: aWorm.
	aGame := Game with: aBoard and: aDiceBucket and: listOfShips.
	aGame play.
	self assert: aGame showWinner equals: shipOne.
]

{ #category : 'tests' }
GameTest >> test003WhenSomeShipWinThenShowPositions [

	| dices aDice aDiceBucket aBoard amountOfCells aWorm aGame ships assertedResult |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := Dice with: 5.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells and: aWorm.
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

	|listOfDices aDice aDiceBucket  aBoard amountOfCells aWorm aGame listOfShips shipOne assertedResult shipTwo |
	
	listOfShips := OrderedCollection new.
	shipOne := Ship createShip: 'Ship 1'.
	shipTwo := Ship createShip: 'Ship 2'.
	listOfDices := OrderedCollection new.
	listOfShips add: shipOne.
	listOfShips add: shipTwo.
	aDice := Dice with: 5.
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells and: aWorm.
	aGame := Game with: aBoard and: aDiceBucket and: listOfShips.
	shipOne move: 10 in: aBoard. 
	shipTwo move: 5 in: aBoard.
	aGame play.
	assertedResult := Dictionary new.
	assertedResult at: 'Ship 1' put: 10.
	assertedResult at: 'Ship 2' put: 5.
	self assert: (aGame showShipsPositions) equals: assertedResult.
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

	self assert: (aGame ships at: 1) showPosition equals: 0
]
