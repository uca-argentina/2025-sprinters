Class {
	#name : 'HyperJumpLightYear',
	#superclass : 'HyperJump',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJumpLightYear >> applyTo: aShip in: aGame [

	| board parsecsToJump cellsToJump |
	board := aGame board.
	parsecsToJump := self nextParsecs.
	cellsToJump := (parsecsToJump / board lightYearsPerCell ) floor.
	aGame applyHyperJumEffectOn: aShip moving: cellsToJump 
]
