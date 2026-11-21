Class {
	#name : 'ActiveMercenary',
	#superclass : 'ActiveCard',
	#instVars : [
		'hirer',
		'mercenary'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance ' }
ActiveMercenary class >> hiredBy: aShip mercenary: anotherShip [

	^ self new initializeHiredBy: aShip mercenary: anotherShip
]

{ #category : 'querying' }
ActiveMercenary >> hasHired: aShip [

	^ mercenary == aShip
]

{ #category : 'initialization' }
ActiveMercenary >> initializeHiredBy: aShip mercenary: anotherShip [

	hirer := aShip.
	mercenary := anotherShip
]

{ #category : 'querying' }
ActiveMercenary >> mercenariesOf: aShip [

	^ aShip == hirer
		  ifTrue: [ { mercenary } ]
		  ifFalse: [ #(  ) ]
]
