Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> test000WhenCreateShipThenPositionEqualsZero [

| aShip |

aShip := Ship newShip.

self assert: aShip showPosition equals: 0.
]

{ #category : 'tests' }
ShipTest >> test001WhenShipReceiveANumberThenMovesThatAmount [

	| aShip diceGame |
	aShip := Ship newShip.
	diceGame := 2.
	aShip moveShip: diceGame.

	self assert: aShip showPosition equals: diceGame
]

{ #category : 'tests' }
ShipTest >> test002WhenCreateAShipWithNameThenReturnShipsName [

	| aShip shipName |
	shipName := 'Ship 1'.
	aShip := Ship createShip: shipName.

	self assert: aShip showName equals: shipName
]

{ #category : 'tests' }
ShipTest >> test003WhenCreateAShipWithNameThatIsNotAStringThenRaiceError [

	| shipName |
	shipName := 124.
	self
		should: [ Ship createShip: shipName ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Ship´s name must be a string.' ]
]
