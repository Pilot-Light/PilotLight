// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/rockplanet
	prefix = "_maps/RandomRuins/RockRuins/"
	allow_duplicates = FALSE
	cost = 5
	ruin_type = RUINTYPE_ROCK

/datum/map_template/ruin/rockplanet/heirophant
	name = "Ancient Heirophant"
	id = "rockheiro"
	description = "something dangerous"
	suffix = "rockplanet_heirophant.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_MEGAFAUNA, RUIN_TAG_INHOSPITABLE)

/* TODO: GREEBLE
/datum/map_template/ruin/rockplanet/dangerpod
	name = "Dangerous pod"
	id = "dangerpod"
	description = "A pod holding a dangerous threat."
	suffix = "wasteplanet_dangerpod.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_SHELTER)

*/

/*	//TODO: MAKE THIS A MINOR RUIN
/datum/map_template/ruin/rockplanet/pioneer
	name = "Krusty Krab Pizza"
	id = "pioneer"
	description = "The pioneers used to ride these babies for miles!"
	suffix = "rockplanet_pioneer.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MINOR_LOOT, RUIN_TAG_INHOSPITABLE)

*/

/*greeble
/datum/map_template/ruin/rockplanet/house
	name = "baracaded house"
	id = "house"
	description = "Some sort of house, baracaded in. It must be baracaded for a reason.."
	suffix = "rockplanet_house.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

*/

/datum/map_template/ruin/rockplanet/mining_expedition
	name = "Mining Expedition"
	id = "expedition"
	description = "A mining operation gone wrong."
	suffix = "rockplanet_miningexpedition.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/rockplanet/boxsci
	name = "Abandoned science wing"
	id = "abandonedscience"
	description = "A chunk of a station that broke off.."
	suffix = "rockplanet_boxsci.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER)

/datum/map_template/ruin/rockplanet/crash_cult
	name = "Crashed Exploration Clipper"
	description = "A crashed exploration vessel. Hivebots are taking this ship apart for scrap."
	id = "crash_cult"
	suffix = "rockplanet_crash.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/rockplanet/saloon
	name = "Abandoned saloon"
	description = "For whatever reason, someone decided to make a colony with a indie style."
	id = "rockplanet_saloon"
	suffix = "rockplanet_saloon.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_INHOSPITABLE)

/datum/map_template/ruin/rockplanet/harmfactory
	name = "Harm Factory"
	description = "A factory made for HARM and AGONY."
	id = "rockplanet_harmfactory"
	suffix = "rockplanet_harmfactory.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MAJOR_LOOT, Shelter", RUIN_TAG_ANTAG_GEAR, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/rockplanet/budgetcuts
	name = "Budgetcuts"
	description = "Nanotrasen's gotta lay off some personnel, and this facility hasn't been worth the effort so far"
	id = "rockplanet_budgetcuts"
	suffix = "rockplanet_budgetcuts.dmm"
	ruin_tags = list(RUIN_TAG_HARD_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/rockplanet/nomadcrash
	name = "Nomad Crash"
	description = "A Crashed Arrow & Axe Interceptor. A long forgotten Crew. They tried their best to survive..."
	id = "rockplanet_nomadcrash"
	suffix = "rockplanet_nomadcrash.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_HAZARDOUS, RUIN_TAG_LIVEABLE)
