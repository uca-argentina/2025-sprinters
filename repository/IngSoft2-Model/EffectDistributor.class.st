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

{ #category : 'as yet unclassified' }
EffectDistributor >> recieveAmountOfEffects [

	| cumulativeProbabilities cum effectsOnCells randomItem effectSelected  effectOnCells random |
	cumulativeProbabilities := OrderedCollection new.
	random := Random new.
	cum := 0.0.
	distribution do: [ :dist |
		cumulativeProbabilities add:
			(cum to: cum + dist probability) -> dist cellClass.
		cum := cum + dist probability ].
	effectOnCells := OrderedCollection new.
	cells timesRepeat: [
		randomItem := random next.
		effectSelected := cumulativeProbabilities
			                  detect: [ :effect |
			                  effect key includes: randomItem ]
			                  ifNone: [ NoEffect ].
		effectOnCells add:effectSelected ].

	^ effectOnCells
]
