/turf/open/floor/plating/asteroid/basalt
	name = "volcanic floor"
	baseturfs = /turf/open/floor/plating/asteroid/basalt
	icon = 'icons/turf/floors.dmi'
	icon_state = "basalt"
	icon_plating = "basalt"
	base_icon_state = "basalt"
	floor_variance = 15
	digResult = /obj/item/stack/ore/glass/basalt

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/lit
	light_range = 2
	light_power = 0.6
	light_color = LIGHT_COLOR_FIRE

/turf/open/floor/plating/asteroid/basalt/lava //lava underneath
	baseturfs = /turf/open/lava/smooth

/turf/open/floor/plating/asteroid/basalt/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/asteroid/basalt/Initialize(mapload, inherited_virtual_z)
	. = ..()
	set_basalt_light(src)

/proc/set_basalt_light(turf/open/floor/B)
	switch(B.icon_state)
		if("basalt1", "basalt2", "basalt3")
			B.set_light(2, 0.6, LIGHT_COLOR_LAVA) //more light
		if("basalt5", "basalt9")
			B.set_light(1.4, 0.6, LIGHT_COLOR_LAVA) //barely anything!

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/icecropolis
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	baseturfs = /turf/open/indestructible/necropolis/icecropolis

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/icecropolis/inside
	initial_gas_mix = "o2=22;n2=82;TEMP=293.15"
	planetary_atmos = FALSE
	baseturfs = /turf/open/indestructible/necropolis/air

/turf/open/floor/plating/asteroid/basalt/purple
	icon = 'icons/turf/lavaland_purple.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/basalt/purple
	turf_type = /turf/open/floor/plating/asteroid/basalt/purple
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/basalt/purple/lit
	light_range = 2
	light_power = 0.6
	light_color = LIGHT_COLOR_FIRE

/turf/open/floor/plating/asteroid/purple
	name = "ashen sand"
	desc = "Sand, tinted by the chemicals in the atmosphere to an uncanny shade of purple."
	icon = 'icons/turf/lavaland_purple.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/purple
	turf_type = /turf/open/floor/plating/asteroid/basalt/purple
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/purple/lit
	light_range = 2
	light_power = 0.3
	light_color = LIGHT_COLOR_FIRE

/turf/open/floor/plating/grass/lava/orange
	icon = 'icons/turf/floors/lava_grass_orange.dmi'
	smooth_icon = 'icons/turf/floors/lava_grass_orange.dmi'
	baseturfs = /turf/open/floor/plating/grass/lava/orange

/turf/open/floor/plating/grass/lava/purple
	baseturfs = /turf/open/floor/plating/grass/lava/purple
	icon = 'icons/turf/floors/lava_grass_purple.dmi'
	smooth_icon = 'icons/turf/floors/lava_grass_purple.dmi'

/turf/open/floor/plating/moss //subtype as grass eri
	name = "mossy carpet"
	desc = "When the forests burned away and the sky grew dark, the moss learned to feed on the falling ash."
	baseturfs = /turf/open/floor/plating/ashplanet //explosions and damage can destroy the moss
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	icon_state = "moss"
	icon = 'icons/turf/lava_moss.dmi'
	base_icon_state = "moss"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	layer = HIGH_TURF_LAYER
	gender = PLURAL
	light_power = 1
	light_range = 2
	pixel_x = -9
	pixel_y = -9
