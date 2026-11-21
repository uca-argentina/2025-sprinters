Class {
	#name : 'AccelerationCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
AccelerationCard >> activeCardBy: aShip targeting: aTarget in: aGame [

	^ ActiveAcceleration new
]
