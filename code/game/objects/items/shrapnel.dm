/obj/item/shrapnel // frag grenades
	name = "shrapnel shard"
	embedding = list(embed_chance=70, ignore_throwspeed_threshold=TRUE, fall_chance=4, embed_chance_turf_mod=-100)
	custom_materials = list(/datum/material/iron=50)
	armour_penetration = -20
	icon = 'icons/obj/shards.dmi'
	icon_state = "large"
	w_class = WEIGHT_CLASS_TINY
	item_flags = DROPDEL

/obj/item/shrapnel/hot
	name = "molten slag"
	embedding = list(embed_chance=70, ignore_throwspeed_threshold=TRUE, fall_chance=4, embed_chance_turf_mod=-100)
	damtype =  BURN

/obj/item/shrapnel/stingball
	name = "clump of ballistic gel"
	embedding = list(embed_chance=15, fall_chance=1, jostle_chance=7, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.8, pain_mult=3, jostle_pain_mult=5, rip_time=15, embed_chance_turf_mod=-100)
	icon_state = "tiny"

/obj/item/shrapnel/bullet // bullets
	name = "bullet"
	icon = 'icons/obj/ammo_bullets.dmi'
	icon_state = "pistol-brass"
	item_flags = NONE

/obj/item/shrapnel/bullet/c38 // .38 round
	name = "\improper .38 bullet"

/obj/item/shrapnel/bullet/c38/dumdum // .38 DumDum round
	name = "\improper .38 DumDum bullet"
	embedding = list(embed_chance=70, fall_chance=7, jostle_chance=7, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10, embed_chance_turf_mod=-100)

/obj/projectile/bullet/shrapnel
	name = "flying shrapnel shard"
	damage = 12
	range = 10
	armour_penetration = -20
	dismemberment = 10
	ricochets_max = 2
	ricochet_chance = 40
	shrapnel_type = /obj/item/shrapnel
	ricochet_incidence_leeway = 60
	hit_stunned_targets = TRUE

/obj/projectile/bullet/shrapnel/rusty
	damage = 10
	armour_penetration = -35
	dismemberment = 5
	ricochets_max = 3//duller = less likely to stick in a wall
	ricochet_chance = 60

/obj/projectile/bullet/shrapnel/mega
	name = "flying shrapnel hunk"
	range = 25
	dismemberment = 10
	ricochets_max = 4
	ricochet_chance = 90
	ricochet_decay_chance = 0.9

/obj/projectile/bullet/shrapnel/hot
	name = "white-hot metal slag"
	damage = 4//soft
	range = 8
	armour_penetration = -45
	dismemberment = 4
	ricochets_max = 1
	ricochet_chance = 60
	shrapnel_type = /obj/item/shrapnel/hot
	ricochet_incidence_leeway = 60
	hit_stunned_targets = TRUE
	damage_type = BURN

/obj/projectile/bullet/shrapnel/hot/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(8)
		M.IgniteMob()

/obj/projectile/bullet/pellet/stingball
	name = "ballistic gel clump"
	damage = 1
	stamina = 12
	ricochets_max = 6
	ricochet_chance = 66
	ricochet_decay_chance = 1
	ricochet_decay_damage = 0.9
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 2
	ricochet_incidence_leeway = 0
	knockdown = 20
	shrapnel_type = /obj/item/shrapnel/stingball

/obj/projectile/bullet/pellet/stingball/mega
	name = "megastingball pellet"
	ricochets_max = 6
	ricochet_chance = 110

/obj/projectile/bullet/pellet/stingball/on_ricochet(atom/A)
	hit_stunned_targets = TRUE // ducking will save you from the first wave, but not the rebounds
