/datum/unit_test/open_air/Run()
	var/datum/virtual_level/vlevel = mapzone.virtual_levels[1]
	for(var/turf/open/T in vlevel.get_block())
		T.Initalize_Atmos(0)
		T.air.clear()
	var/turf/open/center_turf = vlevel.get_center()
	center_turf.air.set_moles(GAS_PLASMA, 32)
	for(var/i in 1 to 10)
		SSair.fire()
		sleep(1)
	if(center_turf.air.get_moles(GAS_PLASMA) > 28)
		Fail("Gas isn't moving at all, or isn't moving enough (somehow) (plasma started at 32, is now [center_turf.air.get_moles(GAS_PLASMA)]")
	center_turf.air.set_moles(GAS_PLASMA, 100)
	center_turf.air.set_moles(GAS_O2, 100/1.4)
	center_turf.air.set_temperature(5000)
	center_turf.air.vv_react(center_turf)
	if(center_turf.air.get_moles(GAS_PLASMA) >= 100)
		Fail("Gas isn't reacting properly (plasma: [center_turf.air.get_moles(GAS_PLASMA)], temp: [center_turf.air.return_temperature()]")
	var/obj/effect/hotspot = locate(/obj/effect/hotspot) in center_turf
	if(!istype(hotspot))
		Fail("Hotspots aren't showing up on reaction")

/datum/unit_test/open_air/Destroy()
	var/datum/virtual_level/vlevel = mapzone.virtual_levels[1]
	for(var/turf/T in vlevel.get_block())
		T.Initalize_Atmos(0)
	return ..()
