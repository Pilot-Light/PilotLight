//lobectomy, removes the most damaged lung lobe with a 95% base success chance
/datum/surgery_step/omni/lobectomy
	name = "excise damaged lung node"
	implements = list(
		TOOL_SCALPEL = 95,
		/obj/item/melee/transforming/energy/sword = 33,
		/obj/item/kitchen/knife = 40,
		/obj/item/shard = 25)
	time = 4.2 SECONDS
	preop_sound = 'sound/surgery/scalpel1.ogg'
	success_sound = 'sound/surgery/organ1.ogg'
	failure_sound = 'sound/surgery/organ2.ogg'
	experience_given = MEDICAL_SKILL_ORGAN_FIX
	required_layer = list(2)
	show = TRUE
	valid_locations = list(BODY_ZONE_CHEST)

/datum/surgery_step/omni/lobectomy/test_op(mob/user, mob/living/target, datum/surgery/omni/surgery)
	var/obj/item/organ/lungs/L = target.getorganslot(ORGAN_SLOT_LUNGS)
	if(L)
		if(L.damage > 60 && !L.operated)
			return TRUE
	return FALSE

/datum/surgery_step/omni/lobectomy/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to make an incision in [target]'s lungs...</span>",
		"<span class='notice'>[user] begins to make an incision in [target].</span>",
		"<span class='notice'>[user] begins to make an incision in [target].</span>")

/datum/surgery_step/omni/lobectomy/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/obj/item/organ/lungs/L = H.getorganslot(ORGAN_SLOT_LUNGS)
		L.operated = TRUE
		H.setOrganLoss(ORGAN_SLOT_LUNGS, 25)
		display_results(user, target, "<span class='notice'>You successfully excise [H]'s most damaged lobe.</span>",
			"<span class='notice'>Successfully removes a piece of [H]'s lungs.</span>",
			"")
	return ..()

/datum/surgery_step/omni/lobectomy/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		display_results(user, target, "<span class='warning'>You screw up, failing to excise [H]'s damaged lobe!</span>",
			"<span class='warning'>[user] screws up!</span>",
			"<span class='warning'>[user] screws up!</span>")
		H.losebreath += 10
		H.adjustOrganLoss(ORGAN_SLOT_LUNGS, 20)
	return FALSE
