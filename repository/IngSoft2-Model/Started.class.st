Class {
	#name : 'Started',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Started >> isFinished [

	^ false
]

{ #category : 'testing' }
Started >> isPlaying [

	^ true
]

{ #category : 'as yet unclassified' }
Started >> showWinner [

	^ Error signal: 'The game is not finished, so it hasn´t a winner yet'
]
