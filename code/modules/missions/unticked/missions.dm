/datum/mission
	/// The outpost that issued this mission. Passed in New().
	var/datum/overmap/outpost/source_outpost
	/// The ship that accepted this mission. Passed in accept().
	var/datum/overmap/ship/controlled/servant

	var/accepted = FALSE
	var/failed = FALSE
	var/dur_timer

/datum/mission/New(_outpost)
	var/old_dur = duration
	var/val_mod = value * val_mod_range
	var/dur_mod = duration * dur_mod_range
	// new duration is between
	duration = round(rand(duration-dur_mod, duration+dur_mod), 30 SECONDS)
	value = round(rand(value-val_mod, value+val_mod) * (dur_value_scaling ? old_dur / duration : 1), 50)

	source_outpost = _outpost
	RegisterSignal(source_outpost, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
	return ..()

/datum/mission/proc/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	accepted = TRUE
	servant = acceptor
	LAZYREMOVE(source_outpost.missions, src)
	LAZYADD(servant.missions, src)
	RegisterSignal(servant, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
	dur_timer = addtimer(VARSET_CALLBACK(src, failed, TRUE), duration, TIMER_STOPPABLE)

/datum/mission/proc/on_vital_delete()
	qdel(src)

/datum/mission/Destroy()
	UnregisterSignal(source_outpost, COMSIG_PARENT_QDELETING)
	LAZYREMOVE(source_outpost.missions, src)
	source_outpost = null
	if(servant)
		UnregisterSignal(servant, COMSIG_PARENT_QDELETING)
		LAZYREMOVE(servant.missions, src)
		servant = null
	for(var/bound in bound_atoms)
		remove_bound(bound)
	deltimer(dur_timer)
	return ..()

/datum/mission/proc/turn_in()
	servant.ship_account.adjust_money(value, "mission")
	qdel(src)

/datum/mission/proc/give_up()
	qdel(src)

/datum/mission/proc/can_complete()
	return !failed

/datum/mission/proc/get_tgui_info()
	var/time_remaining = max(dur_timer ? timeleft(dur_timer) : duration, 0)

	var/act_str = "Give up"
	if(!accepted)
		act_str = "Accept"
	else if(can_complete())
		act_str = "Turn in"

	return list(
		"ref" = REF(src),
		"name" = src.name,
		"desc" = src.desc,
		"value" = src.value,
		"duration" = src.duration,
		"remaining" = time_remaining,
		"timeStr" = time2text(time_remaining, "mm:ss"),
		"progressStr" = get_progress_string(),
		"actStr" = act_str
	)

/datum/mission/proc/get_progress_string()
	return "null"

/**
 * Spawns a "bound" atom of the given type at the given location. When the "bound" atom
 * is qdeleted, the passed-in callback is invoked, and, by default, the mission fails.
 *
 * Intended to be used to spawn mission-linked atoms that can have
 * references saved without causing harddels.
 *
 * Arguments:
 * * a_type - The type of the atom to be spawned. Must be of type /atom/movable.
 * * a_loc - The location to spawn the bound atom at.
 * * destroy_cb - The callback to invoke when the bound atom is qdeleted. Default is null.
 * * fail_on_delete - Bool; whether the mission should fail when the bound atom is qdeleted. Default TRUE.
 * * sparks - Whether to spawn sparks after spawning the bound atom. Default TRUE.
 */
/datum/mission/proc/spawn_bound(atom/movable/a_type, a_loc, destroy_cb = null, fail_on_delete = TRUE, sparks = TRUE)
	if(!ispath(a_type, /atom/movable))
		CRASH("[src] attempted to spawn bound atom of invalid type [a_type]!")
	var/atom/movable/bound = new a_type(a_loc)
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	LAZYSET(bound_atoms, bound, list(fail_on_delete, destroy_cb))
	RegisterSignal(bound, COMSIG_PARENT_QDELETING, PROC_REF(bound_deleted))
	return bound

/**
 * Removes the given atom from the mission's bound items, then qdeletes it.
 * Does not invoke the callback or fail the mission; optionally creates sparks.
 *
 * Arguments:
 * * bound - The bound atom to recall.
 * * sparks - Whether to spawn sparks on the turf the bound atom is located on. Default TRUE.
 */
/datum/mission/proc/recall_bound(atom/movable/bound, sparks = TRUE)
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	remove_bound(bound)
	qdel(bound)

/// Signal handler for the qdeletion of bound atoms.
/datum/mission/proc/bound_deleted(atom/movable/bound, force)
	SIGNAL_HANDLER
	var/list/bound_info = bound_atoms[bound]
	// first value in bound_info is whether to fail on item destruction
	failed = bound_info[1]
	// second value is callback to fire on atom destruction
	if(bound_info[2] != null)
		var/datum/callback/CB = bound_info[2]
		CB.Invoke()
	remove_bound(bound)

/**
 * Removes the given bound atom from the list of bound atoms.
 * Does not invoke the associated callback or fail the mission.
 *
 * Arguments:
 * * bound - The bound atom to remove.
 */
/datum/mission/proc/remove_bound(atom/movable/bound)
	UnregisterSignal(bound, COMSIG_PARENT_QDELETING)
	// delete the callback
	qdel(LAZYACCESSASSOC(bound_atoms, bound, 2))
	// remove info from our list
	LAZYREMOVE(bound_atoms, bound)
