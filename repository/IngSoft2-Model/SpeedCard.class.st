Class {
	#name : 'SpeedCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
SpeedCard class >> applyTo: aShip [

	aShip receiveSpeedCardEffect
]

{ #category : 'as yet unclassified' }
SpeedCard >> applyTo: aShip using: aShip2 [

	aShip receiveSpeedCardEffect
]
