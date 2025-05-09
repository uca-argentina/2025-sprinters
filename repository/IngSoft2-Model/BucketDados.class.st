Class {
	#name : 'BucketDados',
	#superclass : 'Object',
	#instVars : [
		'bucketDeDados'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
BucketDados class >> with: aSetOfDados [ 
	^ self new initializeWith: aSetOfDados.
]

{ #category : 'initialization' }
BucketDados >> initializeWith: aSetOfDados [ 
	bucketDeDados := aSetOfDados.
]

{ #category : 'as yet unclassified' }
BucketDados >> tirarBucket [

	| suma |
	suma := 0.
	bucketDeDados do: [ :dado | suma := suma + dado tirarDado ].
	^ suma
]
