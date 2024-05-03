#define BANDAGE_DAMAGE_COEFF 5

/datum/component/bandage
	/// How much damage do we heal?
	var/healing_speed = 0.2
	/// How fast do we stop bleeding?
	var/bleed_reduction = 0.2
	/// How many healing ticks will this bandage apply? Reduced by incoming damage and other nasties
	var/durability = 300
	/// What is dropped when the bandage is removed?
	var/trash_item = null
	var/bandage_name = "gauze"
	/// The person this bandage is applied to
	var/mob/living/mummy

/datum/component/bandage/Initialize(_healing_speed, _durability, _bandage_name, _trash_item)
	if(!istype(parent, /obj/item/bodypart))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/bodypart/BP = parent
	mummy = BP.owner
	if(!mummy)
		return COMPONENT_INCOMPATIBLE
	if(_healing_speed)
		healing_speed = _healing_speed
	if(_durability)
		durability = _durability
	if(_bandage_name)
		bandage_name = _bandage_name
	if(_trash_item)
		trash_item = _trash_item
	RegisterSignal(mummy, COMSIG_MOB_APPLY_DAMGE, PROC_REF(check_damage))
	RegisterSignal(mummy, COMSIG_MOB_LIFE, PROC_REF(bandage_effects))

/datum/component/bandage/proc/check_damage(damage, damagetype = BRUTE, def_zone = null)
	if(parent != mummy.get_bodypart(check_zone(def_zone)))
		return
	durability = durability - damage * BANDAGE_DAMAGE_COEFF
	if(durability <= 0)
		drop_bandage()


/datum/component/bandage/proc/bandage_effects()
	var/obj/item/bodypart/heal_target = parent
	var/actual_heal_speed = healing_speed //TODO: add modifiers to this (scope 2)
	heal_target.heal_damage(actual_heal_speed, actual_heal_speed)
	durability--
	if(heal_target.bleeding)
		durability = round(durability - max(heal_target.bleeding, 1))
		heal_target.adjust_bleeding(-bleed_reduction)
	if(durability <= 0 || (!heal_target.bleeding && !heal_target.get_damage()))
		drop_bandage()

/datum/component/bandage/proc/drop_bandage()
	var/obj/item/bodypart/BP = parent
	if(trash_item)
		new trash_item(get_turf(mummy))
		mummy.visible_message(span_notice("The [bandage_name] on [mummy]'s [parse_zone(BP.body_zone)] falls to the floor."), span_notice("The [bandage_name] on your [parse_zone(BP.body_zone)] falls to the floor."))
	else
		to_chat(mummy, span_notice("The [bandage_name] on your [parent] finished healing."))
	qdel(src)

#undef BANDAGE_DAMAGE_COEFF
