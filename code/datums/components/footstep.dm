///Footstep component. Plays footsteps at parents location when it is appropriate.
/datum/component/footstep
	///How many steps the parent has taken since the last time a footstep was played
	var/steps = 0
	///volume determines the extra volume of the footstep. This is multiplied by the base volume, should there be one.
	var/volume
	///e_range stands for extra range - aka how far the sound can be heard. This is added to the base value and ignored if there isn't a base value.
	var/e_range
	///footstep_type is a define which determines what kind of sounds should get chosen.
	var/footstep_type
	///This can be a list OR a soundfile OR null. Determines whatever sound gets played.
	var/footstep_sounds
	//Power armor sound list
	var/powerArmorSounds = list('sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_Walk_3rd_01.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_Walk_3rd_02.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_Walk_3rd_03.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_Walk_3rd_04.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_Walk_3rd_05.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_Walk_3rd_06.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_WalkUp_3rd_01.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_WalkUp_3rd_02.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_WalkUp_3rd_03.ogg',
	'sound/f13effects/footstep/ArmorPower/FST_ArmorPower_Dirt_WalkUp_3rd_04.ogg')

/datum/component/footstep/Initialize(footstep_type_ = FOOTSTEP_MOB_BAREFOOT, volume_ = 0.5, e_range_ = -1)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	volume = volume_
	e_range = e_range_
	footstep_type = footstep_type_
	switch(footstep_type)
		if(FOOTSTEP_MOB_HUMAN)
			if(!ishuman(parent))
				return COMPONENT_INCOMPATIBLE
			RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/play_humanstep)
			return
		if(FOOTSTEP_MOB_CLAW)
			footstep_sounds = GLOB.clawfootstep
		if(FOOTSTEP_MOB_BAREFOOT)
			footstep_sounds = GLOB.barefootstep
		if(FOOTSTEP_MOB_HEAVY)
			footstep_sounds = GLOB.heavyfootstep
		if(FOOTSTEP_MOB_SHOE)
			footstep_sounds = GLOB.footstep
		if(FOOTSTEP_MOB_SLIME)
			footstep_sounds = 'sound/effects/footstep/slime1.ogg'
		if(FOOTSTEP_MOB_CRAWL)
			footstep_sounds = 'sound/effects/footstep/crawl1.ogg'
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/play_simplestep) //Note that this doesn't get called for humans.

///Prepares a footstep. Determines if it should get played. Returns the turf it should get played on. Note that it is always a /turf/open
/datum/component/footstep/proc/prepare_step()
	var/turf/open/T = get_turf(parent)
	if(!istype(T))
		return

	var/mob/living/LM = parent
	if(!T.footstep || LM.buckled || !CHECK_MOBILITY(LM, MOBILITY_STAND) || LM.buckled || LM.throwing || (LM.movement_type & (VENTCRAWLING | FLYING)))
		if (LM.lying && !LM.buckled && !(!T.footstep || LM.movement_type & (VENTCRAWLING | FLYING))) //play crawling sound if we're lying
			playsound(T, 'sound/effects/footstep/crawl1.ogg', 15 * volume)
		return

	if(HAS_TRAIT(LM, TRAIT_SILENT_STEP))
		return

	if(iscarbon(LM))
		var/mob/living/carbon/C = LM
		if(!C.get_bodypart(BODY_ZONE_L_LEG) && !C.get_bodypart(BODY_ZONE_R_LEG))
			return
		if(C.m_intent == MOVE_INTENT_WALK)
			powerarmorcheck()
			return
	steps++

	if(steps >= 6)
		steps = 0

	if(steps % 2)
		return

	if(steps != 0 && !LM.has_gravity(T)) // don't need to step as often when you hop around
		return
	return T

/datum/component/footstep/proc/play_simplestep()
	var/turf/open/T = prepare_step()
	if(!T)
		return
	if(isfile(footstep_sounds) || istext(footstep_sounds))
		playsound(T, footstep_sounds, volume)
		return
	var/turf_footstep
	switch(footstep_type)
		if(FOOTSTEP_MOB_CLAW)
			turf_footstep = T.clawfootstep
		if(FOOTSTEP_MOB_BAREFOOT)
			turf_footstep = T.barefootstep
		if(FOOTSTEP_MOB_HEAVY)
			turf_footstep = T.heavyfootstep
		if(FOOTSTEP_MOB_SHOE)
			turf_footstep = T.footstep
	if(!turf_footstep)
		return
	playsound(T, pick(footstep_sounds[turf_footstep][1]), footstep_sounds[turf_footstep][2] * volume, TRUE, footstep_sounds[turf_footstep][3] + e_range)

/datum/component/footstep/proc/play_humanstep()
	var/turf/open/T = prepare_step()
	if(!T)
		return
	var/mob/living/carbon/human/H = parent
	powerarmorcheck()
	var/list/L = GLOB.barefootstep
	var/turf_footstep = T.barefootstep
	var/special = FALSE
	if(H.physiology.footstep_type)
		switch(H.physiology.footstep_type)
			if(FOOTSTEP_MOB_CLAW)
				turf_footstep = T.clawfootstep
				L = GLOB.clawfootstep
			if(FOOTSTEP_MOB_BAREFOOT)
				turf_footstep = T.barefootstep
				L = GLOB.barefootstep
			if(FOOTSTEP_MOB_HEAVY)
				turf_footstep = T.heavyfootstep
				L = GLOB.heavyfootstep
			if(FOOTSTEP_MOB_SHOE)
				turf_footstep = T.footstep
				L = GLOB.footstep
			if(FOOTSTEP_MOB_SLIME)
				playsound(T, 'sound/effects/footstep/slime1.ogg', 50 * volume)
				return
			if(FOOTSTEP_MOB_CRAWL)
				playsound(T, 'sound/effects/footstep/crawl1.ogg', 50 * volume)
				return
		special = TRUE
	else
		var/feetCover = (H.wear_suit && (H.wear_suit.body_parts_covered & FEET)) || (H.w_uniform && (H.w_uniform.body_parts_covered & FEET) || (H.shoes && (H.shoes.body_parts_covered & FEET)))
		if(feetCover) //are we wearing shoes
			playsound(T, pick(GLOB.footstep[T.footstep][1]),
				GLOB.footstep[T.footstep][2] * volume,
				TRUE,
				GLOB.footstep[T.footstep][3] + e_range)
			return

	if(!special && H.dna.species.special_step_sounds)
		playsound(T, pick(H.dna.species.special_step_sounds), 50, TRUE)
	else
		playsound(T, pick(L[turf_footstep][1]),
			L[turf_footstep][2] * volume,
			TRUE,
			L[turf_footstep][3] + e_range)

/datum/component/footstep/proc/powerarmorcheck()
	var/mob/living/carbon/human/P = parent
	var/turf/open/T = get_turf(P)
	var/powerArmor = (P.wear_suit && istype(P.wear_suit,/obj/item/clothing/suit/armored/f13/power_armor))
	if(powerArmor)
		if(P.m_intent == MOVE_INTENT_WALK)
			if(prob(25))
				playsound(T, pick(powerArmorSounds), 25, TRUE)
				return
		else
			playsound(T, pick(powerArmorSounds), 50, TRUE)
