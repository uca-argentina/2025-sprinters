Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'positionOfEffect',
		'cellClass'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Cell class >> with: anEffect [

	^ self new initializeWith: anEffect
]

{ #category : 'playing' }
Cell >> effect [
	^ cellClass.
]

{ #category : 'playing' }
Cell >> effect: aCellClass [ 
	cellClass := aCellClass.
]

{ #category : 'playing' }
Cell >> effectOnMovement [
	^ cellClass effectOnMovement
]

{ #category : 'initialization' }
Cell >> initializeWith: aCellClass [

	cellClass := aCellClass
]

{ #category : 'accessing' }
Cell >> position: anInteger [ 
	positionOfEffect := anInteger.
]
