Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'amountFaces'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Dice class >> with: amountOfFaces [
	amountOfFaces > 0 ifFalse: [
		^ Error signal: 'Amount of faces must be greater than zero'].
	
	^ self new initializeWith: amountOfFaces.
]

{ #category : 'accessing' }
Dice >> faces [
	^ amountFaces.
]

{ #category : 'initialization' }
Dice >> initializeWith: amountOfFaces [
	amountFaces := amountOfFaces. 
]

{ #category : 'accessing' }
Dice >> throw [
	| randomNumber |
	randomNumber := (Random new nextIntegerBetween: 1 and: amountFaces ).
	^ randomNumber.
]
