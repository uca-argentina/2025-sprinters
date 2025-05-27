Class {
	#name : 'HyperJump',
	#superclass : 'Object',
	#instVars : [
		'parsecsToMove',
		'index'
	],
	#classInstVars : [
		'parsecsToMove',
		'index'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HyperJump class >> initializeThis [
	^ self new initializeWith: 10
]

{ #category : 'instance creation' }
HyperJump class >> with: parsecsToMove [

	| response |
	response := parsecsToMove anySatisfy: [ :steps | steps <= 0 ].
	response ifTrue: [
		Error signal: 'Parsecs to move must to be positive' ].
	(1 to: parsecsToMove size - 1) do: [ :i |
		(parsecsToMove at: i) < (parsecsToMove at: i + 1) ifTrue: [
			Error signal: 'Parsecs have to be less than the earlier one' ] ].
	^ self new initializeWith: parsecsToMove
]

{ #category : 'as yet unclassified' }
HyperJump >> applyTo: aShip in: aGame [

	| board parsecsToJump |
	board := aGame board.
	parsecsToJump := self nextParsecs.
	aShip receiveHyperJumpIn: board moving:parsecsToJump.
]

{ #category : 'initialization' }
HyperJump >> initializeWith: collectionOfparsecs [

	| collectionOfparsecsList |
	collectionOfparsecsList := OrderedCollection new.
	collectionOfparsecs to: 1 by: -1 do: [ :each |
	collectionOfparsecsList add: each ].

	parsecsToMove := collectionOfparsecsList.
	index := 1
]

{ #category : 'as yet unclassified' }
HyperJump >> nextParsecs [

	| parsecsToJump |
	parsecsToJump := parsecsToMove at: index.
	index := index \\ parsecsToMove size + 1.
	^ parsecsToJump
]

{ #category : 'accessing' }
HyperJump >> numberOfCells [
	self shouldBeImplemented.
]

{ #category : 'as yet unclassified' }
HyperJump >> showName [

	^ 'Hyper Jump'
]

{ #category : 'instance creation' }
HyperJump >> with: parsecsToMove [ 
	| response |
	response := parsecsToMove anySatisfy: [ :steps | steps <= 0 ].
	response ifTrue: [
		Error signal: 'Parsecs to move must to be positive' ].
	(1 to: parsecsToMove size - 1) do: [ :i |
		(parsecsToMove at: i) < (parsecsToMove at: i + 1) ifTrue: [
			Error signal: 'Parsecs have to be less than the earlier one' ] ].
]
