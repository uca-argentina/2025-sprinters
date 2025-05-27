Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperSpaceJump >> applyTo: aShip in: aGame [

	aShip move: 4 in: aGame board.
	aShip loseShield
]

{ #category : 'as yet unclassified' }
HyperSpaceJump >> showName [

	^ 'Hyper Space Jump'
]
