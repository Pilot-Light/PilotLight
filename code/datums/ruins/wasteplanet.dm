// Hey! Listen! Update _maps\map_catalogue.txt with your new ruins!

/datum/map_template/ruin/wasteplanet
	prefix = "_maps/RandomRuins/WasteRuins/"
	allow_duplicates = FALSE
	cost = 5
	ruin_type = RUINTYPE_WASTE

/datum/map_template/ruin/wasteplanet/fortress
	name = "Fortress of Solitide"
	id = "solitude"
	description = "A fortress, although one you are probably more familiar with."
	suffix = "wasteplanet_fortress_of_solitide.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT RUIN_TAG_LIVEABLE RUIN_TAG_SHELTER)

/datum/map_template/ruin/wasteplanet/weaponstest
	name = "Weapons testing facility"
	id = "guntested"
	description = "A abandoned Nanotrasen weapons facility, presumably the place where the X-01 was manufactured."
	suffix = "wasteplanet_lab.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT RUIN_TAG_SHELTER RUIN_TAG_HAZARDOUS RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/wasteplanet/oreprocess
	name = "Ore Processing Facility"
	id = "oreprocess"
	description = "A fortress, although one you are probably more familiar with.."
	suffix = "wasteplanet_ore_proccessing_facility.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT RUIN_TAG_HAZARDOUS RUIN_TAG_LAVA RUIN_TAG_SHELTER)

/datum/map_template/ruin/wasteplanet/pandora
	id = "pandora_arena"
	suffix = "wasteplanet_pandora.dmm"
	name = "Pandora Arena"
	description = "Some... thing has settled here."
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT RUIN_TAG_MEGAFAUNA, RUIN_TAG_LIVEABLE)

/* Greeble
/datum/map_template/ruin/wasteplanet/pod
	name = "Derelict pod"
	id = "oldpod"
	description = "A large, old pod."
	suffix = "wasteplanet_pod.dmm"
	ruin_tags = list(RUIN_TAG_MEDIUM_COMBAT, RUIN_TAG_MEDIUM_LOOT RUIN_TAG_LIVEABLE)

*/

/datum/map_template/ruin/wasteplanet/crash_kitchen
	name = "Crashed Kitchen"
	description = "A crashed part of some unlucky ship."
	id = "crash_kitchen"
	suffix = "wasteplanet_crash_kitchen.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/wasteplanet/radiation
	name = "Honorable deeds storage"
	id = "wasteplanet_radiation"
	description = "A dumping ground for nuclear waste."
	suffix = "wasteplanet_unhonorable.dmm"
	ruin_tags = list(RUIN_TAG_MINOR_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)

/datum/map_template/ruin/wasteplanet/tradepost
	name = "Tradepost"
	id = "oldpod"
	description = "An abandoned tradepost."
	suffix = "wasteplanet_tradepost.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/wasteplanet/tarpit
	name = "Tar pit"
	id = "tarpit"
	description = "A facility once constructed over a asphalt deposit."
	suffix = "wasteplanet_tarpit.dmm"
	ruin_tags = list(RUIN_TAG_NO_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_LIVEABLE)

/datum/map_template/ruin/wasteplanet/abandoned_mechbay
	name = "Abandoned Mech Bay"
	description = "A military base formerly used for staging 4 mechs and crew. God knows what's in it now."
	id = "abandoned_mechbay"
	suffix = "wasteplanet_abandoned_mechbay.dmm"
	ruin_tags = list(RUIN_TAG_BOSS_COMBAT, RUIN_TAG_MEDIUM_LOOT, RUIN_TAG_SHELTER, RUIN_TAG_HAZARDOUS)
