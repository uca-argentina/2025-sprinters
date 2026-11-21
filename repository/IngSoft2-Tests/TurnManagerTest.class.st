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
TurnManagerTest >> test006WhenShip1IsPenalizedThenNextPlayableShipIsShip2 [

	| ship1 ship2 turnManager |
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	turnManager := TurnManager with: { ship1. ship2 }.
	turnManager penalize: ship1 turns: 2.
	self assert: turnManager nextShip equals: ship2
]

{ #category : 'tests' }
TurnManagerTest >> test008WhenAllShipsCanNotPlayThenTheyLoseTheirTurnsUntilOneCanPlay [

	| ship1 ship2 turnManager |
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	turnManager := TurnManager with: { ship1. ship2 }.
	turnManager penalize: ship1 turns: 2.
	turnManager penalize: ship2 turns: 2.
	self assert: turnManager nextShip equals: ship1.
	self assert: turnManager nextShip equals: ship2
]

{ #category : 'tests' }
TurnManagerTest >> test009WhenAPenalizedShipHasLostItsTurnsThenItPlaysAgain [

	| ship1 ship2 ship3 turnManager playedShips |
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	ship3 := Ship create: 'ship3'.
	turnManager := TurnManager with: { ship1. ship2. ship3 }.
	turnManager penalize: ship1 turns: 2.
	playedShips := (1 to: 5) collect: [ :turn | turnManager nextShip name ].
	self
		assert: playedShips
		equals: #( 'ship2' 'ship3' 'ship2' 'ship3' 'ship1' )
]

{ #category : 'tests' }
TurnManagerTest >> test010WhenAShipIsPenalizedThenTheShipInTurnIsTheNextOneThatCanPlay [

	| ship1 ship2 turnManager |
	ship1 := Ship create: 'ship1'.
	ship2 := Ship create: 'ship2'.
	turnManager := TurnManager with: { ship1. ship2 }.
	turnManager penalize: ship1 turns: 2.
	self assert: turnManager shipInTurn equals: ship2.
	self assert: turnManager nextShip equals: ship2
]
