Class {
	#name : 'Effect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Effect >> applyTo: aShip in: aGame [
	self subclassResponsibility .
]
