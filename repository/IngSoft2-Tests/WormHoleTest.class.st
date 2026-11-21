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

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 5 );
		         wormHoleBetween: 2 and: 6;
		         laps: 3;
		         build.
	aGame playTurn. "cae en 6 y el wormhole lo lleva a 2"
	self assert: (aGame positionOf: 'ship 1') equals: 2
]
