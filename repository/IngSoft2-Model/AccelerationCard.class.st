Class {
	#name : 'AccelerationCard',
	#superclass : 'PermanentCard',
	#instVars : [
		'linkedShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
AccelerationCard >> applyTo: aShip using: aShip2 in: aGame [

	linkedShips := aGame ships.
	aGame applyAccelerationCardEffect
]

{ #category : 'removing' }
AccelerationCard >> removePermanentEffect [
	linkedShips do: [:ship | ship removeAccelerationCardEffect  ] .
]
