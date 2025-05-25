Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BattleManager >> fightBetween: shipA and: shipB [

	| resultA resultB |
	[
	resultA := shipA throwDices.
	resultB := shipB throwDices.
	resultA = resultB ] whileTrue.

	resultA > resultB
		ifTrue: [ shipB loseFight ]
		ifFalse: [ shipA loseFight ]
]
