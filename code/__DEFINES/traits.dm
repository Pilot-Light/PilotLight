#define SIGNAL_ADDTRAIT(trait_ref) "addtrait [trait_ref]"
#define SIGNAL_REMOVETRAIT(trait_ref) "removetrait [trait_ref]"

// trait accessor defines
#define ADD_TRAIT(target, trait, source) \
	do { \
		var/list/_L; \
		if (!target.status_traits) { \
			target.status_traits = list(); \
			_L = target.status_traits; \
			_L[trait] = list(source); \
			SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait)); \
		} else { \
			_L = target.status_traits; \
			if (_L[trait]) { \
				_L[trait] |= list(source); \
			} else { \
				_L[trait] = list(source); \
				SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait)); \
			} \
		} \
	} while (0)
#define REMOVE_TRAIT(target, trait, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources \
		}; \
		if (_L && _L[trait]) { \
			for (var/_T in _L[trait]) { \
				if ((!_S && (_T != ROUNDSTART_TRAIT)) || (_T in _S)) { \
					_L[trait] -= _T \
				} \
			}; \
			if (!length(_L[trait])) { \
				_L -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait)); \
			}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAIT_NOT_FROM(target, trait, sources) \
	do { \
		var/list/_traits_list = target.status_traits; \
		var/list/_sources_list; \
		if (sources && !islist(sources)) { \
			_sources_list = list(sources); \
		} else { \
			_sources_list = sources\
		}; \
		if (_traits_list && _traits_list[trait]) { \
			for (var/_trait_source in _traits_list[trait]) { \
				if (!(_trait_source in _sources_list)) { \
					_traits_list[trait] -= _trait_source \
				} \
			};\
			if (!length(_traits_list[trait])) { \
				_traits_list -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait), trait); \
			}; \
			if (!length(_traits_list)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_NOT_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] &= _S; \
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T)); \
					}; \
				}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] -= _S;\
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T)); \
					}; \
				};\
			if (!length(_L)) { \
				target.status_traits = null\
			};\
		}\
	} while (0)
#define HAS_TRAIT(target, trait) (target.status_traits ? (target.status_traits[trait] ? TRUE : FALSE) : FALSE)
#define HAS_TRAIT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (source in target.status_traits[trait]) : FALSE) : FALSE)
#define HAS_TRAIT_FROM_ONLY(target, trait, source) ( \
	target.status_traits ? \
		(target.status_traits[trait] ? \
			((source in target.status_traits[trait]) && (length(target.status_traits) == 1)) \
			: FALSE) \
		: FALSE)
#define HAS_TRAIT_NOT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (length(target.status_traits[trait] - source) > 0) : FALSE) : FALSE)

/*
Remember to update _globalvars/traits.dm if you're adding/removing/renaming traits.
*/

//mob traits
/// Forces the user to stay unconscious.
#define TRAIT_KNOCKEDOUT "knockedout"
/// Prevents voluntary movement.
#define TRAIT_IMMOBILIZED "immobilized"
/// Prevents voluntary standing or staying up on its own.
#define TRAIT_FLOORED "floored"
/// Prevents usage of manipulation appendages (picking, holding or using items, manipulating storage).
#define TRAIT_HANDS_BLOCKED "handsblocked"
/// Inability to access UI hud elements. Turned into a trait from [MOBILITY_UI] to be able to track sources.
#define TRAIT_UI_BLOCKED "uiblocked"
/// Inability to pull things. Turned into a trait from [MOBILITY_PULL] to be able to track sources.
#define TRAIT_PULL_BLOCKED "pullblocked"
/// Abstract condition that prevents movement if being pulled and might be resisted against. Handcuffs and straight jackets, basically.
#define TRAIT_RESTRAINED "restrained"
#define TRAIT_INCAPACITATED "incapacitated"
///In some kind of critical condition. Is able to succumb.
#define TRAIT_CRITICAL_CONDITION "critical-condition"
/// Doesn't miss attacks
#define TRAIT_PERFECT_ATTACKER "perfect_attacker"
#define TRAIT_BLIND "blind"
#define TRAIT_DEAF "deaf"
#define TRAIT_MUTE "mute"
#define TRAIT_EMOTEMUTE "emotemute"
#define TRAIT_NEARSIGHT "nearsighted"
#define TRAIT_FAT "fat"
#define TRAIT_HUSK "husk"
#define TRAIT_BADDNA "baddna"
#define TRAIT_CLUMSY "clumsy"
#define TRAIT_CHUNKYFINGERS "chunkyfingers" //means that you can't use weapons with normal trigger guards.
#define TRAIT_DUMB "dumb"
#define TRAIT_MONKEYLIKE "monkeylike" //sets IsAdvancedToolUser to FALSE
#define TRAIT_PACIFISM "pacifism"
#define TRAIT_IGNORESLOWDOWN "ignoreslow"
#define TRAIT_IGNOREDAMAGESLOWDOWN "ignoredamageslowdown"
#define TRAIT_DEATHCOMA "deathcoma" //Causes death-like unconsciousness
#define TRAIT_FAKEDEATH "fakedeath" //Makes the owner appear as dead to most forms of medical examination
#define TRAIT_DISFIGURED "disfigured"
#define TRAIT_XENO_HOST "xeno_host"	//Tracks whether we're gonna be a baby alien's mummy.
#define TRAIT_STUNIMMUNE "stun_immunity"
#define TRAIT_STUNRESISTANCE "stun_resistance"
#define TRAIT_IWASBATONED "iwasbatoned" //Anti Dual-baton cooldown bypass exploit.
#define TRAIT_SLEEPIMMUNE "sleep_immunity"
#define TRAIT_PUSHIMMUNE "push_immunity"
#define TRAIT_SHOCKIMMUNE "shock_immunity"
#define TRAIT_TESLA_SHOCKIMMUNE "tesla_shock_immunity"
#define TRAIT_STABLEHEART "stable_heart"
#define TRAIT_STABLELIVER "stable_liver"
#define TRAIT_RESISTHEAT "resist_heat"
#define TRAIT_RESISTHEATHANDS "resist_heat_handsonly" //For when you want to be able to touch hot things, but still want fire to be an issue.
#define TRAIT_RESISTCOLD "resist_cold"
#define TRAIT_RESISTHIGHPRESSURE "resist_high_pressure"
#define TRAIT_RESISTLOWPRESSURE "resist_low_pressure"
#define TRAIT_BOMBIMMUNE "bomb_immunity"
#define TRAIT_RADIMMUNE "rad_immunity"
#define TRAIT_GENELESS "geneless"
#define TRAIT_VIRUSIMMUNE "virus_immunity"
#define TRAIT_PIERCEIMMUNE "pierce_immunity"
#define TRAIT_NODISMEMBER "dismember_immunity"
#define TRAIT_LAVA_IMMUNE "lava_immunity"
#define TRAIT_SNOWSTORM_IMMUNE "snow_immunity"
#define TRAIT_ASHSTORM_IMMUNE "ash_immunity"
#define TRAIT_SANDSTORM_IMMUNE "sand_immunity"
#define TRAIT_NOFIRE "nonflammable"
/// Prevents plasmamen from self-igniting if only their helmet is missing
#define TRAIT_NOSELFIGNITION_HEAD_ONLY "no_selfignition_head_only"
#define TRAIT_NOGUNS "no_guns"
#define TRAIT_NOHUNGER "no_hunger"
#define TRAIT_NOMETABOLISM "no_metabolism"
#define TRAIT_NOCLONELOSS "no_cloneloss"
#define TRAIT_TOXIMMUNE "toxin_immune"
#define TRAIT_EASYDISMEMBER "easy_dismember"
#define TRAIT_LIMBATTACHMENT "limb_attach"
#define TRAIT_NOLIMBDISABLE "no_limb_disable"
#define TRAIT_EASYLIMBDISABLE "easy_limb_disable"
#define TRAIT_TOXINLOVER "toxinlover"
#define TRAIT_NOBREATH "no_breath"
#define TRAIT_ANTIMAGIC "anti_magic"
#define TRAIT_HOLY "holy"
#define TRAIT_DEPRESSION "depression"
#define TRAIT_JOLLY "jolly"
#define TRAIT_NOCRITDAMAGE "no_crit"
#define TRAIT_NOSLIPWATER "noslip_water"
#define TRAIT_NOSLIPALL "noslip_all"
#define TRAIT_NODEATH "nodeath"
#define TRAIT_NOHARDCRIT "nohardcrit"
#define TRAIT_NOSOFTCRIT "nosoftcrit"
#define TRAIT_MINDSHIELD "mindshield"
#define TRAIT_DISSECTED "dissected"
#define TRAIT_SIXTHSENSE "sixth_sense" //I can hear dead people
#define TRAIT_FEARLESS "fearless"
#define TRAIT_PARALYSIS_L_ARM "para-l-arm" //These are used for brain-based paralysis, where replacing the limb won't fix it
#define TRAIT_PARALYSIS_R_ARM "para-r-arm"
#define TRAIT_PARALYSIS_L_LEG "para-l-leg"
#define TRAIT_PARALYSIS_R_LEG "para-r-leg"
#define TRAIT_CANNOT_OPEN_PRESENTS "cannot-open-presents"
#define TRAIT_PRESENT_VISION "present-vision"
#define TRAIT_DISK_VERIFIER "disk-verifier"
#define TRAIT_NOMOBSWAP "no-mob-swap"
#define TRAIT_XRAY_VISION "xray_vision"
#define TRAIT_THERMAL_VISION "thermal_vision"
/// Like antimagic, but doesn't block the user from casting
#define TRAIT_ANTIMAGIC_NO_SELFBLOCK "anti_magic_no_selfblock"
#define TRAIT_REAGENT_SCANNER "reagent_scanner"
#define TRAIT_ABDUCTOR_TRAINING "abductor-training"
#define TRAIT_ABDUCTOR_SCIENTIST_TRAINING "abductor-scientist-training"
#define TRAIT_SURGEON "surgeon"
#define TRAIT_STRONG_GRABBER "strong_grabber"
#define TRAIT_MAGIC_CHOKE "magic_choke"
#define TRAIT_SOOTHED_THROAT "soothed-throat"
#define TRAIT_LAW_ENFORCEMENT_METABOLISM "law-enforcement-metabolism"
#define TRAIT_ALWAYS_CLEAN "always-clean"
#define TRAIT_BOOZE_SLIDER "booze-slider"
#define TRAIT_QUICK_CARRY "quick-carry"
#define TRAIT_QUICKER_CARRY "quicker-carry"
#define TRAIT_QUICK_BUILD "quick-build"
#define TRAIT_UNINTELLIGIBLE_SPEECH "unintelligible-speech"
#define TRAIT_UNSTABLE "unstable"
#define TRAIT_OIL_FRIED "oil_fried"
#define TRAIT_MEDICAL_HUD "med_hud"
#define TRAIT_SECURITY_HUD "sec_hud"
#define TRAIT_DIAGNOSTIC_HUD "diag_hud" //for something granting you a diagnostic hud
#define TRAIT_MEDIBOTCOMINGTHROUGH "medbot" //Is a medbot healing you
#define TRAIT_PASSTABLE "passtable"
#define TRAIT_NOFLASH "noflash" //Makes you immune to flashes
#define TRAIT_XENO_IMMUNE "xeno_immune"//prevents xeno huggies implanting skeletons
#define TRAIT_NAIVE "naive"
#define TRAIT_PRIMITIVE "primitive"
#define TRAIT_GUNFLIP "gunflip"
#define TRAIT_SPECIAL_TRAUMA_BOOST "special_trauma_boost" ///Increases chance of getting special traumas, makes them harder to cure
#define TRAIT_BLOODCRAWL_EAT "bloodcrawl_eat"
#define TRAIT_SPACEWALK "spacewalk"
#define TRAIT_GAMERGOD "gamer-god" //double arcade prizes
#define TRAIT_GIANT "giant"
#define TRAIT_DWARF "dwarf"
#define TRAIT_FASTMED "fast_med_use"
#define TRAIT_SILENT_FOOTSTEPS "silent_footsteps" //makes your footsteps completely silent
#define TRAIT_NICE_SHOT "nice_shot" //hnnnnnnnggggg..... you're pretty good....
/// The holder of this trait has antennae or whatever that hurt a ton when noogied
#define TRAIT_ANTENNAE "antennae"
/// The holder of this trait can be picked up and held by another mob that does NOT have this trait.
#define TRAIT_HOLDABLE "holdable"
/// This person is blushing
#define TRAIT_BLUSHING "blushing"
/// The person has their eyes closed. Visual only
#define TRAIT_EYESCLOSED "eyesclosed"
/// The person is snoring. Visual only
#define TRAIT_SNORE "snoring"
/// the holder of this trait will be scooped instead of fireman carried
#define TRAIT_SCOOPABLE "scoopable"
//your smooches actually deal damage to their target
#define TRAIT_KISS_OF_DEATH "kiss_of_death"
#define TRAIT_CAN_SIGN_ON_COMMS "can_sign_on_comms"
//non-mob traits
/// Used for limb-based paralysis, where replacing the limb will fix it.
#define TRAIT_PARALYSIS "paralysis"

#define TRAIT_HEARING_SENSITIVE "hearing_sensitive"

///every object that is currently the active storage of some client mob has this trait
#define TRAIT_ACTIVE_STORAGE "active_storage"

#define TRAIT_KEEP_TOGETHER "keep-together"

// item traits
#define TRAIT_NODROP "nodrop"
#define TRAIT_NO_STORAGE_INSERT "no_storage_insert" //cannot be inserted in a storage.
#define TRAIT_T_RAY_VISIBLE "t-ray-visible" // Visible on t-ray scanners if the atom/var/level == 1
#define TRAIT_NO_TELEPORT "no-teleport" //you just can't

//quirk traits
#define TRAIT_ALCOHOL_TOLERANCE "alcohol_tolerance"
#define TRAIT_AGEUSIA "ageusia"
#define TRAIT_HEAVY_SLEEPER "heavy_sleeper"
#define TRAIT_NIGHT_VISION "night_vision"
#define TRAIT_LIGHT_STEP "light_step"
#define TRAIT_SPIRITUAL "spiritual"
#define TRAIT_FAN_CLOWN "fan_clown"
#define TRAIT_FAN_MIME "fan_mime"
#define TRAIT_VORACIOUS "voracious"
#define TRAIT_SELF_AWARE "self_aware"
#define TRAIT_FREERUNNING "freerunning"
#define TRAIT_SKITTISH "skittish"
#define TRAIT_POOR_AIM "poor_aim"
#define TRAIT_PROSOPAGNOSIA "prosopagnosia"
#define TRAIT_DRUNK_HEALING "drunk_healing"
#define TRAIT_TAGGER "tagger"
#define TRAIT_PHOTOGRAPHER "photographer"
#define TRAIT_MUSICIAN "musician"
#define TRAIT_LIGHT_DRINKER "light_drinker"
#define TRAIT_EMPATH "empath"
#define TRAIT_FRIENDLY "friendly"
#define TRAIT_GRABWEAKNESS "grab_weakness"
#define TRAIT_SNOB "snob"
#define TRAIT_BALD "bald"
#define TRAIT_BADTOUCH "bad_touch"
#define TRAIT_ANXIOUS "anxious"

/// Trait granted by lipstick
#define LIPSTICK_TRAIT "lipstick_trait"

// common trait sources
#define TRAIT_GENERIC "generic"
#define GENERIC_ITEM_TRAIT "generic_item"
#define UNCONSCIOUS_TRAIT "unconscious"
#define EYE_DAMAGE "eye_damage"
#define GENETIC_MUTATION "genetic"
#define OBESITY "obesity"
#define MAGIC_TRAIT "magic"
#define TRAUMA_TRAIT "trauma"
#define DISEASE_TRAIT "disease"
#define SPECIES_TRAIT "species"
#define ORGAN_TRAIT "organ"
#define ROUNDSTART_TRAIT "roundstart" //cannot be removed without admin intervention
#define JOB_TRAIT "job"
#define CYBORG_ITEM_TRAIT "cyborg-item"
#define ADMIN_TRAIT "admin" // (B)admins only.
#define CHANGELING_TRAIT "changeling"
#define CULT_TRAIT "cult"
#define CURSED_ITEM_TRAIT "cursed-item" // The item is magically cursed
#define ABSTRACT_ITEM_TRAIT "abstract-item"
#define STATUS_EFFECT_TRAIT "status-effect"
#define CLOTHING_TRAIT "clothing"
#define HELMET_TRAIT "helmet"
#define MASK_TRAIT "mask" //inherited from the mask
#define SHOES_TRAIT "shoes" //inherited from your sweet kicks
#define GLASSES_TRAIT "glasses"
#define VEHICLE_TRAIT "vehicle" // inherited from riding vehicles
#define INNATE_TRAIT "innate"
#define CRIT_HEALTH_TRAIT "crit_health"
#define OXYLOSS_TRAIT "oxyloss"
#define TURF_TRAIT "turf"
#define BUCKLED_TRAIT "buckled" //trait associated to being buckled
#define CHOKEHOLD_TRAIT "chokehold" //trait associated to being held in a chokehold
#define RESTING_TRAIT "resting" //trait associated to resting
#define STAT_TRAIT "stat" //trait associated to a stat value or range of
#define MAPPING_HELPER_TRAIT "mapping-helper" //obtained from mapping helper
/// Trait associated to wearing a suit
#define SUIT_TRAIT "suit"
/// Trait associated to lying down (having a [lying_angle] of a different value than zero).
#define LYING_DOWN_TRAIT "lying-down"
/// Trait associated to lacking electrical power.
#define POWER_LACK_TRAIT "power-lack"
/// Trait applied by MODsuits.
#define MOD_TRAIT "mod"

// unique trait sources, still defines
#define CLONING_POD_TRAIT "cloning-pod"
#define STATUE_MUTE "statue"
#define CHANGELING_DRAIN "drain"
#define CHANGELING_HIVEMIND_MUTE "ling_mute"
#define ABYSSAL_GAZE_BLIND "abyssal_gaze"
#define HIGHLANDER "highlander"
#define TRAIT_HULK "hulk"
#define STASIS_MUTE "stasis"
#define GENETICS_SPELL "genetics_spell"
#define EYES_COVERED "eyes_covered"
#define CULT_EYES "cult_eyes"
#define TRAIT_SANTA "santa"
#define SCRYING_ORB "scrying-orb"
#define ABDUCTOR_ANTAGONIST "abductor-antagonist"
#define NUKEOP_TRAIT "nuke-op"
#define DEATHSQUAD_TRAIT "deathsquad"
#define MEGAFAUNA_TRAIT "megafauna"
#define CLOWN_NUKE_TRAIT "clown-nuke"
#define STICKY_MOUSTACHE_TRAIT "sticky-moustache"
#define CHAINSAW_FRENZY_TRAIT "chainsaw-frenzy"
#define CHRONO_GUN_TRAIT "chrono-gun"
#define REVERSE_BEAR_TRAP_TRAIT "reverse-bear-trap"
#define CURSED_MASK_TRAIT "cursed-mask"
#define HIS_GRACE_TRAIT "his-grace"
#define HAND_REPLACEMENT_TRAIT "magic-hand"
#define HOT_POTATO_TRAIT "hot-potato"
#define SABRE_SUICIDE_TRAIT "sabre-suicide"
#define ABDUCTOR_VEST_TRAIT "abductor-vest"
#define CAPTURE_THE_FLAG_TRAIT "capture-the-flag"
#define EYE_OF_GOD_TRAIT "eye-of-god"
#define SHAMEBRERO_TRAIT "shamebrero"
#define CHRONOSUIT_TRAIT "chronosuit"
#define LOCKED_HELMET_TRAIT "locked-helmet"
#define NINJA_SUIT_TRAIT "ninja-suit"
#define ANTI_DROP_IMPLANT_TRAIT "anti-drop-implant"
#define SLEEPING_CARP_TRAIT "sleeping_carp"
#define MADE_UNCLONEABLE "made-uncloneable"
#define TIMESTOP_TRAIT "timestop"
#define STICKY_NODROP "sticky-nodrop" //sticky nodrop sounds like a bad soundcloud rapper's name
#define PULLED_WHILE_SOFTCRIT_TRAIT "pulled-while-softcrit"
#define LOCKED_BORG_TRAIT "locked-borg"
#define LACKING_LOCOMOTION_APPENDAGES_TRAIT "lacking-locomotion-appengades" //trait associated to not having locomotion appendages nor the ability to fly or float
#define LACKING_MANIPULATION_APPENDAGES_TRAIT "lacking-manipulation-appengades" //trait associated to not having fine manipulation appendages such as hands
#define HANDCUFFED_TRAIT "handcuffed"
#define ORBITED_TRAIT "orbited"
/// Trait granted by [/obj/item/warpwhistle]
#define WARPWHISTLE_TRAIT "warpwhistle"
///Turf trait for when a turf is transparent
#define TURF_Z_TRANSPARENT_TRAIT "turf_z_transparent"
/// Trait applied by by [/datum/component/soulstoned]
#define SOULSTONE_TRAIT "soulstone"
/// Trait applied to slimes by low temperature
#define SLIME_COLD "slime-cold"
/// Trait applied to bots by being tipped over
#define BOT_TIPPED_OVER "bot-tipped-over"
/// Trait applied to PAIs by being folded
#define PAI_FOLDED "pai-folded"
/// Trait applied to brain mobs when they lack external aid for locomotion, such as being inside a mech.
#define BRAIN_UNAIDED "brain-unaided"
/// Trait granted by [/obj/item/clothing/head/helmet/space/hardsuit/berserker]
#define BERSERK_TRAIT "berserk_trait"

// mobility flag traits
// IN THE FUTURE, IT WOULD BE NICE TO DO SOMETHING SIMILAR TO https://github.com/tgstation/tgstation/pull/48923/files (ofcourse not nearly the same because I have my.. thoughts on it)
// BUT FOR NOW, THESE ARE HOOKED TO DO update_mobility() VIA COMSIG IN living_mobility.dm
// SO IF YOU ADD MORE, BESURE TO UPDATE IT THERE.

/// Disallow movement
#define TRAIT_MOBILITY_NOMOVE "mobility_nomove"
/// Disallow pickup
#define TRAIT_MOBILITY_NOPICKUP "mobility_nopickup"
/// Disallow item use
#define TRAIT_MOBILITY_NOUSE "mobility_nouse"
///Disallow resting/unresting
#define TRAIT_MOBILITY_NOREST "mobility_norest"

#define TRAIT_FORCED_STANDING "forcedstanding"


///Movement type traits for movables. See elements/movetype_handler.dm
#define TRAIT_MOVE_GROUND "move_ground"
#define TRAIT_MOVE_FLYING "move_flying"
#define TRAIT_MOVE_VENTCRAWLING "move_ventcrawling"
#define TRAIT_MOVE_FLOATING "move_floating"
#define TRAIT_MOVE_PHASING "move_phasing"
/// Disables the floating animation. See above.
#define TRAIT_NO_FLOATING_ANIM "no-floating-animation"
