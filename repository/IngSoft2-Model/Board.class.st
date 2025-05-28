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

{ #category : 'instance creation' }
Board class >> with: aAmountOfCells [

	aAmountOfCells isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	aAmountOfCells < 1 ifTrue: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	nil.
	^ self new initializeWith: aAmountOfCells
]

{ #category : 'as yet unclassified' }
Board class >> with: aAmountOfCells and: aWormHole [ 

	aAmountOfCells isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	aAmountOfCells < 1 ifTrue: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	(aWormHole isInside: aAmountOfCells) ifFalse: [
		^ Error signal:
			  'Position of the worm hole exceed amount board`s cells' ].
	^ self new initializeWith: aAmountOfCells and: aWormHole
]

{ #category : 'as yet unclassified' }
Board class >> with: aAmountOfCells and: aWormHole has: aDistribution [

	aAmountOfCells isInteger ifFalse: [
		^ Error signal: 'Amount of cells must be an integer' ].
	aAmountOfCells < 1 ifTrue: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	(aWormHole isInside: aAmountOfCells) ifFalse: [
		^ Error signal:
			  'Position of the worm hole exceed amount board`s cells' ].
	^ self new initializeWith: aAmountOfCells and: aWormHole has: aDistribution.
]

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

{ #category : 'as yet unclassified' }
Board >> amountOfCellsOf: anEffectOrClass [

	| count |
	count := 0.
	cells do: [ :cell |
		(cell effect className= anEffectOrClass) ifTrue: [
			count := count + 1 ] ].
	^ count
]

{ #category : 'as yet unclassified' }
Board >> amountOfNoEffectCells [
	^ self amountOfCellsOf: 'NoEffect'.
]

{ #category : 'as yet unclassified' }
Board >> effectOnPosition: position [
	^ (cells at: position) effect
]

{ #category : 'initialization' }
Board >> initializeWith: cells [

	amountOfCells := cells.
	laps := 1
]

{ #category : 'initialization' }
Board >> initializeWith: aAmountOfCells and: aWormHole [
	amountOfCells := aAmountOfCells.
	wormHole := aWormHole.
	laps:=1.
]

{ #category : 'initialization' }
Board >> initializeWith: aAmountOfCells and: aWormHole has: distributions [

	| cell effects |
	amountOfCells := aAmountOfCells.
	wormHole := aWormHole.
	laps := 1.

	effects := OrderedCollection new.

	"Asignar cantidades exactas"
	distributions do: [ :dist |
		(dist probability * amountOfCells) asInteger timesRepeat: [
			effects add: dist cellClass ] ].
	
	(effects size = amountOfCells) ifFalse:[(amountOfCells - effects size) timesRepeat: [effects add: NoEffect initializeThis]].

	effects := effects shuffle.
	"Crear celdas"
	cells := OrderedCollection new.
	1 to: amountOfCells do: [ :i |
		cell := Cell new.
		cell position: i.
		cell effect: (effects at: i).
		cells add: cell ]
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

{ #category : 'as yet unclassified' }
Board >> parsecsPerCell [

	^ totalParsecs // amountOfCells
]

{ #category : 'as yet unclassified' }
Board >> showCells [

	^ amountOfCells
]

{ #category : 'as yet unclassified' }
Board >> showLaps [

	^ laps
]

{ #category : 'as yet unclassified' }
Board >> showSpecialCells [

	^ wormHole showPositions: self
]

{ #category : 'as yet unclassified' }
Board >> verifyPosition: aShip [

	| shipPosition |
	shipPosition := aShip showPosition.
	wormHole ifNotNil: [
		^ wormHole transportIfConnectedTo: aShip showPosition ].
	^ shipPosition   
]

{ #category : 'instance creation' }
Board >> with: aNumberOfLaps [

	laps := aNumberOfLaps
]
