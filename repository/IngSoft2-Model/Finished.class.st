Class {
	#name : 'Finished',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
Finished >> keepPlaying: aGame [

	^ self
]

{ #category : 'playing' }
Finished >> play: aGame [

	^ Error signal:
		  'The game has already been played, you can not play any more.'
]

{ #category : 'playing' }
Finished >> playTurnOf: aGame [

	^ Error signal:
		  'The game has already been played, you can not play any more.'
]

{ #category : 'playing' }
Finished >> rankingOf: aGame [

	^ aGame topShipNames
]

{ #category : 'as yet unclassified' }
Finished >> ship: aShipName plays: aCard targeting: aTarget in: aGame [

	^ Error signal: 'Cards can not be played once the game has finished'
]

{ #category : 'as yet unclassified' }
Finished >> skipTurnOf: aGame [

	^ Error signal:
		  'The game has already been played, you can not play any more.'
]

{ #category : 'playing' }
Finished >> winnerOf: aGame [

	^ aGame leaderName
]
