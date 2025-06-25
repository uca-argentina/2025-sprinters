Class {
	#name : 'Finished',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Finished >> isFinished [

	^ true
]

{ #category : 'testing' }
Finished >> isPlaying [

	^ false
]

{ #category : 'playing' }
Finished >> markAsPlaying [

	^ false
]

{ #category : 'playing' }
Finished >> play: aGame [

	^ Error signal:
		  'The game has already been played, you can not play any more.'
]

{ #category : 'playing' }
Finished >> showWinner: aGame [

	^ aGame currentTopPlayer
]
