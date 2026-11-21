Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'name',
		'location',
		'shields'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Ship class >> create: aName [

	aName isString ifFalse: [
		^ Error signal: 'Ship´s name must be a string.' ].

	^ self new initializeWith: aName
]

{ #category : 'initialization' }
Ship >> initializeWith: aName [

	name := aName.
	location := Location cell: 1 lap: 1.
	shields := Shields full.
]

{ #category : 'testing' }
Ship >> isAheadOf: anotherShip [

	^ location isAheadOf: anotherShip location
]

{ #category : 'testing' }
Ship >> isDefenseless [

	^ shields isDepleted
]

{ #category : 'accessing' }
Ship >> laps [

	^ location lap
]

{ #category : 'accessing' }
Ship >> location [

	^ location
]

{ #category : 'playing' }
Ship >> loseShield [

	shields lose
]

{ #category : 'path commands' }
Ship >> moveTo: aLocation [

	location := aLocation
]

{ #category : 'accessing' }
Ship >> name [

	^ name
]

{ #category : 'accessing' }
Ship >> position [

	^ location cell
]

{ #category : 'shields' }
Ship >> restoreShields [

	shields restore
]

{ #category : 'accessing' }
Ship >> shields [

	^ shields amount
]

{ #category : 'playing' }
Ship >> winAt: aBoard [

	^ aBoard isTheFinish: location
]
