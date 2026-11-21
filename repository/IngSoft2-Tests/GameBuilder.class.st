"
Soy una herramienta de los tests, no formo parte del modelo del juego.

Armo un Game válido con valores por defecto (1 nave, tablero de 10 celdas sin efectos,
wormhole entre 2 y 4, 20 parsecs, 1 vuelta, dado cargado que siempre saca 1 y mazo al azar),
para que cada test configure solo lo que le resulta relevante (patrón Builder).

Ejemplo:
	aGame := GameBuilder new
		shipsNamed: #( 'ship 1' 'ship 2' );
		diceSequence: #( 6 3 );
		allCellsWith: BlackHole new;
		deck: { SpeedCard new. RedoCard new. RepeatCard new. AccelerationCard new };
		build.

El Game resultante se crea siempre con su única forma de inicialización
(Game class >> with:using:andShipsNamed:deck:).
"
Class {
	#name : 'GameBuilder',
	#superclass : 'Object',
	#instVars : [
		'shipNames',
		'dice',
		'amountOfCells',
		'wormHole',
		'length',
		'laps',
		'effectsGenerator',
		'deck'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'configuring' }
GameBuilder >> allCellsWith: anEffect [

	effectsGenerator := [ :amount | Array new: amount withAll: anEffect ]
]

{ #category : 'building' }
GameBuilder >> build [

	| board |
	board := Board
		         withEffects: (effectsGenerator value: amountOfCells)
		         wormHole: wormHole
		         laps: laps
		         length: length.
	^ Game
		  with: board
		  using: (DiceBucket with: dice)
		  andShipsNamed: shipNames
		  deck: deck
]

{ #category : 'configuring' }
GameBuilder >> cells: anAmount [

	amountOfCells := anAmount
]

{ #category : 'configuring' }
GameBuilder >> deck: cards [

	deck := FixedDeck with: cards
]

{ #category : 'configuring' }
GameBuilder >> dice: aCollectionOfDice [

	dice := aCollectionOfDice
]

{ #category : 'configuring' }
GameBuilder >> diceSequence: numbers [

	dice := { LoadedDice withSequence: numbers }
]

{ #category : 'configuring' }
GameBuilder >> distributions: aCollectionOfDistributions [

	effectsGenerator := [ :amount |
	                    (EffectDistributor with: aCollectionOfDistributions)
		                    effectsFor: amount ]
]

{ #category : 'configuring' }
GameBuilder >> effects: aCollectionOfEffects [

	amountOfCells := aCollectionOfEffects size.
	effectsGenerator := [ :amount | aCollectionOfEffects ]
]

{ #category : 'initialization' }
GameBuilder >> initialize [

	super initialize.
	shipNames := #( 'ship 1' ).
	dice := { LoadedDice withSequence: #( 1 ) }.
	amountOfCells := 10.
	wormHole := Worm with: 2 and: 4.
	effectsGenerator := [ :amount | Array new: amount withAll: NoEffect new ].
	length := Distance parsecs: 20.
	laps := 1.
	deck := RandomDeck new
]

{ #category : 'configuring' }
GameBuilder >> laps: anAmount [

	laps := anAmount
]

{ #category : 'configuring' }
GameBuilder >> length: aDistance [

	length := aDistance
]

{ #category : 'configuring' }
GameBuilder >> shipsNamed: names [

	shipNames := names
]

{ #category : 'configuring' }
GameBuilder >> wormHoleBetween: aPosition and: anotherPosition [

	wormHole := Worm with: aPosition and: anotherPosition
]
