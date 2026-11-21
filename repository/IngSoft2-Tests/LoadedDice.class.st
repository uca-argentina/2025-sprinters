"
Soy un dado cargado para los tests, no formo parte del modelo del juego.
Devuelvo en orden los valores de una secuencia y, al terminarla, vuelvo a empezar.

	(LoadedDice withSequence: #( 6 3 )) throw.   ""6, luego 3, luego 6...""
	(LoadedDice with: 4) throw.                  ""siempre 4""
"
Class {
	#name : 'LoadedDice',
	#superclass : 'Object',
	#instVars : [
		'index',
		'throwns'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
LoadedDice class >> with: aValue [

	^ self new initializeWith: { aValue }
]

{ #category : 'as yet unclassified' }
LoadedDice class >> withSequence: throwns [

	^ self new initializeWith: throwns
]

{ #category : 'initialization' }
LoadedDice >> initializeWith: aSequence [

	index := 1.
	throwns := aSequence
]

{ #category : 'as yet unclassified' }
LoadedDice >> throw [

	| result |
	result := throwns at: index.
	index := (index \\ throwns size + 1).
	^ result
]
