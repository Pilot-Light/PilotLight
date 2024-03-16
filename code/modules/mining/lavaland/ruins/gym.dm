/obj/structure/punching_bag
	name = "punching bag"
	desc = "A punching bag. Can you get to speed level 4???"
	icon = 'icons/obj/gym_equipment.dmi'
	icon_state = "punchingbag"
	anchored = TRUE
	layer = WALL_OBJ_LAYER
	var/list/hit_sounds = list('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg',\
	'sound/weapons/punch1.ogg', 'sound/weapons/punch2.ogg', 'sound/weapons/punch3.ogg', 'sound/weapons/punch4.ogg')

/obj/structure/punching_bag/attack_hand(mob/user as mob)
	. = ..()
	if(.)
		return
	flick("[icon_state]-punch", src)
	playsound(loc, pick(hit_sounds), 25, TRUE, -1)
	if(isliving(user))
		var/mob/living/L = user
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "exercise", /datum/mood_event/exercise)
		L.apply_status_effect(STATUS_EFFECT_EXERCISED)

/obj/structure/weightmachine
	name = "weight machine"
	desc = "Just looking at this thing makes you feel tired."
	icon = 'icons/obj/gym_equipment.dmi'
	density = TRUE
	anchored = TRUE
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 5
	var/bolts = TRUE

/obj/structure/weightmachine/proc/AnimateMachine(mob/living/user)
	return

/obj/structure/weightmachine/update_icon_state()
	. = ..()
	icon_state = (obj_flags & IN_USE) ? "[base_icon_state]-u" : base_icon_state

/obj/structure/weightmachine/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	..()

/obj/structure/weightmachine/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct(TRUE)
	else
		return ..()

/obj/structure/weightmachine/examine(mob/user)
	. = ..()
	if(bolts)
		. += "<span class='notice'>It's held together by a couple of <b>bolts</b>.</span>"

/obj/structure/weightmachine/update_overlays()
	. = ..()

	if(obj_flags & IN_USE)
		. += mutable_appearance(icon, "[base_icon_state]-o", layer = ABOVE_MOB_LAYER, alpha = src.alpha)

/obj/structure/weightmachine/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(obj_flags & IN_USE)
		to_chat(user, "<span class='warning'>It's already in use - wait a bit!</span>")
		return
	else
		obj_flags |= IN_USE
		update_appearance()
		user.setDir(SOUTH)
		user.Stun(80)
		user.forceMove(src.loc)
		var/bragmessage = pick("pushing it to the limit","going into overdrive","burning with determination","rising up to the challenge", "getting strong now","getting ripped")
		user.visible_message("<B>[user] is [bragmessage]!</B>")
		AnimateMachine(user)

		playsound(user, 'sound/machines/click.ogg', 60, TRUE)
		obj_flags &= ~IN_USE
		update_appearance()
		user.pixel_y = user.base_pixel_y
		var/finishmessage = pick("You feel stronger!","You feel like you can take on the world!","You feel robust!","You feel indestructible!")
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "exercise", /datum/mood_event/exercise)
		to_chat(user, finishmessage)
		user.apply_status_effect(STATUS_EFFECT_EXERCISED)

/obj/structure/weightmachine/stacklifter
	name = "chest press machine"
	icon_state = "stacklifter"
	base_icon_state = "stacklifter"

/obj/structure/weightmachine/stacklifter/AnimateMachine(mob/living/user)
	var/lifts = 0
	while (lifts++ < 6)
		if (user.loc != src.loc)
			break
		sleep(3)
		animate(user, pixel_y = -2, time = 3)
		sleep(3)
		animate(user, pixel_y = -4, time = 3)
		sleep(3)
		playsound(user, 'sound/machines/creak.ogg', 60, TRUE)

/obj/structure/weightmachine/weightlifter
	name = "inline bench press"
	icon_state = "benchpress"
	base_icon_state = "benchpress"

/obj/structure/weightmachine/weightlifter/AnimateMachine(mob/living/user)
	var/reps = 0
	user.pixel_y = 5
	while (reps++ < 6)
		if (user.loc != src.loc)
			break
		for (var/innerReps = max(reps, 1), innerReps > 0, innerReps--)
			sleep(4)
			animate(user, pixel_y = (user.pixel_y == 3) ? 5 : 3, time = 3)
		playsound(user, 'sound/machines/creak.ogg', 60, TRUE)
	sleep(3)
	animate(user, pixel_y = 2, time = 3)
	sleep(3)
