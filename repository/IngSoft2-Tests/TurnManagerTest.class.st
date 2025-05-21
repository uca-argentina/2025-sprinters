Class {
	#name : 'TurnManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TurnManagerTest >> test000WhenCalledNextShipToPlayThenReturnsNextShipToPlay [

| shipOne ships aTurnManager |
shipOne:= 'Ship one'.
ships := OrderedCollection new.
ships add: shipOne.
aTurnManager := TurnManager with: ships.

self assert: aTurnManager nextShip equals: shipOne.
]

{ #category : 'tests' }
TurnManagerTest >> test001WhenTwoShipsArePlayingAndFirstPlayedThenNextShipIsShipTwo [

	| shipOne ships aTurnManager shipTwo |
	shipOne := 'Ship one'.
	shipTwo := 'Ship two'.
	ships := OrderedCollection new.
	ships add: shipOne.
	ships add: shipTwo.
	aTurnManager := TurnManager with: ships.
	aTurnManager nextShip.

	self assert: aTurnManager nextShip equals: shipTwo
]
