/obj/effect/survey_point //sure effects shouldn't be attackable, sue me.
	name = "Survey Point"
	desc = "A location of particular survey value."


/obj/machinery/flasher/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if (W.tool_behaviour == TOOL_WIRECUTTER)
		if (bulb)
			user.visible_message("<span class='notice'>[user] begins to disconnect [src]'s flashbulb.</span>", "<span class='notice'>You begin to disconnect [src]'s flashbulb...</span>")
			if(W.use_tool(src, user, 30, volume=50) && bulb)
				user.visible_message("<span class='notice'>[user] disconnects [src]'s flashbulb!</span>", "<span class='notice'>You disconnect [src]'s flashbulb.</span>")
				bulb.forceMove(loc)
				bulb = null
				power_change()

	else if (istype(W, /obj/item/assembly/flash/handheld))
		if (!bulb)
			if(!user.transferItemToLoc(W, src))
				return
			user.visible_message("<span class='notice'>[user] installs [W] into [src].</span>", "<span class='notice'>You install [W] into [src].</span>")
			bulb = W
			power_change()
		else
			to_chat(user, "<span class='warning'>A flashbulb is already installed in [src]!</span>")

	else if (W.tool_behaviour == TOOL_WRENCH)
		if(!bulb)
			to_chat(user, "<span class='notice'>You start unsecuring the flasher frame...</span>")
			if(W.use_tool(src, user, 40, volume=50))
				to_chat(user, "<span class='notice'>You unsecure the flasher frame.</span>")
				deconstruct(TRUE)
		else
			to_chat(user, "<span class='warning'>Remove a flashbulb from [src] first!</span>")
	else
		return ..()


/obj/item/survey_handheld/attack_self(mob/user)
	if(active)
		return

	var/turf/src_turf = get_turf(src)

	var/my_z = "[virtual_z()]"
	if(z_active[my_z])
		flick(icon_state + "-corrupted", src)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 20)
		src_turf.visible_message("<span class='warning'>Warning: interference detected in current sector</span>")
		return

	if(!z_history[my_z])
		z_history[my_z] = 1

	active = TRUE
	z_active[my_z] = TRUE
	while(user.get_active_held_item() == src)
		to_chat(user, "<span class='notice'>You begin to scan your surroundings with [src].</span>")

		var/penalty = 1 - (z_history[my_z] - 1) * 0.05 // You lose five percent of value and are five percent slower
		if(!penalty || penalty < 0.20) // If you are below 20% value, do nothing and abort
			flick(icon_state + "-corrupted", src)
			playsound(src, 'sound/machines/buzz-sigh.ogg', 20)
			src_turf.visible_message("<span class='warning'>Warning: unable to locate valuable information in current sector.</span>")
			break

		if(!do_after_mob(user, list(src), survey_delay / penalty))
			flick(icon_state + "-corrupted", src)
			playsound(src, 'sound/machines/buzz-sigh.ogg', 20)
			src_turf.visible_message("<span class='warning'>Warning: results corrupted. Please try again.</span>")
			break

		flick(icon_state + "print", src)
		playsound(src, 'sound/machines/whirr_beep.ogg', 20)
		src_turf.visible_message("<span class='notice'>Data recorded and enscribed to research packet.</span>")
		z_history[my_z]++

		var/obj/item/result = new /obj/item/research_notes(null, survey_value * penalty, pick(list("astronomy", "physics", "planets", "space")))

		var/obj/item/research_notes/notes = locate() in get_turf(user)
		if(notes)
			notes.merge(result)
		else if(!user.put_in_hands(result) && istype(user.get_inactive_held_item(), /obj/item/research_notes))
			var/obj/item/research_notes/research = user.get_inactive_held_item()
			research.merge(result)
			continue

	active = FALSE
	z_active[my_z] = FALSE
