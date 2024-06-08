/mob/living/simple_animal/hostile/abnormality/ronald
	name = "The Demonic Clown"
	desc = "A weird clown with red and yellow clothes. He seems to be speaking in Japanese at times."
	icon = 'ModularTegustation/Teguicons'
	icon_state = "ronald"
	icon_living = "ronald"
	portrait = "ronald"
	maxHealth = 4000
	health = 4000
	move_to_delay = .5
	damage_coeff = list(RED_DAMAGE = .6, WHITE_DAMAGE = .6, BLACK_DAMAGE = .6, PALE_DAMAGE = .6)
	can_breach = TRUE
	threat_level = ALEPH_LEVEL
	start_qliphoth = 10
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = list(0, 0, 20, 30, 40),
		ABNORMALITY_WORK_INSIGHT = list(0, 0, 40, 50, 50),
		ABNORMALITY_WORK_ATTACHMENT = list(0, 0, 20, 30, 40),
		ABNORMALITY_WORK_REPRESSION = list(0, 0, 0, 0, 0),
	)
	work_damage_amount = 15
	work_damage_type = BLACK_DAMAGE

	ego_list = list(
		/datum/ego_datum/weapon/mcdonald,
		/datum/ego_datum/armor/mcdonald,
	)
	gift_type =  /datum/ego_gifts/mcdonald

	abnormality_origin = ABNORMALITY_ORIGIN_JOKE

	var/dash_damage = 30
	var/beam_cooldown = 1 MINUTE
	var/beam_damage = 5
	var/burger_cooldown = 2 SECONDS
	var/volley_cooldown = 10 SECONDS
	var/volley_amount = 16
