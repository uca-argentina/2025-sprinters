Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test000WhenPlayGameThenWinnerShowWinnerIsNotNill [

	|listOfDices aDice aDiceBucket  aBoard amountOfCells aWorm aGame listOfShips shipOne shipTwo |
	
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
	aGame play.
	self assert: aGame showWinner isNotNil.
]

{ #category : 'tests' }
GameTest >> test001WhenPlayGameThenReturnGameOver [

	|listOfDices aDice aDiceBucket  aBoard amountOfCells aWorm aGame listOfShips shipOne shipTwo |
	
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
	
	self assert: aGame play equals: 'Game over'.
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

	| listOfDices aDice aDiceBucket aBoard amountOfCells aWorm aGame listOfShips shipOne assertedResult |
	listOfShips := OrderedCollection new.
	shipOne := Ship createShip: 'Ship 1'.
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
	assertedResult := Dictionary new.
	assertedResult at: 'Ship 1' put: 10.
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
	shipOne moveShip: 10 in: aBoard. 
	shipTwo moveShip: 5 in: aBoard.
	aGame play.
	assertedResult := Dictionary new.
	assertedResult at: 'Ship 1' put: 10.
	assertedResult at: 'Ship 2' put: 5.
	self assert: (aGame showShipsPositions) equals: assertedResult.
]

{ #category : 'tests' }
GameTest >> test005When2ShipsWithSameNameAddedInAListThenRaiseError [

	| listOfDices aDice aDiceBucket aBoard amountOfCells aWorm aGame listOfShips shipOne assertedResult shipTwo shipThree |
	listOfShips := OrderedCollection new.
	shipOne := Ship createShip: 'Ship 1'.
	shipTwo := Ship createShip: 'Ship 2'.
	shipThree := Ship createShip: 'Ship 1'.
	listOfDices := OrderedCollection new.
	listOfShips add: shipOne.
	listOfShips add: shipTwo.
	listOfShips add: shipThree.
	aDice := Dice with: 5.
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells and: aWorm.

	self
		should: [ Game with: aBoard and: aDiceBucket and: listOfShips ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Ship´s name must not be reapeated.' ]
]

{ #category : 'tests' }
GameTest >> test006WhenCreateGamewithEmptyShipsThenRaiseError [ [

    | listOfDices aDice aDiceBucket aBoard amountOfCells aWorm aGame listOfShips shipOne assertedResult shipTwo shipThree |
    listOfShips := OrderedCollection new.
    listOfDices := OrderedCollection new.
    aDice := Dice with: 5.
    listOfDices add: aDice.
    aDiceBucket := DiceBucket with: listOfDices.
    amountOfCells := 10.
    aWorm := Worm with: 2 and: 4.
    aBoard := Board with: amountOfCells and: aWorm.

    self
        should: [ Game with: aBoard and: aDiceBucket and: listOfShips ]
        raise: Error
        withExceptionDo: [ :error |
            self
                assert: error messageText
                equals: 'List of ships must not be empty.' ]
]
]
