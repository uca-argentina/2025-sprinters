Class {
	#name : 'HyperSpaceJump',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
HyperSpaceJump >> applyTo: aShip in: aGame [

	aGame move: aShip by: 4.
	aGame damage: aShip
]
