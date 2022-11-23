///This datum handles the transitioning from a turf to a specific biome, and handles spawning decorative structures and mobs.
/datum/biome
	///Type of turf this biome creates
	var/turf/turf_type
	///Chance of having a structure from the flora types list spawn
	var/flora_density = 0
	///Chance of having a mob from the fauna types list spawn
	var/fauna_density = 0
	///list of type paths of objects that can be spawned when the turf spawns flora
	var/list/flora_types = list(/obj/structure/flora/grass/jungle)
	///list of type paths of mobs that can be spawned when the turf spawns fauna
	var/list/fauna_types = list()

///This proc handles the creation of a turf of a specific biome type
/datum/biome/proc/generate_turf(turf/gen_turf, changeturf_flags)
	gen_turf.ChangeTurf(turf_type, initial(turf_type.baseturfs), changeturf_flags)

/datum/biome/proc/populate_turf(turf/gen_turf)
	var/area/A = gen_turf.loc
	if(length(fauna_types) && prob(fauna_density) && (A.area_flags & MOB_SPAWN_ALLOWED))
		var/mob/fauna = pick(fauna_types)
		new fauna(gen_turf)

	if(length(flora_types) && prob(flora_density) && (A.area_flags & FLORA_ALLOWED))
		var/obj/structure/flora = pick(flora_types)
		new flora(gen_turf)

//jungle planet biomes
/datum/biome/mudlands
	turf_type = /turf/open/floor/plating/dirt/jungle/dark
	flora_types = list(/obj/structure/flora/grass/jungle,/obj/structure/flora/grass/jungle/b, /obj/structure/flora/rock/jungle, /obj/structure/flora/rock/pile/largejungle)
	flora_density = 3

/datum/biome/plains
	turf_type = /turf/open/floor/plating/grass/jungle
	flora_types = list(/obj/structure/flora/grass/jungle,/obj/structure/flora/grass/jungle/b, /obj/structure/flora/tree/jungle, /obj/structure/flora/rock/jungle, /obj/structure/flora/junglebush, /obj/structure/flora/junglebush/b, /obj/structure/flora/junglebush/c, /obj/structure/flora/junglebush/large, /obj/structure/flora/rock/pile/largejungle)
	flora_density = 15

/datum/biome/jungle
	turf_type = /turf/open/floor/plating/grass/jungle
	flora_types = list(/obj/structure/flora/grass/jungle,/obj/structure/flora/grass/jungle/b, /obj/structure/flora/tree/jungle, /obj/structure/flora/rock/jungle, /obj/structure/flora/junglebush, /obj/structure/flora/junglebush/b, /obj/structure/flora/junglebush/c, /obj/structure/flora/junglebush/large, /obj/structure/flora/rock/pile/largejungle, /obj/structure/spacevine)
	flora_density = 50

/datum/biome/jungle/deep
	flora_types = list(/obj/structure/flora/grass/jungle,/obj/structure/flora/grass/jungle/b, /obj/structure/flora/tree/jungle, /obj/structure/flora/rock/jungle, /obj/structure/flora/junglebush, /obj/structure/flora/junglebush/b,
	/obj/structure/flora/junglebush/c,
	/obj/structure/flora/junglebush/large,
	/obj/structure/flora/rock/pile/largejungle,
	/obj/structure/spacevine/dense,
	/obj/structure/spacevine/dense,
	/obj/structure/spacevine/dense,
	/obj/structure/spacevine/dense,
	/obj/structure/spacevine/dense,
	/obj/structure/spacevine/dense,
	/obj/structure/spacevine/dense,
	/obj/structure/spacevine/dense,
	/obj/structure/spacevine
	)
	flora_density = 90

/datum/biome/wasteland
	turf_type = /turf/open/floor/plating/dirt/jungle/wasteland

/datum/biome/water
	turf_type = /turf/open/water/jungle

/datum/biome/mountain
	turf_type = /turf/closed/mineral/random/jungle
