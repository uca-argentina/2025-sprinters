Class {
	#name : 'Started',
	#superclass : 'Object',
	#instVars : [
		'playing'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Started class >> creation [

	^ self new initialization
]

{ #category : 'as yet unclassified' }
Started >> initialization [

	playing := false
]

{ #category : 'testing' }
Started >> isFinished [

	^ false
]

{ #category : 'testing' }
Started >> isPlaying [

	^ playing
]

{ #category : 'as yet unclassified' }
Started >> markAsPlaying [

	playing := true
]

{ #category : 'as yet unclassified' }
Started >> play:aGame [
	 [aGame currentStatus isFinished ] whileFalse: [ aGame playTurn ].
]

{ #category : 'as yet unclassified' }
Started >> showWinner: aGame [

	^ Error signal: 'The game is not finished, so it hasn´t a winner yet'
]
