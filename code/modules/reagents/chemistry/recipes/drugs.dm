/datum/chemical_reaction/space_drugs
	name = "Space Drugs"
	id = /datum/reagent/drug/space_drugs
	results = list(/datum/reagent/drug/space_drugs = 3)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/lithium = 1)

/datum/chemical_reaction/crank
	name = "Crank"
	id = /datum/reagent/drug/crank
	results = list(/datum/reagent/drug/crank = 5)
	required_reagents = list(/datum/reagent/medicine/diphenhydramine = 1, /datum/reagent/ammonia = 1, /datum/reagent/lithium = 1, /datum/reagent/toxin/acid = 1, /datum/reagent/fuel = 1)
	mix_message = "The mixture violently reacts, leaving behind a few crystalline shards."
	required_temp = 390

/datum/chemical_reaction/krokodil
	name = "Krokodil"
	id = /datum/reagent/drug/krokodil
	results = list(/datum/reagent/drug/krokodil = 6)
	required_reagents = list(/datum/reagent/medicine/diphenhydramine = 1, /datum/reagent/medicine/morphine = 1, /datum/reagent/abraxo_cleaner = 1, /datum/reagent/potassium = 1, /datum/reagent/phosphorus = 1, /datum/reagent/fuel = 1)
	mix_message = "The mixture dries into a pale blue powder."
	required_temp = 380

/datum/chemical_reaction/heroin
	name = "Heroin"
	id = /datum/reagent/drug/heroin
	results = list(/datum/reagent/drug/heroin = 6)
	required_reagents = list(/datum/reagent/medicine/morphine = 1, /datum/reagent/medicine/spaceacillin = 1, /datum/reagent/hydrogen = 1)
	mix_message = "The mixture dries turns into a pale white powder and then melts into a honey gold liquid."
	required_temp = 500

/datum/chemical_reaction/methamphetamine
	name = "methamphetamine"
	id = /datum/reagent/drug/methamphetamine
	results = list(/datum/reagent/drug/methamphetamine = 4)
	required_reagents = list(/datum/reagent/medicine/ephedrine = 1, /datum/reagent/iodine = 1, /datum/reagent/phosphorus = 1, /datum/reagent/hydrogen = 1)
	required_temp = 374

/datum/chemical_reaction/bath_salts
	name = "bath_salts"
	id = /datum/reagent/drug/bath_salts
	results = list(/datum/reagent/drug/bath_salts = 7)
	required_reagents = list(/datum/reagent/toxin/bad_food = 1, /datum/reagent/saltpetre = 1, /datum/reagent/consumable/nutriment = 1, /datum/reagent/abraxo_cleaner = 1, /datum/reagent/consumable/enzyme = 1, /datum/reagent/consumable/tea = 1, /datum/reagent/mercury = 1)
	required_temp = 374

/datum/chemical_reaction/aranesp
	name = "aranesp"
	id = /datum/reagent/drug/aranesp
	results = list(/datum/reagent/drug/aranesp = 3)
	required_reagents = list(/datum/reagent/medicine/epinephrine = 1, /datum/reagent/medicine/atropine = 1, /datum/reagent/medicine/morphine = 1)

/datum/chemical_reaction/happiness
	name = "Happiness"
	id = /datum/reagent/drug/happiness
	results = list(/datum/reagent/drug/happiness = 4)
	required_reagents = list(/datum/reagent/nitrous_oxide = 2, /datum/reagent/medicine/epinephrine = 1, /datum/reagent/consumable/ethanol = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)

/datum/chemical_reaction/skooma
	name = "Getaway"
	id = /datum/reagent/drug/skooma
	results = list(/datum/reagent/drug/skooma = 2, /datum/reagent/consumable/ethanol/moonshine = 4, /datum/reagent/consumable/sugar = 4)
	required_temp = 280
	is_cold_recipe = TRUE
	required_reagents = list(/datum/reagent/moonsugar = 10, /datum/reagent/medicine/morphine = 5)

/datum/chemical_reaction/skoomarevert
	name = "skoomarevert"
	id = "skoomarevert"
	results = list(/datum/reagent/moonsugar = 1, /datum/reagent/medicine/morphine = 2.5)
	required_temp = 315 //a little above normal body temperature
	required_reagents = list(/datum/reagent/drug/skooma = 1)

/datum/chemical_reaction/aphro
	name = "crocin"
	id = /datum/reagent/drug/aphrodisiac
	results = list(/datum/reagent/drug/aphrodisiac = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/water = 1)
	required_temp = 400
	mix_message = "The mixture boils off a pink vapor..."//The water boils off, leaving the crocin

/datum/chemical_reaction/aphroplus
	name = "hexacrocin"
	id = /datum/reagent/drug/aphrodisiacplus
	results = list(/datum/reagent/drug/aphrodisiacplus = 1)
	required_reagents = list(/datum/reagent/drug/aphrodisiac = 6, /datum/reagent/phenol = 1)
	required_temp = 400
	mix_message = "The mixture rapidly condenses and darkens in color..."

/datum/chemical_reaction/anaphro
	name = "camphor"
	id = /datum/reagent/drug/anaphrodisiac
	results = list(/datum/reagent/drug/anaphrodisiac = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/sulfur = 1)
	required_temp = 400
	mix_message = "The mixture boils off a yellow, smelly vapor..."//Sulfur burns off, leaving the camphor

/datum/chemical_reaction/anaphroplus
	name = "hexacamphor"
	id = /datum/reagent/drug/anaphrodisiacplus
	results = list(/datum/reagent/drug/anaphrodisiacplus = 1)
	required_reagents = list(/datum/reagent/drug/anaphrodisiac = 6, /datum/reagent/acetone = 1)
	required_temp = 400
	mix_message = "The mixture thickens and heats up slighty..."

/datum/chemical_reaction/jet
	name = "Jet"
	id = /datum/reagent/drug/jet
	results = list(/datum/reagent/drug/jet = 5)
	required_reagents = list(/datum/reagent/drug/nicotine = 2, /datum/reagent/consumable/milk = 2, /datum/reagent/fuel = 1, /datum/reagent/consumable/ethanol = 1)

/datum/chemical_reaction/turbo
	name = "Turbo"
	id = /datum/reagent/drug/turbo
	results = list(/datum/reagent/drug/turbo = 4)
	required_reagents = list(/datum/reagent/cellulose = 1, /datum/reagent/toxin/cyanide = 1, /datum/reagent/consumable/cavefungusjuice = 1, /datum/reagent/drug/jet = 1) //fairly close to the ingame recipe

/datum/chemical_reaction/psycho
	name = "Psycho"
	id = /datum/reagent/drug/psycho
	results = list(/datum/reagent/drug/psycho = 3)
	required_reagents = list(/datum/reagent/toxin/acid = 1, /datum/reagent/consumable/cavefungusjuice = 1, /datum/reagent/ash = 1, /datum/reagent/drug/methamphetamine = 1)

/datum/chemical_reaction/buffout
	name = "Buffout"
	id = /datum/reagent/drug/buffout
	results = list(/datum/reagent/drug/buffout = 10)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/phosphorus = 1, /datum/reagent/sulfur = 1, /datum/reagent/drug/crank = 1, /datum/reagent/carbondioxide = 1, /datum/reagent/nitrous_oxide = 1)

