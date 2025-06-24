Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenCard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CancellationCard class >> newWithCard: aChosenCard [

	^ self new initializeWith:aChosenCard.
]

{ #category : 'as yet unclassified' }
CancellationCard >> applyTo: aShip using: aShip2 in: aGame [ 
	aGame permanentCardsPlayed ifEmpty: [Error signal: 'This card must be played when there is at least one active card']. 
	aGame applyCancellationCardEffectOn: chosenCard.
]

{ #category : 'as yet unclassified' }
CancellationCard >> getChosenCard [
	^chosenCard .
]

{ #category : 'initialization' }
CancellationCard >> initializeWith:aChosenCard [
	chosenCard := aChosenCard .
]
