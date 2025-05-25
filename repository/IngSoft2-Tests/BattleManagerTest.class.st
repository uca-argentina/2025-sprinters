Class {
	#name : 'BattleManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleManagerTest >> test001WhenTwoShipsFightAndShip2WinsThenShip1LoseBatle [

	| ships dices1 aDice1 aDiceBucket1 dices2 aDice2 aDiceBucket2 amountOfCells  ship1 ship2 battleManager |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice1 := LoadedDice with: 6.
	dices1 add: aDice1.
	aDiceBucket1 := DiceBucket with: dices1.
	dices2 := OrderedCollection new.
	aDice2 := LoadedDice with: 9.
	dices2 add: aDice2.
	aDiceBucket2 := DiceBucket with: dices2.
	amountOfCells := 10.
	ship1:= Ship create: 'ship 1' with: aDiceBucket1.
	ship2:= Ship  create: 'ship 2' with: aDiceBucket2.
	battleManager := BattleManager new.
	battleManager fightBetween: ship1 and: ship2.
	self assert: ship1 showPosition equals: 0
]
