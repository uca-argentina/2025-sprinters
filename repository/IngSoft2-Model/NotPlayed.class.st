Class {
	#name : 'NotPlayed',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
NotPlayed >> isFinished [

	^ false
]

{ #category : 'as yet unclassified' }
NotPlayed >> showWinner: aGame [

	^ Error signal:
		  'The game has not started, it does not have a winner yet'
]
