Class {
	#name : 'EffectDistributor',
	#superclass : 'Object',
	#instVars : [
		'distributions',
		'random'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
EffectDistributor class >> with: aCollectionOfDistributions [

	| totalProbability |
	totalProbability := aCollectionOfDistributions
		                    inject: 0
		                    into: [ :total :each | total + each probability ].
	(totalProbability - 1) abs < 0.0001 ifFalse: [
		^ Error signal: 'Probabilities must add up to 1' ].
	^ self new initializeWith: aCollectionOfDistributions
]

{ #category : 'distributing' }
EffectDistributor >> effectsFor: anAmountOfCells [

	^ (1 to: anAmountOfCells) collect: [ :each | self randomEffect ]
]

{ #category : 'initialization' }
EffectDistributor >> initializeWith: aCollectionOfDistributions [

	distributions := aCollectionOfDistributions.
	random := Random new
]

{ #category : 'distributing' }
EffectDistributor >> randomEffect [

	| randomNumber accumulated |
	randomNumber := random next.
	accumulated := 0.
	^ (distributions
		   detect: [ :distribution |
			   accumulated := accumulated + distribution probability.
			   randomNumber < accumulated ]
		   ifNone: [ distributions last ]) newEffect
]
