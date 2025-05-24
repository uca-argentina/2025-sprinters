Class {
	#name : 'LazyShip',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
LazyShip class >> create: aName [

	^ self new initializeWith: aName
]

{ #category : 'initialization' }
LazyShip >> initializeWith: aName [
	name:=aName.
]

{ #category : 'as yet unclassified' }
LazyShip >> showName [

	^ name
]

{ #category : 'as yet unclassified' }
LazyShip >> wantsToPlay [

	^ false
]
