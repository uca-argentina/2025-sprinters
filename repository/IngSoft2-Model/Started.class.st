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

{ #category : 'initialization' }
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

{ #category : 'playing' }
Started >> markAsPlaying [

	playing := true
]

{ #category : 'playing' }
Started >> play:aGame [
	 [aGame currentStatus isFinished ] whileFalse: [ aGame playTurn ].
]

{ #category : 'playing' }
Started >> showWinner: aGame [

	^ Error signal: 'The game is not finished, so it hasn´t a winner yet'
]
