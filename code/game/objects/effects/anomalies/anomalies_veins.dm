/obj/effect/anomaly/veins
	name = "fountain"
	icon_state = "veins"
	desc = "A mysterious anomaly, surrounded by blood of an unknown origin."
	density = TRUE
	aSignal = /obj/item/assembly/signaler/anomaly/veins
	effectrange = 6
	pulse_delay = 4


/obj/effect/anomaly/veins/anomalyEffect()
	..()

	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return

	COOLDOWN_START(src, pulse_cooldown, pulse_delay)
	var/turf/spot = locate(rand(src.x-effectrange/2, src.x+effectrange/2), rand(src.y-effectrange/2, src.y+effectrange/2), src.z)
	var/obj/effect/gibspawner/mess = pick(list(
		/obj/effect/gibspawner/human,
		/obj/effect/gibspawner/xeno,
		/obj/effect/gibspawner/generic/animal
	))
	new mess(spot)

	for(var/mob/living/carbon/suckee in range(effectrange, src))
		if(suckee.run_armor_check(attack_flag = "melee") <= 40 )
			suckee.bleed(20)
			suckee.apply_damage(5, BRUTE)
			visible_message("<span class='warning'>Blood starts to fly off of [suckee], heading for the [src]!")

	return


/obj/effect/anomaly/veins/Bumped(atom/movable/AM)
	anomalyEffect()
	new /obj/effect/gibspawner/human(loc)

/obj/effect/anomaly/veins/detonate()
	for(var/mob/living/carbon/suckee in range(effectrange, src))
		suckee.bleed(200)
		visible_message("<span class='warning'>[suckee] hemorrages, a fountain of blood heading for [src]!")
		anomalyEffect()
		anomalyEffect()
		anomalyEffect()
	. = ..()

/obj/effect/anomaly/veins/planetary
	immortal = TRUE
	immobile = TRUE
