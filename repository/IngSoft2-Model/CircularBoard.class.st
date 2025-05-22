Class {
	#name : 'CircularBoard',
	#superclass : 'Board',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CircularBoard >> verifyPosition: aShip [
	| shipPosition |
	shipPosition := aShip showPosition.
	wormHole ifNotNil: [ ^ wormHole transportIfConnectedTo: aShip showPosition. ].
	(shipPosition > amountOfCells) ifTrue: [ ^ shipPosition \\ amountOfCells ]. 
	^ aShip showPosition .
]
