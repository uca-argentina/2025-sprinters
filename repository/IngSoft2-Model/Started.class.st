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

{ #category : 'as yet unclassified' }
Started >> play: aGame [

	aGame play
]

{ #category : 'as yet unclassified' }
Started >> showWinner: aGame [

	^ Error signal: 'The game is not finished, so it hasn´t a winner yet'
]
