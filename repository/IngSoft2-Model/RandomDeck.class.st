Class {
	#name : 'RandomDeck',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'drawing' }
RandomDeck >> draw [

	^ { SpeedCard. AccelerationCard. MercenaryCard. CancellationCard. RedoCard. RepeatCard }
		  atRandom new
]
