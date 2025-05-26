Class {
	#name : 'Distribution',
	#superclass : 'Object',
	#instVars : [
		'cellClass',
		'probability'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Distribution class >> at: aCellClass with: aProbability [ 
	(aProbability between: 0 and: 1) ifFalse:[
		Error signal: 'Distribution must add up 1'.
		].
	^ self new initializeWith: aProbability asignTo: aCellClass.
]

{ #category : 'accessing' }
Distribution >> cellClass [
	^ cellClass
]

{ #category : 'initialization' }
Distribution >> initializeWith: aProbability asignTo: aCellClass [

	cellClass := aCellClass.
	probability := aProbability
]

{ #category : 'accessing' }
Distribution >> probability [
	^ probability
]
