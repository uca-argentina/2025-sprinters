Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
WormHoleTest >> test000WhenCreateWormHoleThenShowPositions [

	| aWorm aX aY |
	aX := 2.
	aY := 3.
	aWorm := Worm with: aX and: aY.
	self assert:
		(aWorm positionX = aX and: [ aWorm positionY = aY ])
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

	| aWorm aX aY aShip aPosition |
	aX := 2.
	aY := 6.
	aWorm := Worm with: aX and: aY.
	aPosition := 6.
	self assert: (aWorm sendPosition: aPosition) equals: 2.
]
