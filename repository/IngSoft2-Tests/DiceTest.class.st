Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
DiceTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [ 
	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage
		description: 'Test failed for excepted reasons'
]

{ #category : 'tests' }
DiceTest >> test000WhenCreateDiceWith5FacesThenFacesEqual5 [

	| aDice |
	aDice := Dice with: 5.
	self assert: aDice faces equals: 5.
]

{ #category : 'tests' }
DiceTest >> test001WhenThrowDiceWithNFacesThenReturnNumberBetween1andN [

	| aDice diceValue amountOfFaces|
	amountOfFaces := 5.
	aDice := Dice with: amountOfFaces.
	diceValue := aDice throwDice.
	self assert: (diceValue between: 1 and: amountOfFaces).
]

{ #category : 'tests' }
DiceTest >> test002WhenCreateDiceWithFacesLessThanZeroThenRaisesError [

	self 
	
	should: [ Dice with: 0 ]
	raise: Error 
	withExceptionDo: [ :error | self assert: (error messageText) equals: 'Amount of faces must be greater than zero' ].
]
