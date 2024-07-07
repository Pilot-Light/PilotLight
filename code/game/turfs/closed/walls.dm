#define MAX_DENT_DECALS 15

/turf/closed/wall
	name = "wall"
	desc = "A huge chunk of metal used to separate rooms."
	icon = 'icons/turf/walls/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	explosion_block = 1

	thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT
	heat_capacity = 312500 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m plasteel wall

	baseturfs = /turf/open/floor/plating

	flags_ricochet = RICOCHET_HARD

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_AIRLOCK)
	canSmoothWith = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_WINDOW_FULLTILE, SMOOTH_GROUP_AIRLOCK)

	///lower numbers are harder. Used to determine the probability of a hulk smashing through.
	var/hardness = 40
	var/slicing_duration = 25  //default time taken to slice the wall
	var/sheet_type = /obj/item/stack/sheet/metal
	var/sheet_amount = 2
	var/obj/girder_type = /obj/structure/girder
	/// sound when something hits the wall and deals damage
	var/attack_hitsound = PROJECTILE_HITSOUND_METAL
	var/break_sound = 'sound/items/welder.ogg'

	var/list/dent_decals

	// The wall will ignore damage from weak items, depending on their
	// force, damage type, tool behavior, and sharpness. This is the minimum
	// amount of force that a blunt, brute item must have to damage the wall.
	var/min_dam = 8
	var/max_integrity = 400
	var/integrity
	var/brute_mod = 1
	var/burn_mod = 1
	var/repair_amount = 50
	// Projectiles that do extra damage to the wall
	var/list/extra_dam_proj

/turf/closed/wall/yesdiag
	icon_state = "wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags & SMOOTH_DIAGONAL_CORNERS && fixed_underlay) //Set underlays for the diagonal walls.
		var/mutable_appearance/underlay_appearance = mutable_appearance(layer = TURF_LAYER, plane = FLOOR_PLANE)
		if(fixed_underlay["space"])
			underlay_appearance.icon = 'icons/turf/space.dmi'
			underlay_appearance.icon_state = SPACE_ICON_STATE
			underlay_appearance.plane = PLANE_SPACE
		else
			underlay_appearance.icon = fixed_underlay["icon"]
			underlay_appearance.icon_state = fixed_underlay["icon_state"]
		fixed_underlay = string_assoc_list(fixed_underlay)
		underlays += underlay_appearance
	if(integrity == null)
		integrity = max_integrity


/turf/closed/wall/copyTurf(turf/T, copy_air, flags)
	. = ..()
	var/turf/closed/wall/wall_copy = T
	if(LAZYLEN(dent_decals))
		wall_copy.dent_decals = dent_decals.Copy()
		wall_copy.update_appearance()

/turf/closed/wall/update_overlays()
	. = ..()
	for(var/decal in dent_decals)
		. += decal

/turf/closed/wall/examine(mob/user)
	. += ..()
	. += deconstruction_hints(user)
	. += damage_hints(user)

/turf/closed/wall/proc/damage_hints(mob/user)
	switch(integrity / max_integrity)
		if(0.5 to 0.99)
			return "[p_they(TRUE)] look[p_s()] slightly damaged."
		if(0.25 to 0.5)
			return "[p_they(TRUE)] appear[p_s()] heavily damaged."
		if(0 to 0.25)
			return "<span class='warning'>[p_theyre(TRUE)] falling apart!</span>"
	return

/turf/closed/wall/proc/deconstruction_hints(mob/user)
	return "<span class='notice'>The outer plating is <b>welded</b> firmly in place.</span>"

/turf/closed/wall/attack_tk()
	return

// negative values reduce integrity, positive values increase integrity
/turf/closed/wall/proc/alter_integrity(damage, devastate = FALSE, safe_decon = FALSE)
	integrity += damage
	if(integrity >= max_integrity)
		integrity = max_integrity
	if(integrity <= 0)
		if(devastate)
			dismantle_wall(devastate)
			return FALSE
		// if damage put us 50 points or more below 0, and not safe decon we got proper demolished
		if(integrity <= -50)
			dismantle_wall(safe_decon)
		return FALSE
	integrity = min(integrity, max_integrity)
	update_stats()
	return integrity

/turf/closed/wall/proc/set_integrity(amount,devastate = FALSE)
	integrity = amount
	update_stats()
	if(integrity <= 0)
		dismantle_wall(devastate)

/turf/closed/wall/proc/update_stats()
	update_appearance()

/turf/closed/wall/bullet_act(obj/projectile/P)
	. = ..()
	var/dam = get_proj_damage(P)
	if(!dam)
		return
	if(P.suppressed != SUPPRESSED_VERY)
		visible_message("<span class='danger'>[src] is hit by \a [P]!</span>", null, null, COMBAT_MESSAGE_RANGE)
	if(!QDELETED(src))
		alter_integrity(-dam)

// catch-all for using most items on the wall -- attempt to smash
/turf/closed/wall/proc/try_destroy(obj/item/W, mob/user, turf/T)
	var/dam = get_item_damage(W)
	user.do_attack_animation(src)
	if(!dam)
		to_chat(user, "<span class='warning'>[W] isn't strong enough to damage [src]!</span>")
		playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		return TRUE
	log_combat(user, src, "attacked", W)
	user.visible_message("<span class='danger'>[user] hits [src] with [W]!</span>", \
				"<span class='danger'>You hit [src] with [W]!</span>", null, COMBAT_MESSAGE_RANGE)
	switch(W.damtype)
		if(BRUTE)
			playsound(src,attack_hitsound, 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, TRUE)
	alter_integrity(-dam)
	return TRUE

/turf/closed/wall/proc/get_item_damage(obj/item/I, t_min = min_dam)
	var/dam = I.force
	if(istype(I, /obj/item/clothing/gloves/gauntlets))
		dam = 20
	else if(I.tool_behaviour == TOOL_MINING)
		dam *= (4/3)
	else
		switch(I.damtype)
			if(BRUTE)
				if(I.get_sharpness())
					dam *= 2/3
			if(BURN)
				dam *= burn_mod
			else
				return 0
	// if dam is below t_min, then the hit has no effect
	return (dam < t_min ? 0 : dam)

/turf/closed/wall/proc/get_proj_damage(obj/projectile/P, t_min = min_dam)
	var/dam = P.damage
	if(is_type_in_list(P, extra_dam_proj))
		dam = max(dam, 30)
	else
		switch(P.damage_type)
			if(BRUTE)
				dam *= brute_mod
			if(BURN)
				dam *= burn_mod
			else
				return 0
	// if dam is below t_min, then the hit has no effect
	return (dam < t_min ? 0 : dam)

/turf/closed/wall/proc/dismantle_wall(devastated = FALSE)
	create_sheets()
	var/obj/newgirder = create_girder()
	if(devastated)
		if(newgirder)
			// destroy the girder if we got devastated
			newgirder.deconstruct(FALSE)
	else
		if(newgirder)
			transfer_fingerprints_to(newgirder)
		playsound(src, break_sound, 100, TRUE)

	for(var/obj/structure/sign/poster/P in src.contents) //Eject contents!
		P.roll_and_drop(src)

	ScrapeAway()

/turf/closed/wall/proc/create_sheets()
	if(sheet_type)
		return new sheet_type(src, sheet_amount)
	return null

/turf/closed/wall/proc/create_girder()
	if(girder_type)
		return new girder_type(src)
	return null

/turf/closed/wall/ex_act(severity, target)
	if(target == src || !density)
		return ..()
	switch(severity)
		if(EXPLODE_DEVASTATE)
			// SN src = null
			var/turf/NT = ScrapeAway()
			NT.contents_explosion(severity, target)
			return
		if(EXPLODE_HEAVY)
			alter_integrity(rand(-500, -800))
		if(EXPLODE_LIGHT)
			alter_integrity(rand(-200, -700))


/turf/closed/wall/blob_act(obj/structure/blob/B)
	add_dent(WALL_DENT_HIT)
	alter_integrity(-400)


/turf/closed/wall/mech_melee_attack(obj/mecha/M)
	M.do_attack_animation(src)
	switch(M.damtype)
		if(BRUTE)
			playsound(src, 'sound/weapons/punch4.ogg', 50, TRUE)
		if(BURN)
			playsound(src, 'sound/items/welder.ogg', 100, TRUE)
		if(TOX)
			playsound(src, 'sound/effects/spray2.ogg', 100, TRUE)


	if(prob(hardness + M.force) && M.force > 20)
		M.visible_message("<span class='danger'>[M.name] hits [src] with great force!</span>", \
					"<span class='danger'>You hit [src] with incredible force!</span>", null, COMBAT_MESSAGE_RANGE)
		dismantle_wall(devastated = TRUE)
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	else
		M.visible_message("<span class='danger'>[M.name] hits [src]!</span>", \
					"<span class='danger'>You hit [src]!</span>", null, COMBAT_MESSAGE_RANGE)
		add_dent(WALL_DENT_HIT)
		alter_integrity(M.force * 20)

/turf/closed/wall/attack_paw(mob/living/user)
	user.changeNext_move(CLICK_CD_MELEE)
	return attack_hand(user)

/turf/closed/wall/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if((M.environment_smash & ENVIRONMENT_SMASH_WALLS) || (M.environment_smash & ENVIRONMENT_SMASH_RWALLS))
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
		alter_integrity(-400)
		return

/turf/closed/wall/attack_hulk(mob/living/carbon/user)
	..()
	var/obj/item/bodypart/arm = user.hand_bodyparts[user.active_hand_index]
	if(!arm || arm.bodypart_disabled)
		return
	alter_integrity(-250)
	add_dent(WALL_DENT_HIT)
	user.visible_message("<span class='danger'>[user] smashes \the [src]!</span>", \
				"<span class='danger'>You smash \the [src]!</span>", \
				"<span class='hear'>You hear a booming smash!</span>")
	return TRUE

/turf/closed/wall/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	to_chat(user, "<span class='notice'>You push the wall but nothing happens!</span>")
	playsound(src, 'sound/weapons/genhit.ogg', 25, TRUE)
	add_fingerprint(user)

/turf/closed/wall/attackby(obj/item/W, mob/user, params)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!user.IsAdvancedToolUser())
		to_chat(user, "<span class='warning'>You don't have the dexterity to do this!</span>")
		return

	//get the user's location
	if(!isturf(user.loc))
		return	//can't do this stuff whilst inside objects and such

	add_fingerprint(user)

	var/turf/T = user.loc	//get user's location for delay checks

	//the istype cascade has been spread among various procs for easy overriding
	if(try_clean(W, user, T) || try_wallmount(W, user, T) || try_decon(W, user, T) || try_destroy(W, user, T))
		return

	return ..()

/turf/closed/wall/proc/try_clean(obj/item/W, mob/user, turf/T)
	if((user.a_intent != INTENT_HELP))
		return FALSE

	if(W.tool_behaviour == TOOL_WELDER)
		if(!W.tool_start_check(user, amount=0) || (integrity >= max_integrity))
			return FALSE

		to_chat(user, "<span class='notice'>You begin fixing dents on the wall...</span>")
		if(W.use_tool(src, user, slicing_duration, volume=100))
			if(iswallturf(src) && LAZYLEN(dent_decals))
				to_chat(user, "<span class='notice'>You fix some dents on the wall.</span>")
				dent_decals = null
				update_appearance()
			alter_integrity(repair_amount)
			return TRUE

	return FALSE

/turf/closed/wall/proc/try_wallmount(obj/item/W, mob/user, turf/T)
	//check for wall mounted frames
	if(istype(W, /obj/item/wallframe))
		var/obj/item/wallframe/F = W
		if(F.try_build(src, user))
			F.attach(src, user)
		return TRUE
	//Poster stuff
	else if(istype(W, /obj/item/poster))
		place_poster(W,user)
		return TRUE

	return FALSE

/turf/closed/wall/proc/try_decon(obj/item/I, mob/user, turf/T)
	if(I.tool_behaviour == TOOL_WELDER)
		if(!I.tool_start_check(user, amount=0))
			return FALSE

		to_chat(user, "<span class='notice'>You begin slicing through the outer plating...</span>")
		while(I.use_tool(src, user, slicing_duration, volume=50))
			if(iswallturf(src))
				to_chat(user, "<span class='notice'>You slice through some of the outer plating...</span>")
				alter_integrity(-(I.wall_decon_damage),FALSE,TRUE)

	return FALSE

/turf/closed/wall/singularity_pull(S, current_size)
	..()
	wall_singularity_pull(current_size)

/turf/closed/wall/proc/wall_singularity_pull(current_size)
	if(current_size >= STAGE_FIVE)
		if(prob(50))
			dismantle_wall()
		return
	if(current_size == STAGE_FOUR)
		if(prob(30))
			dismantle_wall()

/turf/closed/wall/narsie_act(force, ignore_mobs, probability = 20)
	. = ..()
	if(.)
		ChangeTurf(/turf/closed/wall/mineral/cult)

/turf/closed/wall/get_dumping_location(obj/item/storage/source, mob/user)
	return null

/turf/closed/wall/acid_act(acidpwr, acid_volume)
	if(explosion_block >= 2)
		acidpwr = min(acidpwr, 50) //we reduce the power so strong walls never get melted.
	. = ..()

/turf/closed/wall/acid_melt()
	dismantle_wall(devastated = TRUE)

/turf/closed/wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 40, "cost" = 26)
	return FALSE

/turf/closed/wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	switch(passed_mode)
		if(RCD_DECONSTRUCT)
			to_chat(user, "<span class='notice'>You deconstruct the wall.</span>")
			ScrapeAway()
			return TRUE
	return FALSE

/turf/closed/wall/proc/add_dent(denttype, x=rand(-8, 8), y=rand(-8, 8))
	if(LAZYLEN(dent_decals) >= MAX_DENT_DECALS)
		return

	var/mutable_appearance/decal = mutable_appearance('icons/effects/effects.dmi', "", BULLET_HOLE_LAYER)
	switch(denttype)
		if(WALL_DENT_SHOT)
			decal.icon_state = "bullet_hole"
		if(WALL_DENT_HIT)
			decal.icon_state = "impact[rand(1, 3)]"

	decal.pixel_x = x
	decal.pixel_y = y
	LAZYADD(dent_decals, decal)
	update_appearance()

#undef MAX_DENT_DECALS
