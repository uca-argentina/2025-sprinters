Class {
	#name : 'GameStateTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameStateTest >> test000WhenGameIsNotPlayedThenPlayingStateIsFalse [

	| gameState |
	gameState := Started new.
	 self assert: gameState isFinished equals: false
]

{ #category : 'tests' }
GameStateTest >> test001WhenGameIsNotPlayedThenFinishedStateIsFalse [

	| gameState |
	gameState := NotPlayed new.
	 self assert: gameState isFinished equals: false
]

{ #category : 'tests' }
GameStateTest >> test002WhenGameIsStartedThenPlayingdStateIsTrue [

	| gameState |
	gameState := Started new.
	self assert: gameState isFinished equals: false
]

{ #category : 'tests' }
GameStateTest >> test003WhenGameIsStartedThenFinishedStateIsFalse [

	| gameState |
	gameState := Started new.
	self assert: gameState isFinished equals: false
]

{ #category : 'tests' }
GameStateTest >> test004WhenGameIsFinishedThenFinishedStateIsTrue [

	| gameState |
	gameState := Finished new.
	self assert: gameState isFinished equals: true
]

{ #category : 'tests' }
GameStateTest >> test005WhenGameIsFinishedThenPlayingStateIsFalse [

	| gameState |
	gameState := Finished new.
	self assert: gameState isFinished equals: true
]

{ #category : 'tests' }
GameStateTest >> test006WhenGameIsStartedAndAskForWinnerThenRaiseError [

	| gameState listOfShips shipOne listOfDices aDice aDiceBucket amountOfCells aWorm aBoard aGame distributions |
	listOfShips := OrderedCollection new.
	shipOne := 'Ship 1'.
	listOfDices := OrderedCollection new.
	listOfShips add: shipOne.
	aDice := Dice with: 5.
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: listOfShips.
	gameState := Started new.
	self
		should: [ gameState showWinner: aGame ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'The game is not finished, so it hasn´t a winner yet' ]
]

{ #category : 'tests' }
GameStateTest >> test007WhenGameIsFinishedAndAskForWinnerThenReturnWinner [

	| listOfShips shipOne listOfDices aDice aDiceBucket amountOfCells aWorm aBoard aGame distributions |
	listOfShips := OrderedCollection new.
	shipOne := 'Ship 1'.
	listOfDices := OrderedCollection new.
	listOfShips add: shipOne.
	aDice := LoadedDice withSequence: #( 10 ).
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: listOfShips.
	aGame play.
	self assert: aGame showWinner name equals: shipOne
]

{ #category : 'tests' }
GameStateTest >> test008WhenGameIsNotPlayedAndAskForWinnerThenRaiseError [

	| gameState listOfShips shipOne listOfDices aDice aDiceBucket amountOfCells aWorm aBoard aGame distributions |
	listOfShips := OrderedCollection new.
	shipOne := 'Ship 1'.
	listOfDices := OrderedCollection new.
	listOfShips add: shipOne.
	aDice := Dice with: 5.
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: listOfShips.
	gameState := NotPlayed new.

	self
		should: [ gameState showWinner: aGame ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'The game has not started, it does not have a winner yet' ]
]

{ #category : 'tests' }
GameStateTest >> test009WhenGamePlayOneTurnAndTwoShipsInSamePositionThenOneChangeItPosition [

	| listOfShips listOfDices aDice aDiceBucket amountOfCells aWorm aBoard aGame ship1 ship2 distributions |
	listOfShips := OrderedCollection new.
	listOfDices := OrderedCollection new.
	listOfShips add: 'Ship 1'.
	listOfShips add: 'Ship 2'.
	aDice := Dice with: 5.
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          andTotalParsec: 20.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: listOfShips.
	aGame playTurn.
	ship1:=aGame ships at:1.
	ship2:=aGame ships at:2.
	
	self deny: (ship1 position) equals: (ship2 position)
]
