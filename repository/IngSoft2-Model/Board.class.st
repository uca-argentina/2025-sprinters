Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'amountOfCells',
		'wormHole',
		'laps',
		'cells',
		'totalParsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> with: aAmountOfCells and: aWormHole has: aDistribution andTotalParsec: parsecs [

	aAmountOfCells isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	aAmountOfCells < 1 ifTrue: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	(aWormHole isInside: aAmountOfCells) ifFalse: [
		^ Error signal:
			  'Position of the worm hole exceed amount board`s cells' ].
	^ self new
		  initializeWith: aAmountOfCells
		  and: aWormHole
		  has: aDistribution
		  andTotalParsec: parsecs
]

{ #category : 'as yet unclassified' }
Board >> amountOfBlackHoleCells [

	^ self amountOfCellsOf: 'BlackHole'.
]

{ #category : 'accessing' }
Board >> amountOfCells [

	^ amountOfCells
]

{ #category : 'as yet unclassified' }
Board >> amountOfCellsOf: anEffectOrClass [

	| count effect classEffect |
	count := 0.
	cells do: [ :cell |
		effect := cell effect.
		classEffect := effect className.
		classEffect = anEffectOrClass ifTrue: [ count := count + 1 ] ].
	^ count
]

{ #category : 'as yet unclassified' }
Board >> amountOfNoEffectCells [

	^ self amountOfCellsOf: 'NoEffect class'
]

{ #category : 'as yet unclassified' }
Board >> effectOnPosition: position [

	| cell effect |
	cell := cells at: position.
	effect := cell effect value.
	^ effect
]

{ #category : 'initialization' }
Board >> initializeWith: aAmountOfCells and: aWormHole has: distributions andTotalParsec: parsecs [

	| cell effects aDistributor effectsOnCells |
	amountOfCells := aAmountOfCells.
	wormHole := aWormHole.
	laps := 1.
	totalParsecs := parsecs.
	aDistributor := EffectDistributor
		                withDistribution: distributions
		                on: aAmountOfCells.

	effectsOnCells := aDistributor recieveAmountOfEffects.
	cells := OrderedCollection new.
	1 to: amountOfCells do: [ :i |
		cell := Cell new.
		cell position: i.
		cell effect: (effectsOnCells at: i).
		cells add: cell ]
]

{ #category : 'accessing' }
Board >> laps [

	^ laps
]

{ #category : 'as yet unclassified' }
Board >> moveThrowTheLaps: currentLap this: position [

	^ currentLap + (position // amountOfCells)
]

{ #category : 'as yet unclassified' }
Board >> parsecsPerCell [

	^ totalParsecs // amountOfCells
]

{ #category : 'as yet unclassified' }
Board >> sendValidPosition: newPosition [

	| position |
	position := newPosition <= 0
		            ifTrue: [ 1 ]
		            ifFalse: [
			            laps > 1
				            ifTrue: [ newPosition \\ amountOfCells ]
				            ifFalse: [
					            newPosition <= 0 ifTrue: [ 1 ].
					            newPosition min: amountOfCells ] ].
	position := self verifyPosition: position.
	^ position
]

{ #category : 'as yet unclassified' }
Board >> specialCells [

	^ wormHole positions: self
]

{ #category : 'as yet unclassified' }
Board >> verifyPosition: aShip [

	| shipPosition |
	shipPosition := aShip position.
	wormHole ifNotNil: [
		^ wormHole transportIfConnectedTo: aShip position ].
	^ shipPosition   
]

{ #category : 'instance creation' }
Board >> with: aNumberOfLaps [

	laps := aNumberOfLaps
]
