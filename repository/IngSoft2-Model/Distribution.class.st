Class {
	#name : 'Distribution',
	#superclass : 'Object',
	#instVars : [
		'probability',
		'effectGenerator'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Distribution class >> of: anEffectGenerator withProbability: aProbability [

	(aProbability between: 0 and: 1) ifFalse: [
		^ Error signal: 'Probability must be between 0 and 1' ].
	^ self new initializeOf: anEffectGenerator withProbability: aProbability
]

{ #category : 'initialization' }
Distribution >> initializeOf: anEffectGenerator withProbability: aProbability [

	effectGenerator := anEffectGenerator.
	probability := aProbability
]

{ #category : 'instance creation' }
Distribution >> newEffect [

	^ effectGenerator value
]

{ #category : 'accessing' }
Distribution >> probability [
	^ probability
]
