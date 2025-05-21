Class {
	#name : 'GameStateTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameStateTest >> test000WhenGameIsNotPlayedThenPlayingStateIsFalse [

	| gameState |
	gameState := NotPlayed new.
	 self assert: gameState isPlaying equals: false
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
	self assert: gameState isPlaying equals: true
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
	self assert: gameState isPlaying equals: false
]

{ #category : 'tests' }
GameStateTest >> test006WhenGameIsStartedAndAskForWinnerThenRaiseError [

	| gameState |
	gameState := Started new.
	self
		should: [ gameState showWinner ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'The game is not finished, so it hasn´t a winner yet' ]
]

{ #category : 'tests' }
GameStateTest >> test007WhenGameIsFinishedAndAskForWinnerThenReturnWinner [

	| gameState listOfShips shipOne listOfDices aDice aDiceBucket amountOfCells aWorm aBoard aGame |
	listOfShips := OrderedCollection new.
	shipOne := 'Ship 1'.
	listOfDices := OrderedCollection new.
	listOfShips add: shipOne.
	aDice := Dice with: 5.
	listOfDices add: aDice.
	aDiceBucket := DiceBucket with: listOfDices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board with: amountOfCells and: aWorm.
	aGame := Game with: aBoard using: aDiceBucket andShipsNamed: listOfShips.

	gameState := Finished new.
	self assert: (gameState showWinner: aGame) showName equals: shipOne
]
