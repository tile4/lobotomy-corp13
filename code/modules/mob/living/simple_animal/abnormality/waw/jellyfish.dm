#define STATUS_EFFECT_DEPRESSION /datum/status_effect/depression
/mob/living/simple_animal/hostile/abnormality/jellyfish
	name = "Jellyfish From the Sky"
	desc = "An abnormality resembling a giant jellyfish with long tentacles."
	icon = 'ModularTegustation/Teguicons/64x64.dmi'
	icon_state = "jellyfish"
	icon_living = "jellyfish"
	portrait = "jellyfish"


	maxHealth = 1500
	health = 1500
	density = FALSE
	damage_coeff = list(RED_DAMAGE = 0.8, WHITE_DAMAGE = 0.2, BLACK_DAMAGE = 1.2, PALE_DAMAGE = 1.5)
	ranged = TRUE
	move_to_delay = 3
	fear_level = WAW_LEVEL

	faction = list("hostile")
	can_breach = TRUE
	threat_level = WAW_LEVEL
	start_qliphoth = 3
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = list(40, 45, 50, 55, 55),
		ABNORMALITY_WORK_INSIGHT = list(55, 45, 35, 25, 10),
		ABNORMALITY_WORK_ATTACHMENT = list(30, 40, 45, 45, 50),
		ABNORMALITY_WORK_REPRESSION = 0
	)
	work_damage_amount = 13 //Great workrates but high damage dealer
	work_damage_type = WHITE_DAMAGE
	max_boxes = 23
	ego_list = list(
		/datum/ego_datum/weapon/kurage,
		/datum/ego_datum/armor/kurage,
	)

	gift_type =  /datum/ego_gifts/kurage
	abnormality_origin = ABNORMALITY_ORIGIN_ORIGINAL

	chem_type = /datum/reagent/abnormality/depression


/mob/living/simple_animal/hostile/abnormality/jellyfish/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_HUMAN_INSANE, PROC_REF(OnHumanInsane))

/mob/living/simple_animal/hostile/abnormality/jellyfish/PostWorkEffect(mob/living/carbon/human/user, work_type, pe, work_time)
	if(user.sanity_lost)
		BreachEffect()

/mob/living/simple_animal/hostile/abnormality/jellyfish/BreachEffect(mob/living/carbon/human/user, breach_type)
	. = ..()
	icon_state = "jellyfish_high"
	GiveTarget(user)

/mob/living/simple_animal/hostile/abnormality/jellyfish/FailureEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	datum_reference.qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/jellyfish/proc/OnHumanInsane(datum/source, mob/living/carbon/human/H, attribute)
	SIGNAL_HANDLER
	if(!IsContained())
		return FALSE
	if(!H.mind) // That wasn't a player at all...
		return FALSE
	if(H.z != z)
		return FALSE
	datum_reference.qliphoth_change(-1)
	return TRUE

/datum/reagent/abnormality/depression
	name = "Gloom Juice"
	description = "A powerful serum extracted from an abnormality."
	color = "#616161"
	taste_description = "sadness"
	glass_name = "glass of gloom juice"
	glass_desc = "A glass of gloom juice."
	metabolization_rate = REAGENTS_METABOLISM//metabolizes at 8u/minute
	var/panic_override = FALSE

/datum/reagent/abnormality/depression/on_mob_metabolize(mob/living/L)
	..()
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/H = L
	H.adjust_attribute_buff(FORTITUDE_ATTRIBUTE, 5)
	H.adjust_attribute_buff(PRUDENCE_ATTRIBUTE, -5)
	H.adjust_attribute_buff(TEMPERANCE_ATTRIBUTE, 5)
	H.adjust_attribute_buff(JUSTICE_ATTRIBUTE, 5)

/datum/reagent/abnormality/depression/on_mob_life(mob/living/L)
	..()
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/H = L
	if(H.sanityhealth/L.maxSanity < 0.5 && !H.sanity_lost)
		H.adjustSanityLoss(999)
	if(H.sanity_lost)
		if(panic_override)
			return
		QDEL_NULL(H.ai_controller)
		H.ai_controller = /datum/ai_controller/insane/suicide
		H.InitializeAIController()
		H.apply_status_effect(/datum/status_effect/panicked_type/suicide)
		panic_override = TRUE
		metabolization_rate = 0 //To avoid it possibly breaking for metabolism ending during insanity
		return
	panic_override = FALSE
	metabolization_rate = REAGENTS_METABOLISM
	return ..()

/datum/reagent/abnormality/depression/on_mob_end_metabolize(mob/living/L)
	..()
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/H = L
	H.adjust_attribute_buff(FORTITUDE_ATTRIBUTE, -5)
	H.adjust_attribute_buff(PRUDENCE_ATTRIBUTE, 5)
	H.adjust_attribute_buff(TEMPERANCE_ATTRIBUTE, -5)
	H.adjust_attribute_buff(JUSTICE_ATTRIBUTE, -5)
