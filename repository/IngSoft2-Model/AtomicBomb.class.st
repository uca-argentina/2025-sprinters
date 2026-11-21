Class {
	#name : 'AtomicBomb',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
AtomicBomb >> applyTo: aShip in: aGame [

	aGame sendAllShipsToStart.
	aGame damageAllShips
]
