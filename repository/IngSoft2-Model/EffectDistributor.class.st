Class {
	#name : 'EffectDistributor',
	#superclass : 'Object',
	#instVars : [
		'distribution',
		'cells'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
EffectDistributor class >> withDistribution: aDistribution on:amountOfCells [ 
	^self new initializeWith: aDistribution on:amountOfCells
]

{ #category : 'initialization' }
EffectDistributor >> initializeWith: aDistribution on: amountOfCells [

	distribution := aDistribution.
	cells := amountOfCells
]

{ #category : 'playing' }
EffectDistributor >> recieveAmountOfEffects [

	| cumulativeProbabilities cum effectsOnCells randomItem effectSelected random |
	cumulativeProbabilities := OrderedCollection new.
	random := Random new.
	cum := 0.0.

	distribution do: [ :dist |
		cum := cum + dist probability.
		cumulativeProbabilities add: cum -> dist cellClass ].

	effectsOnCells := OrderedCollection new.

	cells timesRepeat: [
		randomItem := random next. "Entre 0 y 1"
		effectSelected := cumulativeProbabilities
			                  detect: [ :assoc | randomItem <= assoc key ]
			                  ifNone: [ NoEffect ].
		effectsOnCells add: effectSelected value ].

	^ effectsOnCells
]
