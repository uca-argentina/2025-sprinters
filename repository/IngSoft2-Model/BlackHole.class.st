Class {
	#name : 'BlackHole',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
BlackHole >> applyTo: aShip in: aGame [

	aGame move: aShip by: -4
]
