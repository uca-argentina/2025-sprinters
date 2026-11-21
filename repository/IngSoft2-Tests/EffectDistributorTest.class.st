Class {
	#name : 'EffectDistributorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectDistributorTest >> test000WhenDistributingEffectsThenEveryCellReceivesOne [

	| effects |
	effects := (EffectDistributor with: {
			            (Distribution of: [ NoEffect new ] withProbability: 0.4).
			            (Distribution of: [ BlackHole new ] withProbability: 0.6) })
		           effectsFor: 5.
	self assert: effects size equals: 5
]

{ #category : 'tests' }
EffectDistributorTest >> test001WhenDistributingEffectsThenTheyFollowTheirProbabilities [

	| effects ratioOf tolerance |
	effects := (EffectDistributor with: {
			            (Distribution of: [ NoEffect new ] withProbability: 0.38).
			            (Distribution of: [ CardGiver new ] withProbability: 0.10).
			            (Distribution of: [ BlackHole new ] withProbability: 0.17).
			            (Distribution of: [ HyperSpaceJump new ] withProbability: 0.17).
			            (Distribution of: [ MoonWalk move: 3 ] withProbability: 0.09).
			            (Distribution
				             of: [
					             HyperJump with: {
							             (Distance parsecs: 8).
							             (Distance parsecs: 6) } ]
				             withProbability: 0.07).
			            (Distribution of: [ AtomicBomb new ] withProbability: 0.02) })
		           effectsFor: 1000.
	ratioOf := [ :effectClass |
	           (effects count: [ :effect | effect class = effectClass ]) / 1000 ].
	tolerance := 0.05.
	self assert: ((ratioOf value: NoEffect) between: 0.38 - tolerance and: 0.38 + tolerance).
	self assert: ((ratioOf value: CardGiver) between: 0.10 - tolerance and: 0.10 + tolerance).
	self assert: ((ratioOf value: BlackHole) between: 0.17 - tolerance and: 0.17 + tolerance).
	self assert: ((ratioOf value: HyperSpaceJump) between: 0.17 - tolerance and: 0.17 + tolerance).
	self assert: ((ratioOf value: MoonWalk) between: 0.09 - tolerance and: 0.09 + tolerance).
	self assert: ((ratioOf value: HyperJump) between: 0.07 - tolerance and: 0.07 + tolerance).
	self assert: (ratioOf value: AtomicBomb) > 0
]

{ #category : 'tests' }
EffectDistributorTest >> test002WhenProbabilitiesDoNotAddUpToOneThenRaiseError [

	self
		should: [
			EffectDistributor with: {
					(Distribution of: [ NoEffect new ] withProbability: 0.40).
					(Distribution of: [ CardGiver new ] withProbability: 0.10).
					(Distribution of: [ BlackHole new ] withProbability: 0.20).
					(Distribution of: [ HyperSpaceJump new ] withProbability: 0.20).
					(Distribution of: [ MoonWalk move: 3 ] withProbability: 0.10).
					(Distribution of: [ AtomicBomb new ] withProbability: 0.08) } ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Probabilities must add up to 1' ]
]

{ #category : 'tests' }
EffectDistributorTest >> test003WhenDistributingEffectsThenEachCellHasItsOwnEffect [

	| effects |
	effects := (EffectDistributor with: { (Distribution
			              of: [
				              HyperJump with: {
						              (Distance parsecs: 8).
						              (Distance parsecs: 6) } ]
			              withProbability: 1) }) effectsFor: 2.
	self deny: effects first == effects last
]

{ #category : 'tests' }
EffectDistributorTest >> test004WhenProbabilityIsNotBetweenZeroAndOneThenRaiseError [

	self
		should: [ Distribution of: [ NoEffect new ] withProbability: 1.5 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Probability must be between 0 and 1' ]
]
