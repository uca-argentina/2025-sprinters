"
Soy un mazo determinista para los tests, no formo parte del modelo del juego.
Entrego las cartas en el mismo orden en que me las pasaron.
"
Class {
	#name : 'FixedDeck',
	#superclass : 'Object',
	#instVars : [
		'cards'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
FixedDeck class >> with: aCollectionOfCards [

	^ self new initializeWith: aCollectionOfCards
]

{ #category : 'drawing' }
FixedDeck >> draw [

	^ cards removeFirst
]

{ #category : 'initialization' }
FixedDeck >> initializeWith: aCollectionOfCards [

	cards := OrderedCollection withAll: aCollectionOfCards
]
