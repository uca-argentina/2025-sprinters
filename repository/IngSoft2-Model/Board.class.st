Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'amountOfCells',
		'wormHole',
		'laps',
		'cells',
		'totalParsecs',
		'distance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> with: aAmountOfCells and: aWormHole has: aDistribution basedOn: aDistance [

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
		  basedOn: aDistance
]

{ #category : 'accessing' }
Board >> amountOfCells [

	^ amountOfCells
]

{ #category : 'as yet unclassified' }
Board >> amountOfCellsOf: anEffectOrClass [

	^ cells count: [ :cell | cell effect className = anEffectOrClass ]
]

{ #category : 'accessing' }
Board >> cells [

	^ cells
]

{ #category : 'as yet unclassified' }
Board >> effectOnPosition: position [

	^ (cells at: position) effect value
]

{ #category : 'initialization' }
Board >> initializeWith: aAmountOfCells and: aWormHole has: distributions basedOn: aDistance [

	| cell aDistributor effectsOnCells |
	amountOfCells := aAmountOfCells.
	wormHole := aWormHole.
	laps := 1.
	distance := aDistance.
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
Board >> lightYearsPerCell [
	^ (self parsecsPerCell) * 3.
]

{ #category : 'as yet unclassified' }
Board >> move: distance at: lap having: parsecs [

	| position currentParsec newParsecPos newPosition currentLap |
	"escenario  --> 7 parsecs y 5 celas --> 1.4 parsecs/celd"
	currentParsec := distance * self parsecsPerCell. " 2 * 1.4 = 2.8 parsecs"
	newParsecPos := currentParsec + parsecs. " 8 parsecs´+ 2.8 parsec = 10.8 parsecs"
	newPosition := newParsecPos // self parsecsPerCell. " (10.8 parsecs / (1.4 parsec/celda ) = 1 celdas "
	currentLap := self moveThrowTheLaps: lap this: newPosition.
	position := newPosition <= 0
		            ifTrue: [ 1 ]
		            ifFalse: [
			            laps > 1
				            ifTrue: [ newPosition \\ amountOfCells ]
				            ifFalse: [
					            newPosition <= 0 ifTrue: [ 1 ].
					            newPosition min: amountOfCells ] ].
	^ {position. currentLap.}.
]

{ #category : 'as yet unclassified' }
Board >> moveThrowTheLaps: currentLap this: position [

	^ currentLap + (position // amountOfCells)
]

{ #category : 'as yet unclassified' }
Board >> parsecsPerCell [

	^ (distance parsecs) // amountOfCells
]

{ #category : 'as yet unclassified' }
Board >> specialCells [

	^ wormHole positions: self
]

{ #category : 'as yet unclassified' }
Board >> verifyPosition: position [

	| newPosition |
	newPosition := position.
	wormHole ifNotNil: [
		newPosition := wormHole transportIfConnectedTo: position ].
	^ newPosition
]

{ #category : 'instance creation' }
Board >> with: aNumberOfLaps [

	laps := aNumberOfLaps
]
