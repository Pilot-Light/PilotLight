//////////////
//Jumpsuits//
/////////////

/obj/item/clothing/under/suit/roumain
	name = "saint-roumain's worksuit"
	desc = "A simple, hard-wearing suit designed for the hardworking hunters of the Saint-Roumain Militia."
	icon_state = "rouma_work"
	item_state = "rouma_work"
	can_adjust = FALSE
	icon = 'icons/obj/clothing/faction/srm/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/srm/uniforms.dmi'

//////////////////
//Armored suits//
/////////////////

/obj/item/clothing/suit/armor/roumain
	name = "saint-roumain duster"
	desc = "A coat made from hard leather. Meant to withstand long hunts in harsh wilderness."
	icon_state = "armor_rouma"
	item_state = "rouma_coat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	icon = 'icons/obj/clothing/faction/srm/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/srm/suits.dmi'

/obj/item/clothing/suit/armor/roumain/shadow
	name = "saint-roumain shadow duster"
	desc = "A coat made from hard leather. Its rough, barely-treated finish is typical of one of the Saint-Roumain Militia's trainees."
	icon_state = "armor_rouma_shadow"
	item_state = "rouma_shadow_coat"

/obj/item/clothing/suit/toggle/labcoat/roumain_med
	name = "saint-roumain medical duster"
	desc = "A coat made from hard leather and further treated with exotic sterilizing oils and wax. The treatment and its more closed design offers much better protection against biological hazards."
	icon = 'icons/obj/clothing/faction/srm/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/srm/suits.dmi'
	icon_state = "rouma_med_coat"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/hazardvest/roumain
	name = "saint-roumain machinist leather vest"
	desc = "A modified Roumain leather duster with its large flaps and sleeves cut off to provide extra mobility when maintaining weapons and vessels belonging to the Church of Saint Roumain. Its specialty treatment grants it better protection against acid and fire."
	icon = 'icons/obj/clothing/faction/srm/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/srm/suits.dmi'
	icon_state = "armor_rouma_machinist"
	item_state = "rouma_coat"
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 40, "bomb" = 35, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)

/obj/item/clothing/suit/armor/roumain/flamebearer
	name = "saint-roumain flamebearer robes"
	desc = "A set of ashy-grey robes made from hard leather, adorned with gold trims. Its rough finish after a near-char and application of aromatics is heavily favored for the ecclesiastical sect of the Church of Saint Roumain, a living reminder of the Ashen Huntsman himself."
	icon_state = "armor_rouma_flamebearer"

/obj/item/clothing/suit/armor/roumain/colligne
	name = "saint-roumain colligne coat"
	desc = "A well-maintained hard leather coat typically worn to denote the rank of Colligne, a trainee Hunter Montagne. It is treated with bullet-resistant materials, and lined with the dark fur of Illestrenin dire wolves."
	icon_state = "armor_rouma_colligne"
	item_state = "rouma_coat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/armor/roumain/montagne
	name = "saint-roumain montagne coat"
	desc = "A stylish red coat to indicate that you are, in fact, a Hunter Montagne. Made of extra hard exotic leather, treated with bullet-resistant materials, and lined with the fur of some unidentifiable creature."
	icon_state = "armor_rouma_montagne"
	item_state = "rouma_montagne_coat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 90)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

///////////////
//Spacesuits//
//////////////

/obj/item/clothing/head/helmet/space/hardsuit/solgov/roumain
	name = "\improper roumain hardsuit helmet"
	desc = "An armor-plated knight's helmet, the pointed design of it reminiscent of iconography depicting the great Ashen Huntsman."
	icon = 'icons/obj/clothing/faction/srm/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/srm/head.dmi'
	icon_state = "hardsuit0-roumain"
	item_state = "hardsuit0-roumain"
	hardsuit_type = "roumain"
	worn_y_offset = 4

/obj/item/clothing/suit/space/hardsuit/solgov/roumain
	name = "\improper roumain hardsuit"
	desc = "A modified knight's plate armor turned into a space-worthy hardsuit. A powered exoskeleton hidden behind the plates help grant it slight maneuverability."
	icon = 'icons/obj/clothing/faction/srm/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/srm/suits.dmi'
	icon_state = "hardsuit-roumain"
	item_state = "hardsuit-roumain"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/solgov/roumain
	slowdown = 0.5

/////////
//Hats//
////////

/obj/item/clothing/head/cowboy/sec/roumain
	name = "hunter's hat"
	desc = "A fancy hat with a nice feather. The way it covers your eyes makes you feel like a badass."
	icon_state = "rouma_hat"
	icon = 'icons/obj/clothing/faction/srm/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/srm/head.dmi'

/obj/item/clothing/head/cowboy/sec/roumain/shadow
	name = "shadow's hat"
	desc = "A rough, simple hat. The way it covers your eyes makes you feel badass, but you just look like a wannabe hunter."
	icon_state = "rouma_shadow_hat"

/obj/item/clothing/head/cowboy/sec/roumain/machinist
	name = "machinist's hat"
	desc = "A small, humble leather top hat. It gives you the gnawing urge to create classical gizmos and goobers, or alternatively repair any breaches within your vessel."
	icon_state = "rouma_machinist_hat"

/obj/item/clothing/head/cowboy/sec/roumain/med
	name = "medical hunter's hat"
	desc = "A very wide-brimmed, round hat treated with oil and wax. Somehow manages to look stylish and creepy at the same time."
	icon_state = "rouma_med_hat"

/obj/item/clothing/head/cowboy/sec/roumain/flamebearer
	name = "flamebearer's hat"
	desc = "A wide-brimmed, pointed hat with charred leather, granting it an ash-grey appearance. The design honors the one the Ashen Huntsman himself wore, according to legend."
	icon_state = "rouma_flamebearer_hat"

/obj/item/clothing/head/cowboy/sec/roumain/colligne
	name = "colligne's hat"
	desc = "A fancy, pointy leather hat with a large feather plume to signal that you are, in fact... A Hunter Colligne. You still have some ways to go before you gain the title of Montagne."
	icon_state = "rouma_colligne_hat"

/obj/item/clothing/head/cowboy/sec/roumain/montagne
	name = "montagne's hat"
	desc = "A very fancy hat with a large feather plume to signal that you are, in fact, a Hunter Montagne. The exotic fur lining is impeccably soft and bafflingly bulletproof."
	icon_state = "rouma_montagne_hat"

///////////////
//Accessories//
///////////////

//These are stored in clothing/accessories.dmi instead of a factional variant due to accessory code being dogwater
//Please transfer them over to a factional file if accessory code is ever fixed

/obj/item/clothing/accessory/waistcoat/roumain
	name = "roumain waistcoat"
	desc = "A warm, red wool waistcoat, worn by any member of the Church of Saint Roumain, though heavily favored by Machinists for the added warmth given to their rather breezy outfit."
	icon_state = "rouma_waistcoat"
	icon = 'icons/obj/clothing/accessories.dmi'
	mob_overlay_icon = 'icons/mob/clothing/accessories.dmi'
	minimize_when_attached = TRUE
