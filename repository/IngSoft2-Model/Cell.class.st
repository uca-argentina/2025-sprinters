Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'effect'
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

	^ effect
]

{ #category : 'initialization' }
Cell >> initializeWith: anEffect [

	effect := anEffect
]
