Class {
	#name : 'TurnManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TurnManagerTest >> test000WhenCalledNextShipToPlayThenReturnsNextShipToPlay [

| shipOne ships aTurnManager |
shipOne:=Ship create: 'Ship one'.
ships := OrderedCollection new.
ships add: shipOne.
aTurnManager := TurnManager with: ships.

self assert: aTurnManager nextShip equals: shipOne.
]

{ #category : 'tests' }
TurnManagerTest >> test001WhenTwoShipsArePlayingAndFirstPlayedThenNextShipIsShipTwo [

	| shipOne ships aTurnManager shipTwo |
	shipOne := Ship create: 'Ship one'.
	shipTwo :=  Ship create: 'Ship two'.
	ships := OrderedCollection new.
	ships add: shipOne.
	ships add: shipTwo.
	aTurnManager := TurnManager with: ships.
	aTurnManager nextShip.

	self assert: aTurnManager nextShip equals: shipTwo
]

{ #category : 'tests' }
TurnManagerTest >> test002WhenAllShipsHasPlayedThenNextShipIsTheFirst [

	| shipOne ships aTurnManager shipTwo |
	shipOne :=Ship create: 'Ship one'.
	shipTwo := Ship create: 'Ship two'.
	ships := OrderedCollection new.
	ships add: shipOne.
	ships add: shipTwo.
	aTurnManager := TurnManager with: ships.
	aTurnManager nextShip.
	aTurnManager nextShip.
	self assert: aTurnManager nextShip equals: shipOne
]

{ #category : 'tests' }
TurnManagerTest >> test003WhenShipsAreEmptyThenRaiseError [

	| ships |
	ships := OrderedCollection new.


	self
		should: [ TurnManager with: ships ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Ships must to have one item at least' ]
]

{ #category : 'tests' }
TurnManagerTest >> test004WhenShip1DoesNotWantsToPlayThenReturnShip2 [

	| ships ship1 ship2 turnManager actualShip |
	ships := OrderedCollection new.
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	ships add: ship1.
	ships add: ship2.
	turnManager := TurnManager with: ships.
	turnManager skipTurnForShipNamed: 'ship1'.
	actualShip := turnManager nextShip.
	self assert: actualShip name equals: 'ship2'
]

{ #category : 'tests' }
TurnManagerTest >> test005WhenShip1andShip2DoNotWantsToPlayThenReturnShip3 [

	| ships ship1 ship2 turnManager actualShip ship3 |
	ships := OrderedCollection new.
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	ship3 := Ship create: 'ship3'.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	turnManager := TurnManager with: ships.
	turnManager skipTurnForShipNamed: 'ship1'.
	turnManager skipTurnForShipNamed: 'ship2'.
	actualShip := turnManager nextShip.
	self assert: actualShip name equals: 'ship3'
]

{ #category : 'tests' }
TurnManagerTest >> test006WhenShip1CanNotPlayThenNextPlayableShipIsShip2 [

	| ships ship1 ship2 turnManager actualShip ship3 |
	ships := OrderedCollection new.
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	ship3 := Ship create: 'ship3'.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	ship1 loseShield.
	ship1 loseShield.
	ship1 loseShield.
	turnManager := TurnManager with: ships.
	actualShip := turnManager nextPlayableShip.
	self assert: actualShip name equals: 'ship2'.
]

{ #category : 'tests' }
TurnManagerTest >> test007WhenShip1CanNotPlayThenNextShipIsShip2 [

	| ships ship1 ship2 turnManager actualShip ship3 |
	ships := OrderedCollection new.
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	ship3 := Ship create: 'ship3'.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	ship1 loseShield.
	ship1 loseShield.
	ship1 loseShield.
	turnManager := TurnManager with: ships.
	actualShip := turnManager nextShip.
	self assert: actualShip name equals: 'ship2'.
]

{ #category : 'tests' }
TurnManagerTest >> test008WhenAllShipsCanNotPlayThenRaiseError [

	| ships ship1 ship2 turnManager |
	ships := OrderedCollection new.
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	ships add: ship1.
	ships add: ship2.
	ship1 loseShield.
	ship1 loseShield.
	ship1 loseShield.
	ship2 loseShield.
	ship2 loseShield.
	ship2 loseShield.
	turnManager := TurnManager with: ships.
	self
		should: [ turnManager nextShip ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'There is no ship witch can play' ]
]
