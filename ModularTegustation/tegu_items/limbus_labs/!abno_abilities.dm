// The stuff that is mainly used in LCL

//Galaxy Child
/mob/living/simple_animal/hostile/abnormality/galaxy_child/PostSpawn()
	. = ..()
	datum_reference.qliphoth_meter = 1
	if((SSmaptype.maptype == "limbus_labs"))
		var/datum/action/cooldown/friend_gift/gift = new()
		gift.Grant(src)
		var/datum/action/cooldown/galaxygiftbreak/antigift = new()
		antigift.Grant(src)

/datum/action/cooldown/friend_gift
	name = "Gift Pebble"
	icon_icon = 'ModularTegustation/Teguicons/status_sprites.dmi'
	button_icon_state = "friendship"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = 5 SECONDS

/datum/action/cooldown/friend_gift/Trigger()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/simple_animal/hostile/abnormality/galaxy_child/galaxy_owner = owner
	if(!istype(galaxy_owner)) // Sorry, only the child can give pebbles
		return FALSE

	var/list/possible_friend_list = list()
	for(var/mob/living/carbon/human/possible_friend as anything in view(7, galaxy_owner)) // Get every valid human in range
		if(!istype(possible_friend))
			continue
		if(!possible_friend.client)
			continue
		if(possible_friend.stat == DEAD)
			continue
		if(possible_friend in galaxy_owner.galaxy_friends) // You can't have 2 pebbles batman
			continue

		possible_friend_list += possible_friend

	if(!length(possible_friend_list))
		to_chat(galaxy_owner, span_notice("There's nobody you can gift your pebble to."))
		return

	// pick someone to be your new best friend
	var/mob/living/carbon/human/new_friend = input(galaxy_owner, "Choose who you want to gift a pebble to", "Select your new friend") as null|anything in possible_friend_list
	if(!new_friend)
		return

	if(get_dist(galaxy_owner, new_friend) > 7) // User inputs can last a long time, make sure everything is still valid
		to_chat(galaxy_owner, span_warning("You can't reach [new_friend] from here!"))
		return

	if(new_friend.stat == DEAD)
		to_chat(galaxy_owner, span_warning("It's too late to save them..."))
		return

	var/giftask = alert(new_friend, "Do you wish to receive the child's gift?", "Recieve Gift", "Yes", "No")
	if(get_dist(galaxy_owner, new_friend) > 7) // I HATE USER INPUTS, JUST PRESS THE DAMN BUTTON IMMEDIATELLY
		to_chat(galaxy_owner, span_warning("You can't reach [galaxy_owner] from here!"))
		return

	if(giftask == "Yes")
		galaxy_owner.give_pebble(new_friend)
		galaxy_owner.icon_state = "galaxy"
		galaxy_owner.depressed = FALSE

	StartCooldown()
	return TRUE

/datum/action/cooldown/galaxygiftbreak
	name = "Break Gifts"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = 5 SECONDS

/datum/action/cooldown/galaxygiftbreak/Trigger()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/simple_animal/hostile/abnormality/galaxy_child/galaxy_owner = owner
	if(!istype(galaxy_owner))
		return FALSE

	if(alert(galaxy_owner, "Are you sure you want to break all pebbles?", "Pebble toss", "Yes", "No") != "Yes")
		return FALSE

	var/friend_names = ""
	for(var/mob/past_friend as anything in galaxy_owner.galaxy_friends)
		friend_names = "[past_friend], [friend_names]"

	to_chat(galaxy_owner, span_userdanger("[friend_names].. They were never true friends..."))
	galaxy_owner.break_gifts()
	StartCooldown()
	return TRUE

//Piscine Mermaid

/mob/living/simple_animal/hostile/abnormality/pisc_mermaid/PostSpawn()
	. = ..()
	if((SSmaptype.maptype == "limbus_labs"))
		var/datum/action/innate/change_icon_merm/iconchange = new()
		iconchange.Grant(src)
		var/datum/action/cooldown/give_crown/comb = new()
		comb.Grant(src)

/datum/action/innate/change_icon_merm
	name = "Toggle Icon"
	desc = "Toggle your icon between breached and contained. (Works only for Limbus Company Labratories)"

/datum/action/innate/change_icon_merm/Activate()
	. = ..()
	if(SSmaptype.maptype == "limbus_labs")
		owner.icon = 'ModularTegustation/Teguicons/48x32.dmi'
		owner.icon_state = "pmermaid_standing"
		owner.pixel_x = -12
		owner.base_pixel_x = -12
		owner.pixel_y = 0
		owner.base_pixel_y = 0
		active = 1

/datum/action/innate/change_icon_merm/Deactivate()
	. = ..()
	if(SSmaptype.maptype == "limbus_labs")
		owner.icon = 'ModularTegustation/Teguicons/64x64.dmi'
		owner.icon_state = "pmermaid_breach"
		owner.pixel_x = 0
		owner.base_pixel_x = 0
		owner.pixel_y = -16
		owner.base_pixel_y = -16
		active = 0

/datum/action/cooldown/give_crown
	name = "Spawn Crown"
	check_flags = AB_CHECK_CONSCIOUS
	transparent_when_unavailable = TRUE
	cooldown_time = 5 SECONDS

/datum/action/cooldown/give_crown/Trigger()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/simple_animal/hostile/abnormality/mermaid/merm = owner
	if(!istype(merm))
		return FALSE
	if(!crown)
		var/obj/item/clothing/head/unrequited_crown/UC = new(get_turf(src))
		owner.crown = UC
