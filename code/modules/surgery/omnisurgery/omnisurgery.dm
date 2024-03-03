/datum/surgery/omni
	name = "Omni-surgery"
	desc = "allows multiple surgeries on one part based on tissue layers"
	status = 1
	steps = list()										//We ballin
	target_mobtypes = list(/mob/living/carbon/human)	//Acceptable Species
	possible_locs = list(BODY_ZONE_CHEST,BODY_ZONE_HEAD,BODY_ZONE_L_ARM,BODY_ZONE_L_LEG,BODY_ZONE_R_ARM,BODY_ZONE_R_LEG)
	speed_modifier = 1									//Step speed modifier
	var/atlayer = 0										// 0/1/2 skin/muscle/bone
	var/datum/surgery_step/omni/last_step				//The last step preformed in the surgery

/datum/surgery/omni/next_step(mob/user, intent)
	if(location != user.zone_selected)
		return FALSE
	if(step_in_progress)
		return TRUE

	var/try_to_fail = FALSE
	if(intent == INTENT_DISARM)
		try_to_fail = TRUE
	var/obj/item/tool = user.get_active_held_item()
	var/list/L = get_surgery_step(tool,user,target)
	if(L)
		var/datum/surgery_step/omni/S = null
		if(L.len == 1)
			var/datum/surgery_step/omni/val = L[1]
			S = new val.type
		else
			var/P = show_radial_menu(user,target,L,require_near = TRUE)
			if(P && user && user.Adjacent(target) && (tool in user))
				var/datum/surgery_step/omni/T = locate(P) in L // Why tf does L[P] not work here.
				for(var/datum/surgery/other in target.surgeries)
					if(other == src)
						continue
					if(other.location == user.zone_selected)
						return FALSE
				S = new T.type
		if(S)
			if(S.try_op(user, target, user.zone_selected, tool, src, try_to_fail))
				last_step = S
				return TRUE
	return FALSE

/datum/surgery/omni/get_surgery_step(obj/item/tool,mob/user,mob/living/target)
	var/list/all_steps = GLOB.omnisurgerysteps_list.Copy()
	var/list/valid_steps = list()
	for(var/datum/surgery_step/omni/S in all_steps)
		if(!S.show)
			continue
		if(!(location in S.valid_locations))
			continue
		if(!(atlayer in S.required_layer))
			continue
		if(!(S.accept_any_item || S.accept_hand))
			var/good = FALSE
			for(var/obj in S.implements)
				if(istype(tool,obj))
					good = TRUE
					break
				if((tool.tool_behaviour in S.implements) || (tool in S.implements))
					good = TRUE
					break
			if (!good)
				continue
		if(!S.test_op(user,target,src))
			continue
		valid_steps[S] = S.radial_icon != null ? S.radial_icon : null
	return valid_steps

/datum/surgery/omni/get_surgery_next_step()
	return null
