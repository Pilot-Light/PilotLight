/datum/species/snail //if anything breaks regarding these guys ping Sylph#2723 to fix it
	name = "\improper Snail person"
	id = SPECIES_SNAIL
	default_color = "336600" //vomit green
	mutant_bodyparts = list("shells")
	default_features = list("shells" = "Cinnamonshell")
	species_traits = list(MUTCOLORS,HAIR,EYECOLOR,HAIR,FACEHAIR)
	inherent_traits = list(TRAIT_ALWAYS_CLEAN, TRAIT_NOSLIPALL)
	liked_food = VEGETABLES | FRUIT | GROSS | RAW
	disliked_food = DAIRY | SUGAR
	attack_verb = "slap"
	coldmod = 0.6 //snails only come out when its cold and wet
	burnmod = 2
	speedmod = 6
	punchdamagehigh = 0.5 //snails are soft and squishy
	siemens_coeff = 2 //snails are mostly water
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP
	var/shell_type = /obj/item/storage/backpack/duffelbag/snail
	loreblurb = "Humans with heavy genetic modifications from a snail. One of the rarer types of the rarer human genelines."

	mutanteyes = /obj/item/organ/eyes/snail
	mutanttongue = /obj/item/organ/tongue/snail

	species_chest = /obj/item/bodypart/chest/snail
	species_head = /obj/item/bodypart/head/snail
	species_l_arm = /obj/item/bodypart/l_arm/snail
	species_r_arm = /obj/item/bodypart/r_arm/snail
	species_l_leg = /obj/item/bodypart/l_leg/snail
	species_r_leg = /obj/item/bodypart/r_leg/snail

/datum/species/snail/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/consumable/sodiumchloride)
		H.adjustFireLoss(2)
		playsound(H, 'sound/weapons/sear.ogg', 30, TRUE)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return TRUE
	return ..()

/datum/species/snail/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		switch(H.dna.features["shells"])
			if("Cinnamonshell")
				shell_type = /obj/item/storage/backpack/duffelbag/snail
			if("Coneshell")
				shell_type = /obj/item/storage/backpack/duffelbag/snail/cone
			if("Caramelshell")
				shell_type = /obj/item/storage/backpack/duffelbag/snail/caramel

	var/obj/item/storage/backpack/bag = C.get_item_by_slot(ITEM_SLOT_BACK)
	if(!istype(bag, /obj/item/storage/backpack/duffelbag/snail))
		if(C.dropItemToGround(bag)) //returns TRUE even if its null
			C.equip_to_slot_or_del(new shell_type(C), ITEM_SLOT_BACK)
	C.AddElement(/datum/element/snailcrawl)

/datum/species/snail/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.RemoveElement(/datum/element/snailcrawl)
	var/obj/item/storage/backpack/bag = C.get_item_by_slot(ITEM_SLOT_BACK)
	if(istype(bag, /obj/item/storage/backpack/duffelbag/snail))
		bag.emptyStorage()
		C.temporarilyRemoveItemFromInventory(bag, TRUE)
		qdel(bag)

/obj/item/storage/backpack/duffelbag/snail
	name = "snail shell"
	desc = "Worn by snails as armor and storage compartment."
	icon_state = "cinnamonshell"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	max_integrity = 200
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = 0

/obj/item/storage/backpack/duffelbag/snail/cone
	name = "cone snail shell"
	desc = "Worn by snails as armor and storage compartment. This one is cone-shaped!"
	icon_state = "coneshell"

/obj/item/storage/backpack/duffelbag/snail/caramel
	icon_state = "caramelshell"

/obj/item/storage/backpack/duffelbag/snail/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "snailshell")
