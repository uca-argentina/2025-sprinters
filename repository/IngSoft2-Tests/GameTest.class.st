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

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 tmp8 tmp9 |
	tmp8 := OrderedCollection new.
	tmp9 := Ship newShip.
	tmp1 := OrderedCollection new.
	tmp8 add: tmp9.
	tmp2 := Dice with: 5.
	tmp1 add: tmp2.
	tmp3 := DiceBucket with: tmp1.
	tmp5 := 10.
	tmp6 := Worm with: 2 and: 4.
	tmp4 := Board with: tmp5 and: tmp6.
	tmp7 := Game with: tmp4 and: tmp3 and: tmp8.
	tmp7 play.
	self assert: tmp7 showWinner equals: tmp9
]
