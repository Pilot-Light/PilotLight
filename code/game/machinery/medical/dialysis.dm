/obj/machinery/medical/dialysis
	name = "Direct Blood Filtration Unit"
	desc = "Automatically filtrates your blood from all chemicals."
	icon_state = "dialysis"
	///Amount of purged chems per process
	var/purge_amount = 0.5

/obj/machinery/medical/dialysis/RefreshParts()
	var/change = 0
	for(var/obj/item/stock_parts/capacitor/capacitor in component_parts)
		change += capacitor.rating
	purge_amount = initial(purge_amount) * change
	return

/obj/machinery/medical/dialysis/process()
	. = ..()
	if(!attached || !attached.reagents)
		return
	for(var/R in attached.reagents.reagent_list)
		var/datum/reagent/reagent = R
		attached.reagents.remove_reagent(reagent.type, purge_amount)
	return
