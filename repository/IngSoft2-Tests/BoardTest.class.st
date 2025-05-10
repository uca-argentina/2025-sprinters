Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test000WhenCreateBoardWithAmountOfCellsThenShowAmountOfCells [

	| unTablero cantidadDeCasilleros |
	cantidadDeCasilleros := 10.
	unTablero := Board with: cantidadDeCasilleros.
	self assert: unTablero showCells equals: cantidadDeCasilleros
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
	aShip moveShip: 6.
	self assert: (aBoard verifyPosition: aShip) equals: 4.
]

{ #category : 'tests' }
BoardTest >> test006When [

	| amountOfCells aX aY aWorm aBoard aShip result |
	amountOfCells := 10.
	aX := 4.
	aY := 6.
	aWorm := Worm with: aX and: aY.
	aBoard := Board with: amountOfCells and: aWorm.

	aShip := Ship newShip.
	aShip moveShip: 3.

	result := aBoard positionTaken.

	self assert: (result at: 3) equals: true
]
