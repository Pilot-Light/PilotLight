/obj/effect/anomaly/melter
	name = "melter"
	icon_state = "inferno"
	desc = "A mysterious anomaly. Everburning green flames with a horrid sizzle, melting what's near"
	effectrange = 2
	pulse_delay = 10
	aSignal = /obj/item/assembly/signaler/anomaly/pyro

/obj/effect/anomaly/melter/anomalyEffect(seconds_per_tick)
	..()


	if(!COOLDOWN_FINISHED(src, pulse_cooldown))
		return
	COOLDOWN_START(src, pulse_cooldown, pulse_delay)

	for(var/mob/living/carbon/meltee in range(effectrange, src))
		for(var/X in meltee.get_equipped_items())
			var/obj/item/I = X
			I.acid_act(20, 20)
			I.update_icon()
	for (var/obj/item/melt in range(effectrange, src))
		melt.acid_act(20, 10)
		melt.update_icon()

/obj/effect/anomaly/melter/Bumped(atom/movable/AM)
	if(isobj(AM))
		var/obj/acid = AM
		acid.acid_act(100,20)
		acid.update_icon()


/obj/effect/anomaly/melter/detonate()
	for(var/mob/living/carbon/meltee in range(effectrange, src))
		for(var/X in meltee.get_equipped_items())
			var/obj/item/I = X
			I.acid_act(200, 20)
			I.update_icon()
	for(var/obj/item in range(effectrange, src))
		item.acid_act(100,20)
		item.update_icon()
	. = ..()


/obj/effect/anomaly/melter/planetary
	immortal = TRUE
	immobile = TRUE
