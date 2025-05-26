Class {
	#name : 'AtomicBomb',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBomb >> applyTo: aShip in: aGame [

	aGame ships do: [ :ship | ship moveToFirstPosition ].
	aGame ships do: [ :ship | ship loseShield ]
]
