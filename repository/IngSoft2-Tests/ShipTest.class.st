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
