Class {
	#name : 'FixGame',
	#superclass : 'Game',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
FixGame class >> with: aCircularBoard using: aLoadedDice andShipsNamed: aCollection until: anInteger [

	^ self new 
		  initializeWith: aCircularBoard
		  using: aLoadedDice
		  andShips: aCollection
		  until: anInteger
]

{ #category : 'initialization' }
FixGame >> initializeWith: aCircularBoard using: aDiceBucket andShips: shipsList until: numberOfLaps [

	board := aCircularBoard with:numberOfLaps .
	ships := shipsList.
	status := NotPlayed new.
	turnManager:= TurnManager with:ships.
	battleManager :=BattleManager .
	
]

{ #category : 'initialization' }
FixGame >> initializeWith: aCircularBoard using: aDiceBucket andShipsNamed: shipsList until: numberOfLaps [

	board := aCircularBoard with:numberOfLaps .
	ships := shipsList.
	status := NotPlayed new.
	turnManager:= TurnManager with:ships.
	battleManager :=BattleManager .
	
]
