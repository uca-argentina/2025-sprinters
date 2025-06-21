Class {
	#name : 'CardGiverTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardGiverTest >> test001WhenCreateAGameThenDeckOfCardsOfShipIsTwo [

	| aGame ships dices aDice aDiceBucket amountOfCells aWorm distributions aBoard laps cards aCardDeck |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 5 3 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperSpaceJump with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	laps := 3.
	ships add: 'ship 1'.
	cards := OrderedCollection new.
	cards add: InstantCard new.
	cards add: PermanentCard new.
	aCardDeck := CardDeck withDeck: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: laps
		         and: aCardDeck.
	self assert: (aGame ships at: 1) cards size equals: 2
]
