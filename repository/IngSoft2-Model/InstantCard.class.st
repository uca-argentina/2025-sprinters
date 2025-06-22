Class {
	#name : 'InstantCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
InstantCard >> generateRandomCard [

	| classes |
	classes := self class subclasses.
	^ (classes at: (Random new nextIntegerBetween: 1 and: classes size)) new. 
]

{ #category : 'testing' }
InstantCard >> isPermanent [

	^ false
]

{ #category : 'testing' }
InstantCard >> isRedo [

	^ false
]
