Class {
	#name : 'Location',
	#superclass : 'Object',
	#instVars : [
		'cell',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Location class >> cell: aCell lap: aLap [

	^ self new initializeCell: aCell lap: aLap
]

{ #category : 'comparing' }
Location >> = anObject [

	^ self class = anObject class and: [
		  cell = anObject cell and: [ lap = anObject lap ] ]
]

{ #category : 'accessing' }
Location >> atStart [

	^ self class cell: 1 lap: lap
]

{ #category : 'accessing' }
Location >> cell [

	^ cell
]

{ #category : 'comparing' }
Location >> hash [

	^ cell hash bitXor: lap hash
]

{ #category : 'initialization' }
Location >> initializeCell: aCell lap: aLap [

	cell := aCell.
	lap := aLap
]

{ #category : 'testing' }
Location >> isAheadOf: aLocation [

	^ lap > aLocation lap or: [
		  lap = aLocation lap and: [ cell > aLocation cell ] ]
]

{ #category : 'accessing' }
Location >> lap [

	^ lap
]
