Class {
	#name : 'DiceBucket',
	#superclass : 'Object',
	#instVars : [
		'bucketOfDices'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
DiceBucket class >> with: aSetOfDices [
	^ self new initializeWith: aSetOfDices.
]

{ #category : 'initialization' }
DiceBucket >> initializeWith: aSetOfDices [ 
	bucketOfDices := aSetOfDices.
]

{ #category : 'as yet unclassified' }
DiceBucket >> throw [

	| totalSum |
	totalSum := 0.
	bucketOfDices do: [ :dice | totalSum := totalSum + dice throw ].
	^ totalSum
]
