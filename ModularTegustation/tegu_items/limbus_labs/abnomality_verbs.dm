/mob/living/simple_animal/hostile/abnormality/proc/ManualGift()
	set name = "Give EGO Gift"
	set category = "Abnormality"
	if(!gift_type)
		to_chat(src,span_notice("Either the abnormality you are playing doesn't have an EGO or the verb wasn't implimented properly. <br>\
			Regardless, yell at the coders if you see this!"))
	var/list/nearby = viewers(7, src)
	for(var/mob in nearby)
		if(mob == src)
			nearby -= mob
		if(!ishuman(mob))
			nearby -= mob
	var/mob/living/carbon/human/gifted_human = tgui_input_list(src, "Which Human should recieve your gift?", "Select a person", nearby)
	if(!gifted_human)
		to_chat(src, span_notice("You decide against giving your E.G.O. Gift."))
		return
	var/giftask = alert(gifted_human, "Do you wish to receive the abnormality's E.G.O. gift?", "Recieve E.G.O. Gift", "Yes", "No")
	if(get_dist(src, gifted_human) > 7)
		to_chat(gifted_human, span_warning("You are too far from [src]!"))
		to_chat(src, span_warning("[gifted_human] went out of range"))
		return
	if(giftask == "No")
		to_chat(src, span_notice("[gifted_human] rejected the gift."))
		return
	gifted_human.Apply_Gift(gift_type)
	if(gifted_human)
		to_chat(src, span_nicegreen("You have given [gifted_human] your E.G.O. Gift!"))
	return

/mob/living/carbon/human/species/pinocchio/proc/PuppetGift() //Since Pino is a carbon, it needs a seperate proc
	set name = "Give EGO Gift"
	set category = "Abnormality"
	if(!gift_type)
		to_chat(src,span_notice("Either the abnormality you are playing doesn't have an EGO or the verb wasn't implimented properly. <br>\
			Regardless, yell at the coders if you see this!"))
	var/list/nearby = viewers(7, src)
	for(var/mob in nearby)
		if(mob == src)
			nearby -= mob
		if(!ishuman(mob))
			nearby -= mob
	var/mob/living/carbon/human/gifted_human = tgui_input_list(src, "Which Human should recieve your gift?", "Select a person", nearby)
	if(!gifted_human)
		to_chat(src, span_notice("You decide against giving your E.G.O. Gift."))
		return
	var/giftask = alert(gifted_human, "Do you wish to receive the abnormality's E.G.O. gift?", "Recieve E.G.O. Gift", "Yes", "No")
	if(get_dist(src, gifted_human) > 7)
		to_chat(gifted_human, span_warning("You are too far from [src]!"))
		to_chat(src, span_warning("[gifted_human] went out of range"))
		return
	if(giftask == "No")
		to_chat(src, span_notice("[gifted_human] rejected the gift."))
		return
	gifted_human.Apply_Gift(gift_type)
	if(gifted_human)
		to_chat(src, span_nicegreen("You have given [gifted_human] your E.G.O. Gift!"))
	return
