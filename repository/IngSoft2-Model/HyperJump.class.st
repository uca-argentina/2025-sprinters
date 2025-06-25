Class {
	#name : 'HyperJump',
	#superclass : 'Effect',
	#instVars : [
		'parsecsToMove',
		'index',
		'distancesToMove'
	],
	#classInstVars : [
		'parsecsToMove',
		'index'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperJump class >> with: distanceToMove [

	| response |
	response := distanceToMove anySatisfy: [ :steps |
		            steps parsecs <= 0 or: [ steps lightYears <= 0 ] ].
	response ifTrue: [
		Error signal: 'Parsecs and lightYears to move must to be positive' ].
	(1 to: distanceToMove size - 1) do: [ :i |
		(distanceToMove at: i) parsecs < (distanceToMove at: i + 1) parsecs
			ifTrue: [
				Error signal:
					'Parsecs and lightYears have to be less than the earlier one' ] ].
	^ self new initializeWith: distanceToMove
]

{ #category : 'playing' }
HyperJump >> applyTo: aShip in: aGame [

	| board parsecsToJump |
	board := aGame board.
	parsecsToJump := self nextParsecs.
	aGame applyHyperJumEffectOn: aShip moving: parsecsToJump
]

{ #category : 'initialization' }
HyperJump >> initializeThis [

	^ self
]

{ #category : 'initialization' }
HyperJump >> initializeWith: aCollectionOfDistanceToMove [

	distancesToMove := aCollectionOfDistanceToMove.
	index := 1
]

{ #category : 'playing' }
HyperJump >> nextParsecs [

	| parsecsToJump |
	parsecsToJump := (distancesToMove at: index) parsecs.
	index := index \\ distancesToMove size + 1.
	^ parsecsToJump
]
