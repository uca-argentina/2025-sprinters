Class {
	#name : 'MercenaryCard',
	#superclass : 'PermanentCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
MercenaryCard >> activeCardBy: aShip targeting: aShipName in: aGame [

	| mercenary |
	mercenary := aGame shipNamed: aShipName.
	aGame validateIsAvailableAsMercenary: mercenary.
	^ ActiveMercenary hiredBy: aShip mercenary: mercenary
]
