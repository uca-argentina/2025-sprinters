Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test000WhenGameStartsThenEachShipHasTwoCards [

	| speedCard redoCard repeatCard accelerationCard aGame |
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	repeatCard := RepeatCard new.
	accelerationCard := AccelerationCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         deck: { speedCard. redoCard. repeatCard. accelerationCard };
		         build.
	self
		assert: (aGame cardsOf: 'ship 1')
		equals: (OrderedCollection with: speedCard with: redoCard).
	self
		assert: (aGame cardsOf: 'ship 2')
		equals: (OrderedCollection with: repeatCard with: accelerationCard)
]

{ #category : 'tests' }
CardTest >> test001WhenUseSpeedCardFromDeckThenApplyItEffect [

	| aGame speedCard |
	speedCard := SpeedCard new.
	aGame := GameBuilder new
		         diceSequence: #( 6 );
		         deck: { speedCard. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: speedCard targeting: 'ship 1'.
	aGame playTurn. "1 + 6 + 1 de la Speed = 8"
	self assert: (aGame positionOf: 'ship 1') equals: 8
]

{ #category : 'tests' }
CardTest >> test002WhenShipWantsToPlayACardThatItDoesNotHaveThenRaiseError [

	| aGame |
	aGame := GameBuilder new
		         deck: { MercenaryCard new. AccelerationCard new };
		         build.
	self
		should: [ aGame ship: 'ship 1' plays: SpeedCard targeting: 'ship 1'. ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Cannot play a card you do not have' ]
]

{ #category : 'tests' }
CardTest >> test003WhenShipUseMercenaryCardWithShip2ThenTheyDoNotBattle [

	| aGame mercenaryCard |
	mercenaryCard := MercenaryCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'mercenary' );
		         diceSequence: #( 6 );
		         deck: { mercenaryCard. SpeedCard new. SpeedCard new. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: mercenaryCard targeting: 'mercenary'.
	aGame playTurn. "ship 1 cae en 7"
	aGame playTurn. "mercenary cae en 7: son aliadas, no pelean"
	self assert: (aGame positionOf: 'ship 1') equals: 7.
	self assert: (aGame positionOf: 'mercenary') equals: 7.
	self assert: (aGame shieldsOf: 'ship 1') equals: 3.
	self assert: (aGame shieldsOf: 'mercenary') equals: 3
]

{ #category : 'tests' }
CardTest >> test004WhenAShipUseSpeedCardThenIsRemovedFromDeckOfShip [

	| aGame speedCard |
	speedCard := SpeedCard new.
	aGame := GameBuilder new
		         deck: { speedCard. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: speedCard targeting: 'ship 1'.
	self assert: (aGame cardsOf: 'ship 1') size equals: 1
]

{ #category : 'tests' }
CardTest >> test005WhenShip1FightToShip3UsingShip2AsMErcenaryThenShip1WinTheBattle [

	| aGame mercenaryCard |
	mercenaryCard := MercenaryCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' 'ship 3' );
		         diceSequence: #( 2 3 2 5 2 4 );
		         wormHoleBetween: 9 and: 10;
		         deck: { mercenaryCard. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: mercenaryCard targeting: 'ship 2'.
	aGame playTurn. "ship 1 cae en 3"
	aGame playTurn. "ship 2 cae en 4"
	aGame playTurn. "ship 3 cae en 3 y pelea: ship 3 saca 5; ship 1 saca 2 + 4 de su mercenaria = 6"
	self assert: (aGame shieldsOf: 'ship 3') equals: 2.
	self assert: (aGame positionOf: 'ship 3') equals: 1.
	self assert: (aGame shieldsOf: 'ship 1') equals: 3.
	self assert: (aGame shieldsOf: 'ship 2') equals: 3.
]

{ #category : 'tests' }
CardTest >> test006WhenShip1FightToShip3UsingShip2AsMErcenaryAndShip3WonThenShip1AndShip2Loss1Shield [

	| aGame mercenaryCard |
	mercenaryCard := MercenaryCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' 'ship 3' );
		         diceSequence: #( 2 3 2 7 2 4 );
		         wormHoleBetween: 9 and: 10;
		         deck: { mercenaryCard. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: mercenaryCard targeting: 'ship 2'.
	aGame playTurn. "ship 1 cae en 3"
	aGame playTurn. "ship 2 cae en 4"
	aGame playTurn. "ship 3 cae en 3 y pelea: ship 3 saca 7; ship 1 saca 2 + 4 de su mercenaria = 6"
	self assert: (aGame shieldsOf: 'ship 1') equals: 2.
	self assert: (aGame shieldsOf: 'ship 2') equals: 2.
	self assert: (aGame shieldsOf: 'ship 3') equals: 3.
]

{ #category : 'tests' }
CardTest >> test007WhenShip3AndShip1WanttheSameShipAsMercenaryThenRaiseError [

	| aGame mercenaryCard1 mercenaryCard2 |
	mercenaryCard1 := MercenaryCard new.
	mercenaryCard2 := MercenaryCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' 'ship 3' );
		         diceSequence: #( 1 2 );
		         wormHoleBetween: 9 and: 10;
		         deck: { mercenaryCard1. SpeedCard new. SpeedCard new. SpeedCard new. mercenaryCard2. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: mercenaryCard1 targeting: 'ship 2'.
	aGame playTurn. "ship 1 cae en 2"
	aGame playTurn. "ship 2 cae en 4"
	self
		should: [ aGame ship: 'ship 3' plays: mercenaryCard2 targeting: 'ship 2' ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'You can not use this ship as a mercenary' ]
]

{ #category : 'tests' }
CardTest >> test008WhenUseAccelerationCardThenAllThrowsIncrementsBy1 [

	| aGame accelerationCard |
	accelerationCard := AccelerationCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' 'ship 3' );
		         diceSequence: #( 1 2 3 );
		         wormHoleBetween: 9 and: 10;
		         deck: { accelerationCard. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: accelerationCard.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame positionOf: 'ship 1') equals: 3.
	self assert: (aGame positionOf: 'ship 2') equals: 4.
	self assert: (aGame positionOf: 'ship 3') equals: 5
]

{ #category : 'tests' }
CardTest >> test009WhenUseCancellationCardThenRemoveSpeedCard [

	| aGame speedCard cancellationCard |
	speedCard := SpeedCard new.
	cancellationCard := CancellationCard new.
	aGame := GameBuilder new
		         diceSequence: #( 3 );
		         wormHoleBetween: 9 and: 10;
		         deck: { speedCard. cancellationCard };
		         build.
	aGame ship: 'ship 1' plays: speedCard targeting: 'ship 1'.
	aGame ship: 'ship 1' plays: cancellationCard targeting: aGame activeCards first.
	aGame playTurn. "1 + 3, sin el +1 de la Speed cancelada"
	self assert: (aGame positionOf: 'ship 1') equals: 4
]

{ #category : 'tests' }
CardTest >> test010WhenUseCancellationCardWithAccelerationThenRemoveAcceleration [

	| aGame accelerationCard cancellationCard |
	accelerationCard := AccelerationCard new.
	cancellationCard := CancellationCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 1 3 );
		         wormHoleBetween: 9 and: 10;
		         deck: { accelerationCard. cancellationCard. AccelerationCard new. AccelerationCard new };
		         build.
	aGame ship: 'ship 1' plays: accelerationCard.
	aGame playTurn. "ship 1: 1 + 1 + 1 de la Acceleration = 3"
	aGame ship: 'ship 1' plays: cancellationCard targeting: aGame activeCards first.
	aGame playTurn. "ship 2: 1 + 3, ya sin Acceleration = 4"
	self assert: (aGame positionOf: 'ship 1') equals: 3.
	self assert: (aGame positionOf: 'ship 2') equals: 4
]

{ #category : 'tests' }
CardTest >> test011WhenUseCancellationCardWithMercenaryThenRemoveMercenary [

	| aGame mercenaryCard cancellationCard |
	mercenaryCard := MercenaryCard new.
	cancellationCard := CancellationCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' 'ship 3' );
		         diceSequence: #( 2 1 2 5 3 );
		         wormHoleBetween: 9 and: 10;
		         deck: { mercenaryCard. AccelerationCard new. cancellationCard. AccelerationCard new. AccelerationCard new. AccelerationCard new };
		         build.
	aGame ship: 'ship 1' plays: mercenaryCard targeting: 'ship 3'.
	aGame ship: 'ship 2' plays: cancellationCard targeting: aGame activeCards first.
	aGame playTurn. "ship 1 cae en 3"
	aGame playTurn. "ship 2 cae en 2"
	aGame playTurn. "ship 3 cae en 3: ya no son aliadas, pelean 5 contra 3"
	self assert: (aGame shieldsOf: 'ship 1') equals: 2.
	self assert: (aGame positionOf: 'ship 1') equals: 1.
	self assert: (aGame shieldsOf: 'ship 3') equals: 3
]

{ #category : 'tests' }
CardTest >> test012WhenUseCancellationCardAndNoActiveCardsThenRaiseError [

	| aGame cancellationCard |
	cancellationCard := CancellationCard new.
	aGame := GameBuilder new
		         deck: { SpeedCard new. cancellationCard };
		         build.
	self
		should: [ aGame ship: 'ship 1' plays: cancellationCard ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Cannot play cancellation card with no active permanent cards' ]
]

{ #category : 'tests' }
CardTest >> test013WhenUseREDOCardThenItTakesTheEffectOfTheLastCardUsed [

	| aGame accelerationCard redoCard |
	accelerationCard := AccelerationCard new.
	redoCard := RedoCard new.
	aGame := GameBuilder new
		         diceSequence: #( 3 );
		         deck: { accelerationCard. redoCard };
		         build.
	aGame ship: 'ship 1' plays: accelerationCard.
	aGame ship: 'ship 1' plays: redoCard.
	aGame playTurn. "1 + 3 + 2 (Acceleration + su Redo) = 6"
	self assert: (aGame positionOf: 'ship 1') equals: 6
]

{ #category : 'tests' }
CardTest >> test014WhenUseRepeatCardBeforePlayingThenItDoesNotApplyTheLastEffectOnGame [

	| aGame repeatCard |
	repeatCard := RepeatCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         allCellsWith: HyperSpaceJump new;
		         deck: { AccelerationCard new. repeatCard. SpeedCard new. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: repeatCard targeting: 'ship 2'.
	self assert: (aGame positionOf: 'ship 2') equals: 1.
	self assert: (aGame shieldsOf: 'ship 2') equals: 3
]

{ #category : 'tests' }
CardTest >> test015WhenUseRepeatCardThenItApplyTheLastEffectOnGame [

	| aGame repeatCard |
	repeatCard := RepeatCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 6 7 );
		         allCellsWith: BlackHole new;
		         wormHoleBetween: 9 and: 10;
		         deck: { AccelerationCard new. repeatCard. SpeedCard new. SpeedCard new };
		         build.
	aGame playTurn. "ship 1: cae en 7, el BlackHole lo lleva a 3"
	aGame playTurn. "ship 2: cae en 8, el BlackHole lo lleva a 4"
	aGame ship: 'ship 1' plays: repeatCard targeting: 'ship 2'. "otro BlackHole a ship 2: de 4 a 1"
	self assert: (aGame positionOf: 'ship 2') equals: 1
]

{ #category : 'tests' }
CardTest >> test016WhenUseRepeatCardButThereIsNoEffectThenItDoesNotApplyTheLastEffectOnGame [

	| aGame repeatCard |
	repeatCard := RepeatCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 3 7 );
		         wormHoleBetween: 9 and: 10;
		         deck: { AccelerationCard new. repeatCard. SpeedCard new. SpeedCard new };
		         build.
	aGame playTurn. "ship 1 cae en 4"
	aGame playTurn. "ship 2 cae en 8"
	aGame ship: 'ship 1' plays: repeatCard targeting: 'ship 2'.
	self assert: (aGame positionOf: 'ship 2') equals: 8
]

{ #category : 'tests' }
CardTest >> test017WhenTheShipMovesThrowTheBoardAndITACrdGiverCellThenShipRecieveOneCard [

	| aGame |
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 3 );
		         allCellsWith: CardGiver new;
		         wormHoleBetween: 9 and: 10;
		         deck: { RepeatCard new. AccelerationCard new. SpeedCard new. SpeedCard new. SpeedCard new };
		         build.
	aGame playTurn. "ship 1 cae en 4 (CardGiver) y recibe la 5ta carta del mazo"
	self assert: (aGame cardsOf: 'ship 1') size equals: 3
]

{ #category : 'tests' }
CardTest >> test018WhenShipUseRepeatCardAndLastEffectWasACardGiverThenTheChosenShipReceivesACard [

	| aGame repeatCard |
	repeatCard := RepeatCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 3 );
		         allCellsWith: CardGiver new;
		         wormHoleBetween: 9 and: 10;
		         deck: { repeatCard. RedoCard new. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new };
		         build.
	aGame playTurn. "ship 1 cae en 4 (CardGiver) y recibe la 5ta carta del mazo"
	aGame ship: 'ship 1' plays: repeatCard targeting: 'ship 2'. "se repite el CardGiver: ship 2 recibe la 6ta"
	self assert: (aGame cardsOf: 'ship 2') size equals: 3
]

{ #category : 'tests' }
CardTest >> test019WhenShipFightToAnotherShipButHasBonusThrowThenItCanWin [

	| aGame speedCard |
	speedCard := SpeedCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 3 );
		         wormHoleBetween: 9 and: 10;
		         deck: { RedoCard new. SpeedCard new. speedCard. SpeedCard new };
		         build.
	aGame playTurn. "ship 1 cae en 4"
	aGame ship: 'ship 2' plays: speedCard targeting: 'ship 1'. "es el turno de ship 2: le da +1 a ship 1"
	aGame playTurn. "ship 2 cae en 4 y pelea: ship 2 saca 3; ship 1 saca 3 + 1 = 4"
	self assert: (aGame shieldsOf: 'ship 2') equals: 2.
	self assert: (aGame shieldsOf: 'ship 1') equals: 3
]

{ #category : 'tests' }
CardTest >> test020WhenModifyingTheCardsOfAShipFromOutsideThenItsHandDoesNotChange [

	| aGame |
	aGame := GameBuilder new
		         deck: { SpeedCard new. RedoCard new };
		         build.
	(aGame cardsOf: 'ship 1') removeAll.
	self assert: (aGame cardsOf: 'ship 1') size equals: 2
]

{ #category : 'tests' }
CardTest >> test021WhenAMercenaryHasASpeedCardThenItsBonusCountsInTheBattle [

	| mercenaryCard speedCard aGame |
	mercenaryCard := MercenaryCard new.
	speedCard := SpeedCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' 'ship 3' );
		         diceSequence: #( 2 3 2 7 2 5 9 1 1 );
		         wormHoleBetween: 9 and: 10;
		         deck: { mercenaryCard. speedCard. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: mercenaryCard targeting: 'ship 2'.
	aGame ship: 'ship 1' plays: speedCard targeting: 'ship 2'.
	aGame playTurn. "ship 1 cae en 3"
	aGame playTurn. "ship 2 saca 3 + 1 de la Speed: cae en 5"
	aGame playTurn. "ship 3 cae en 3 y pelea: ship 3 saca 7; ship 1 saca 2 + su mercenaria 5 + 1 = 8"
	self assert: (aGame shieldsOf: 'ship 1') equals: 3.
	self assert: (aGame shieldsOf: 'ship 3') equals: 2
]

{ #category : 'tests' }
CardTest >> test022WhenRedoReplaysAPermanentCardThenCancellingTheOriginalKeepsTheRedoOne [

	| speedCard redoCard cancellationCard aGame |
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	cancellationCard := CancellationCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 3 );
		         deck: { speedCard. redoCard. cancellationCard. SpeedCard new };
		         build.
	aGame ship: 'ship 1' plays: speedCard targeting: 'ship 1'.
	aGame ship: 'ship 1' plays: redoCard targeting: 'ship 1'. "dos Speed activas sobre ship 1"
	aGame ship: 'ship 2' plays: cancellationCard targeting: aGame activeCards first.
	aGame playTurn. "1 + 3 + 1 de la Speed que queda = 5"
	self assert: (aGame positionOf: 'ship 1') equals: 5
]

{ #category : 'tests' }
CardTest >> test023WhenShipPlaysAPermanentCardOutOfItsTurnThenRaiseError [

	| speedCard aGame |
	speedCard := SpeedCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         deck: { SpeedCard new. SpeedCard new. speedCard. SpeedCard new };
		         build.
	self
		should: [ aGame ship: 'ship 2' plays: speedCard targeting: 'ship 2' ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Permanent cards can only be played during your turn' ]
]

{ #category : 'tests' }
CardTest >> test024WhenTheLastEffectWasACardGiverAfterABlackHoleThenRepeatAppliesTheCardGiver [

	| effects repeatCard aGame |
	effects := (1 to: 10) collect: [ :cell | NoEffect new ].
	effects at: 7 put: BlackHole new.
	effects at: 4 put: CardGiver new.
	repeatCard := RepeatCard new.
	aGame := GameBuilder new
		         shipsNamed: #( 'ship 1' 'ship 2' );
		         diceSequence: #( 6 3 );
		         effects: effects;
		         wormHoleBetween: 9 and: 10;
		         deck: { repeatCard. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new. SpeedCard new };
		         build.
	aGame playTurn. "ship 1: cae en 7 (BlackHole) -> 3"
	aGame playTurn. "ship 2: cae en 4 (CardGiver) y recibe una carta"
	aGame ship: 'ship 1' plays: repeatCard targeting: 'ship 1'.
	self assert: (aGame positionOf: 'ship 1') equals: 3.
	self assert: (aGame cardsOf: 'ship 1') size equals: 2
]
