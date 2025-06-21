Class {
	#name : 'BattleManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleManagerTest >> test001WhenTwoShipsFightAndShip2WinsThenShip1LoseBatle [

	| ships dices1 aDice1 aDiceBucket1 amountOfCells ship1 ship2 battleManager |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice1 := LoadedDice withSequence: #( 6 9 ).
	dices1 add: aDice1.
	aDiceBucket1 := DiceBucket with: dices1.
	amountOfCells := 10.
	ship1 := Ship create: 'ship 1'.
	ship2 := Ship create: 'ship 2'.
	battleManager := BattleManager with: aDiceBucket1.
	battleManager fightBetween: ship1 and: ship2.
	self assert: ship1 position equals: 1
]
