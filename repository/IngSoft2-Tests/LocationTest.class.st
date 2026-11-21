Class {
	#name : 'LocationTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LocationTest >> test000WhenLocationIsOnAHigherLapThenItIsAhead [

	self assert: ((Location cell: 2 lap: 2) isAheadOf: (Location cell: 9 lap: 1))
]

{ #category : 'tests' }
LocationTest >> test001WhenLocationsAreOnTheSameLapThenTheHigherCellIsAhead [

	self assert: ((Location cell: 5 lap: 1) isAheadOf: (Location cell: 3 lap: 1)).
	self deny: ((Location cell: 3 lap: 1) isAheadOf: (Location cell: 5 lap: 1))
]

{ #category : 'tests' }
LocationTest >> test002WhenTwoLocationsHaveTheSameCellAndLapThenTheyAreEqual [

	self assert: (Location cell: 3 lap: 2) equals: (Location cell: 3 lap: 2).
	self deny: (Location cell: 3 lap: 2) = (Location cell: 3 lap: 1)
]

{ #category : 'tests' }
LocationTest >> test003WhenGoingBackToTheStartThenItKeepsTheLap [

	self assert: (Location cell: 7 lap: 2) atStart equals: (Location cell: 1 lap: 2)
]
