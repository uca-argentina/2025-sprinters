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

{ #category : 'as yet unclassified' }
Finished >> showWinner: aGame [

	^ aGame currentTopPlayer
]
