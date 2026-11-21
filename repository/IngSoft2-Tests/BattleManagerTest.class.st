Class {
	#name : 'BattleManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleManagerTest >> test001WhenTwoShipsFightAndShip2WinsThenShip1LoseBatle [

	| aGame |
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 3 3 9 6 );
		         wormHoleBetween: 9 and: 10;
		         build.
	aGame playTurn. "ship 1 cae en 4"
	aGame playTurn. "ship 2 cae en 4 y pelean: ship 2 saca 9, ship 1 saca 6"
	self assert: (aGame shieldsOf: 'ship 1') equals: 2.
	self assert: (aGame positionOf: 'ship 1') equals: 1.
	self assert: (aGame shieldsOf: 'ship 2') equals: 3
]
