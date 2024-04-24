/mob/living/simple_animal/hostile/abnormality/jellyfish
	name = "Jellyfish From the Sky"
	desc = "An abnormality resembling a giant jellyfish with long tentacles."
	icon = 'ModularTegustation/Teguicons/64x64.dmi'
	icon_state = "jellyfish"
	icon_living = "jellyfish"
	portrait = "jellyfish"


	maxHealth = 1000
	health = 1000
	density = FALSE
	damage_coeff = list(RED_DAMAGE = 0.2, WHITE_DAMAGE = 1, BLACK_DAMAGE = 1, PALE_DAMAGE = 1)
	ranged = TRUE

	melee_damage_type = WHITE_DAMAGE
	stat_attack = HARD_CRIT

	fear_level = HE_LEVEL

	faction = list("hostile")
	can_breach = TRUE
	threat_level = HE_LEVEL
	start_qliphoth = 3
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = list(0, 45, 50, 50, 55),
		ABNORMALITY_WORK_INSIGHT = list(0, 0, 30, 30, 30),
		ABNORMALITY_WORK_ATTACHMENT = list(0, 40, 45, 45, 50),
		ABNORMALITY_WORK_REPRESSION = 0
	)
	work_damage_amount = 10
	work_damage_type = WHITE_DAMAGE
	max_boxes = 17
	ego_list = list(
		/datum/ego_datum/weapon/kurage,
		/datum/ego_datum/armor/kurage,
	)

	gift_type =  /datum/ego_gifts/kurage
	abnormality_origin = ABNORMALITY_ORIGIN_ORIGNINAL


/mob/living/simple_animal/hostile/abnormality/jellyfish/ZeroQliphoth(mob/living/carbon/human/user)
	if(minions >= 1)
		return FALSE
	var/mob/living/jellyfish_breach
