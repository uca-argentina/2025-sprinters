Class {
	#name : 'LoadedDiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDiceTest >> test000WhenThrowALoadedDiceThenReturnMaximunFaces [

	| amountOfFaces aLoadedDice |
	amountOfFaces := 5.
	aLoadedDice := LoadedDice with: amountOfFaces.
	self assert: (aLoadedDice throw) equals: amountOfFaces
]
