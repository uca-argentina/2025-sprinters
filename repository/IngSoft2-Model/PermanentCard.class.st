Class {
	#name : 'PermanentCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
PermanentCard >> generateRandomCard [


	| classes |
	classes := self class subclasses.
	^ (classes at: (Random new nextIntegerBetween: 1 and: classes size)) new . 
]

{ #category : 'testing' }
PermanentCard >> isPermanent [

	^ true
]

{ #category : 'testing' }
PermanentCard >> isRedo [

	^ false
]

{ #category : 'removing' }
PermanentCard >> removePermanentEffect [
	self subclassResponsibility .
]
