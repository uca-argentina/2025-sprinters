Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'amountOfCells',
		'laps',
		'cells',
		'distance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Board class >> withEffects: effects wormHole: aWorm laps: anAmountOfLaps length: aDistance [

	effects ifEmpty: [
		^ Error signal: 'Amount of cells must be greater than zero' ].
	(aWorm isInside: effects size) ifFalse: [
		^ Error signal:
			  'Position of the worm hole exceed amount board`s cells' ].
	^ self new
		  initializeWithEffects: effects
		  wormHole: aWorm
		  laps: anAmountOfLaps
		  length: aDistance
]

{ #category : 'accessing' }
Board >> amountOfCells [

	^ amountOfCells
]

{ #category : 'converting' }
Board >> cellsIn: aDistance [

	^ (aDistance parsecs / self parsecsPerCell) ceiling
]

{ #category : 'playing' }
Board >> effectOnPosition: position [

	^ (cells at: position) effect
]

{ #category : 'accessing' }
Board >> indexOf: aLocation [

	^ aLocation lap - 1 * amountOfCells + aLocation cell
]

{ #category : 'initialization' }
Board >> initializeWithEffects: effects wormHole: aWorm laps: anAmountOfLaps length: aDistance [

	| effectsWithWormHole |
	effectsWithWormHole := effects asArray copy.
	aWorm positions do: [ :position |
		effectsWithWormHole at: position put: aWorm ].
	cells := effectsWithWormHole collect: [ :effect | Cell with: effect ].
	amountOfCells := cells size.
	laps := anAmountOfLaps.
	distance := aDistance
]

{ #category : 'testing' }
Board >> isTheFinish: aLocation [

	^ (self indexOf: aLocation) = self lastIndex
]

{ #category : 'accessing' }
Board >> lastIndex [

	^ laps * amountOfCells
]

{ #category : 'accessing' }
Board >> locationAt: anIndex [

	| index |
	index := (anIndex max: 1) min: self lastIndex.
	^ Location
		  cell: index - 1 \\ amountOfCells + 1
		  lap: index - 1 // amountOfCells + 1
]

{ #category : 'moving' }
Board >> move: aShip by: anAmountOfCells [

	aShip moveTo:
		(self locationAt: (self indexOf: aShip location) + anAmountOfCells)
]

{ #category : 'moving' }
Board >> moveToStart: aShip [

	aShip moveTo: aShip location atStart
]

{ #category : 'convertion' }
Board >> parsecsPerCell [

	^ distance parsecs / amountOfCells
]

{ #category : 'moving' }
Board >> teleport: aShip to: aCell [

	aShip moveTo: (Location cell: aCell lap: aShip laps)
]
