Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'deck',
		'hands',
		'activeCards',
		'playedCards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CardManager class >> with: aDeck [

	^ self new initializeWith: aDeck
]

{ #category : 'playing' }
CardManager >> activate: anActiveCard [

	activeCards add: anActiveCard
]

{ #category : 'quering' }
CardManager >> activeCards [

	^ activeCards copy
]

{ #category : 'quering' }
CardManager >> bonusFor: aShip [

	^ activeCards
		  inject: 0
		  into: [ :total :activeCard | total + (activeCard bonusFor: aShip) ]
]

{ #category : 'playing' }
CardManager >> cancel: anActiveCard [

	activeCards ifEmpty: [
		^ Error signal:
			  'Cannot play cancellation card with no active permanent cards' ].
	activeCards
		remove: anActiveCard
		ifAbsent: [ ^ Error signal: 'The selected card is not currently active' ]
]

{ #category : 'dealing' }
CardManager >> dealInitialCardsTo: aShip [

	2 timesRepeat: [ self giveCardTo: aShip ]
]

{ #category : 'dealing' }
CardManager >> giveCardTo: aShip [

	(self handOf: aShip) add: deck draw
]

{ #category : 'dealing' }
CardManager >> handOf: aShip [

	^ hands at: aShip ifAbsentPut: [ OrderedCollection new ]
]

{ #category : 'initialization' }
CardManager >> initializeWith: aDeck [

	deck := aDeck.
	hands := IdentityDictionary new.
	activeCards := OrderedCollection new.
	playedCards := OrderedCollection new
]

{ #category : 'quering' }
CardManager >> isHired: aShip [

	^ activeCards anySatisfy: [ :activeCard | activeCard hasHired: aShip ]
]

{ #category : 'playing' }
CardManager >> lastPlayedCard [

	playedCards ifEmpty: [
		^ Error signal: 'There are no cards played before.' ].
	^ playedCards last
]

{ #category : 'quering' }
CardManager >> mercenariesOf: aShip [

	^ activeCards flatCollect: [ :activeCard | activeCard mercenariesOf: aShip ]
]

{ #category : 'playing' }
CardManager >> play: aCard by: aShip targeting: aTarget in: aGame [

	((self handOf: aShip) includes: aCard) ifFalse: [
		^ Error signal: 'Cannot play a card you do not have' ].
	aCard playBy: aShip targeting: aTarget in: aGame.
	(self handOf: aShip) remove: aCard.
	aCard registerIn: self
]

{ #category : 'playing' }
CardManager >> registerPlayed: aCard [

	playedCards add: aCard
]
