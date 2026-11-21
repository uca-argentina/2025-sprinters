Class {
	#name : 'ActiveSpeed',
	#superclass : 'ActiveCard',
	#instVars : [
		'target'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ActiveSpeed class >> on: aShip [

	^ self new initializeOn: aShip
]

{ #category : 'querying' }
ActiveSpeed >> bonusFor: aShip [

	^ aShip == target
		  ifTrue: [ 1 ]
		  ifFalse: [ 0 ]
]

{ #category : 'initialization' }
ActiveSpeed >> initializeOn: aShip [

	target := aShip
]
