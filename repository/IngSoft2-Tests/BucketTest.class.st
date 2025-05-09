Class {
	#name : 'BucketTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BucketTest >> test000WhenThrow2DicesWith6FacesThenReturnNumberBetween2AndSumOfDiceOneAndTwo [

	| diceOne diceTwo bucketOfDices listOfDices diceGame |
	diceOne := Dice with: 6.
	diceTwo := Dice with: 6.
	listOfDices := OrderedCollection new: 2.
	listOfDices add: diceOne.
	listOfDices add: diceTwo.
	bucketOfDices := DiceBucket with: listOfDices.
	diceGame := bucketOfDices throwBucket .


	self assert: (diceGame between: listOfDices size and: diceOne faces + diceTwo faces).
]
