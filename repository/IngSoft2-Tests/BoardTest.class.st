Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test000WhenCreateBoardWithAmountOfCellsThenShowAmountOfCells [

	| aBoard amountOfCells |
	amountOfCells := 10.
	aBoard := Board with: amountOfCells.
	self assert: aBoard showCells equals: amountOfCells
]

{ #category : 'tests' }
BoardTest >> test001WhenPlayGameThenReturnGameOver [

	| aBoard amountOfCells aWorm aX aY |
	amountOfCells := 10.
	aX := 4.
	aY := 6.
	aWorm := Worm with: aX and: aY. 
	aBoard := Board with: amountOfCells and: aWorm.
	self assert: aBoard showSpecialCells equals: {aX. aY}.
]

{ #category : 'tests' }
BoardTest >> test002WhenCreateBoardWithWrongWormHolePostionThenReturnsError [

	| amountOfCells aWorm |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 11. 
	self 
	
	should: [ Board with: amountOfCells and: aWorm.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Position of the worm hole exceed amount board`s cells' ].
]

{ #category : 'tests' }
BoardTest >> test003WhenCreateBoardWithCellsLessThan1ThenReturnsError [

	| amountOfCells aWorm |
	amountOfCells := 0.
	aWorm := Worm with: 4 and: 11. 
	self 
	
	should: [ Board with: amountOfCells and: aWorm.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Amount of cells must be greater than zero' ].
]

{ #category : 'tests' }
BoardTest >> test004WhenCreateBoardWithCellsNotIntegerThenReturnsError [

	| amountOfCells aWorm |
	amountOfCells := 3.14.
	aWorm := Worm with: 4 and: 11. 
	self 
	
	should: [ Board with: amountOfCells and: aWorm.]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Amount of cells must be an integer' ].
]

{ #category : 'tests' }
BoardTest >> test005WhenShipMovesToWormholeThenBoardKnowsThePositionOfShip [

	| amountOfCells aX aY aWorm aBoard aShip |
	amountOfCells := 10.
	aX := 4.
	aY := 6.
	aWorm := Worm with: aX and: aY.
	aBoard := Board with: amountOfCells and: aWorm.
	aShip := Ship newShip.
	aShip move: 6.
	self assert: (aBoard verifyPosition: aShip) equals: 4.
]

{ #category : 'tests' }
BoardTest >> test006WhenShipMoveMoreThanCellsInTheBoardThenPositionIsAmountOfCells [
	| amountOfCells aX aY aWorm aBoard aShip |
	amountOfCells := 4.
	aX := 1.
	aY := 2.
	aWorm := Worm with: aX and: aY.
	aBoard := Board with: amountOfCells and: aWorm.
	aShip := Ship create: 'ship1'.
	aShip move: 6 in: aBoard.
	self assert: (aBoard verifyPosition: aShip) equals: 4.
]
