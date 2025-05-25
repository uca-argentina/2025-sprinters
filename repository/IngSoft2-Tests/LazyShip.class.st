Class {
	#name : 'LazyShip',
	#superclass : 'Object',
	#instVars : [
		'name',
		'turnsToSkip'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
LazyShip class >> create: aName [

	^ self new initializeWith: aName
]

{ #category : 'testing' }
LazyShip >> canPlay [

	^ true
]

{ #category : 'initialization' }
LazyShip >> initializeWith: aName [

	name := aName.
	turnsToSkip := 0
]

{ #category : 'as yet unclassified' }
LazyShip >> showName [

	^ name
]

{ #category : 'as yet unclassified' }
LazyShip >> skipTurn [
	turnsToSkip:=turnsToSkip-1.
]

{ #category : 'as yet unclassified' }
LazyShip >> wantsToPlay [

	^ false
]
