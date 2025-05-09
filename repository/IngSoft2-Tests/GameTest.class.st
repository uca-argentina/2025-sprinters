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
	shipOne := Ship newShip.
	shipTwo := Ship newShip.
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
	shipOne := Ship newShip.
	shipTwo := Ship newShip.
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
	
	|listOfDices aDice aDiceBucket  aBoard amountOfCells aWorm aGame listOfShips shipOne |
	
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
	self assert: aGame showWinner equals: shipOne 
	
]
