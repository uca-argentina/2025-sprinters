Class {
	#name : 'Distance',
	#superclass : 'Object',
	#instVars : [
		'lightYear',
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Distance class >> lightYear: anAmount [

	^ self new intializeWithLightYear: anAmount
]

{ #category : 'as yet unclassified' }
Distance class >> parsecs: anAmount [

	^ self new initializeWithParsecs: anAmount
]

{ #category : 'initialization' }
Distance >> initializeWithParsecs: anAmount [

	parsecs := anAmount.
	lightYear := anAmount * 3
]

{ #category : 'initialization' }
Distance >> intializeWithLightYear: anAmount [

	lightYear := anAmount.
	parsecs := anAmount // 3
]

{ #category : 'accessing' }
Distance >> lightYears [

	^ lightYear
]

{ #category : 'accessing' }
Distance >> parsecs [

	^ parsecs
]
