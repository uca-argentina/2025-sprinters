Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormHoleTest >> test000WhenCreateWormHoleThenShowPositions [

	| aWorm aX aY positions |
	aX := 2.
	aY := 3.
	aWorm := Worm with: aX and: aY.
	positions := aWorm positions.
	self assert: ((positions at: 1) = aX and: [ (positions at: 2) = aY ])
]

{ #category : 'tests' }
WormHoleTest >> test001WhenCreateWormHoleWithNegativePositionsThenReturnsError [

	self 
	
	should: [ Worm with: -4 and: -6 ]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Worm holes positions must be greater than zero' ].
]

{ #category : 'tests' }
WormHoleTest >> test002WhenCreateEqualWormHolePositionsThenReturnsError [

	self 
	
	should: [ Worm with: 4 and: 4 ]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Worm holes positions must be different' ].
]

{ #category : 'tests' }
WormHoleTest >> test003WhenCreateWormHolesPositionNoIntegersThenReturnsError [

	self
		should: [ Worm with: 3.14 and: '4' ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Worm holes positions must be integers' ]
]

{ #category : 'tests' }
WormHoleTest >> test004WhenShipMovesInsideWormholeThenPositionChanges [

	| aWorm aX aY aPosition aBoard amountOfCells distributions laps ships cardManager aGame aDiceBucket ship1 aVar|
	aX := 2.
	aY := 6.
	aWorm := Worm with: aX and: aY.
	distributions := OrderedCollection new.
	ships := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aPosition := 6.
	aBoard := Board
		          with: 10
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	cardManager := CardManager creation.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps
		         cardManager: cardManager.
	ship1 := aGame findShipBy: 'ship 1'.
	ship1 move: 5 in: aBoard.
	aWorm applyTo: ship1 in: aGame.
	aVar:= 5.
	self assert: ship1 position equals: 2
]
