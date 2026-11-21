Class {
	#name : 'GameStateTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameStateTest >> test007WhenGameIsFinishedAndAskForWinnerThenReturnWinner [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 10 );
		         build.
	aGame play.
	self assert: aGame winner equals: 'ship 1'
]

{ #category : 'tests' }
GameStateTest >> test008WhenGameIsNotPlayedAndAskForWinnerThenRaiseError [

	| aGame |
	aGame := GameBuilder new build.
	self
		should: [ aGame winner ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'The game is not finished, so it hasn´t a winner yet' ]
]

{ #category : 'tests' }
GameStateTest >> test009WhenGamePlaysOneTurnThenOnlyTheShipInTurnMoves [

	| aGame |
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 5 );
		         build.
	aGame playTurn.
	self assert: (aGame positionOf: 'ship 1') equals: 6.
	self assert: (aGame positionOf: 'ship 2') equals: 1
]

{ #category : 'tests' }
GameStateTest >> test010WhenGameHasFinishedThenPlayAgainRaiseError [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 10 );
		         build.
	aGame play.
	self
		should: [ aGame play ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'The game has already been played, you can not play any more.' ]
]

{ #category : 'tests' }
GameStateTest >> test011WhenGameHasFinishedThenPlayTurnRaiseError [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 10 );
		         build.
	aGame play.
	self
		should: [ aGame playTurn ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'The game has already been played, you can not play any more.' ]
]

{ #category : 'tests' }
GameStateTest >> test012WhenGameHasFinishedThenCardsCanNotBePlayed [

	| aGame speedCard |
	speedCard := SpeedCard new.
	aGame := GameBuilder new
		         diceSequence: #( 10 );
		         deck: { speedCard. SpeedCard new };
		         build.
	aGame play.
	self
		should: [ aGame ship: 'ship 1' plays: speedCard targeting: 'ship 1'. ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Cards can not be played once the game has finished' ]
]

{ #category : 'tests' }
GameStateTest >> test013WhenGameHasFinishedThenSkipTurnRaiseError [

	| aGame |
	aGame := GameBuilder new
		         diceSequence: #( 10 );
		         build.
	aGame play.
	self
		should: [ aGame skipTurn ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'The game has already been played, you can not play any more.' ]
]
