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

{ #category : 'creation' }
Distance class >> lightYear: anAmount [

	^ self new initializeWithParsecs: anAmount / 3 andLightYears: anAmount
]

{ #category : 'creation' }
Distance class >> parsecs: anAmount [

	^ self new initializeWithParsecs: anAmount andLightYears: (anAmount * 3)
]

{ #category : 'initialization' }
Distance >> initializeWithParsecs: someParsecs andLightYears: someLightYear [

	parsecs := someParsecs.
	lightYear := someLightYear
]

{ #category : 'accessing' }
Distance >> lightYears [

	^ lightYear
]

{ #category : 'accessing' }
Distance >> parsecs [

	^ parsecs
]
