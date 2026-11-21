Class {
	#name : 'Shields',
	#superclass : 'Object',
	#instVars : [
		'amount'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Shields class >> full [

	^ self new initializeWith: self maximum
]

{ #category : 'accessing' }
Shields class >> maximum [

	^ 3
]

{ #category : 'accessing' }
Shields >> amount [

	^ amount
]

{ #category : 'initialization' }
Shields >> initializeWith: anAmount [

	amount := anAmount
]

{ #category : 'testing' }
Shields >> isDepleted [

	^ amount = 0
]

{ #category : 'modifying' }
Shields >> lose [

	amount := amount - 1
]

{ #category : 'window management' }
Shields >> restore [

	amount := self class maximum
]
