Class {
	#name : 'DeckTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DeckTest >> test000WhenDrawingFromARandomDeckThenItGivesACard [

	self assert: (RandomDeck new draw isKindOf: Card)
]

{ #category : 'tests' }
DeckTest >> test001WhenDrawingManyCardsFromARandomDeckThenAllKindsOfCardsAppear [

	| deck drawnKinds |
	deck := RandomDeck new.
	drawnKinds := ((1 to: 600) collect: [ :each | deck draw class ]) asSet.
	self assert: drawnKinds size equals: 6
]

{ #category : 'tests' }
DeckTest >> test002WhenDrawingFromAFixedDeckThenItGivesTheCardsInOrder [

	| speedCard redoCard deck |
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	deck := FixedDeck with: { speedCard. redoCard }.
	self assert: deck draw equals: speedCard.
	self assert: deck draw equals: redoCard
]
