//IN THIS DOCUMENT: Shotgun template, Double barrel shotguns, Pump-action shotguns, Semi-auto shotgun
//////////////////////
// SHOTGUN TEMPLATE //
//////////////////////

/obj/item/gun/ballistic/shotgun
	slowdown = 0.3 //Bulky gun slowdown with rebate since generally smaller than assault rifles
	name = "shotgun template"
	desc = "Should not exist"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_prefix = "shotgunpump"
	icon_state = "shotgun"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	force = 15 //Decent clubs generally speaking
	fire_delay = 4 //Typical pump action, pretty fast.
	spread = 2
	recoil = 1
	can_scope = FALSE
	flags_1 =  CONDUCT_1
	casing_ejector = FALSE
	var/recentpump = 0 // to prevent spammage
	spawnwithmagazine = TRUE
	var/pump_sound = 'sound/weapons/shotgunpump.ogg'
	fire_sound = 'sound/f13weapons/shotgun.ogg'
	equipsound = 'sound/f13weapons/equipsounds/shotgunequip.ogg'
	pb_knockback = 1


/obj/item/gun/ballistic/shotgun/process_chamber(mob/living/user, empty_chamber = 0)
	return ..() //changed argument value

/obj/item/gun/ballistic/shotgun/can_shoot()
	return !!chambered?.BB

/obj/item/gun/ballistic/shotgun/attack_self(mob/living/user)
	if(recentpump > world.time)
		return
	if(IS_STAMCRIT(user))//CIT CHANGE - makes pumping shotguns impossible in stamina softcrit
		to_chat(user, "<span class='warning'>You're too exhausted for that.</span>")//CIT CHANGE - ditto
		return//CIT CHANGE - ditto
	pump(user, TRUE)
	if(HAS_TRAIT(user, TRAIT_FAST_PUMP))
		recentpump = world.time + 2
	else
		recentpump = world.time + 10
		if(istype(user))//CIT CHANGE - makes pumping shotguns cost a lil bit of stamina.
			user.adjustStaminaLossBuffered(2) //CIT CHANGE - DITTO. make this scale inversely to the strength stat when stats/skills are added
	return

/obj/item/gun/ballistic/shotgun/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/shotgun/proc/pump(mob/M, visible = TRUE)
	if(visible)
		M.visible_message("<span class='warning'>[M] racks [src].</span>", "<span class='warning'>You rack [src].</span>")
	playsound(M, pump_sound, 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/shotgun/proc/pump_unload(mob/M)
	if(chambered)//We have a shell in the chamber
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null

/obj/item/gun/ballistic/shotgun/proc/pump_reload(mob/M)
	if(!magazine.ammo_count())
		return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC

/obj/item/gun/ballistic/shotgun/examine(mob/user)
	. = ..()
	if (chambered)
		. += "A [chambered.BB ? "live" : "spent"] one is in the chamber."

//////////////////////////////////////
//			SINGLE SHOTGUN			//
//////////////////////////////////////

/obj/item/gun/ballistic/revolver/single_shotgun
	name = "pipe shotgun"
	desc = "A homemade pipe shotgun. While it might look crude, it has no issue dropping a grown man."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "winchesterbore"
	item_state = "shotgundouble"
	icon_prefix = "shotgundouble"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised
	fire_delay = 0.5
	fire_sound = 'sound/f13weapons/riot_shotgun.ogg'
	equipsound = 'sound/f13weapons/equipsounds/shotgunequip.ogg'
	extra_damage = 4
	extra_penetration = 0.1
	pb_knockback = 2

/obj/item/gun/ballistic/revolver/single_shotgun/update_icon_state()
	if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

////////////////////////////////////////
//DOUBLE BARREL & PUMP ACTION SHOTGUNS//
////////////////////////////////////////

/obj/item/gun/ballistic/revolver/caravan_shotgun
	name = "over-under shotgun"
	desc = "A common over-under double barreled shotgun, made in the post-war era."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "caravan"
	item_state = "shotgundouble"
	icon_prefix = "shotgundouble"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	fire_delay = 2
	spread = 20
	force = 20
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual/simple
	sawn_desc = "Short and concealable, terribly uncomfortable to fire, but worse on the other end."
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
	equipsound = 'sound/f13weapons/equipsounds/shotgunequip.ogg'
	recoil = 1.55
	extra_damage = 3
	extra_penetration = 0.05
	pb_knockback = 2

/obj/item/gun/ballistic/revolver/caravan_shotgun/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/twohanded/chainsaw))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

/obj/item/gun/ballistic/revolver/caravan_shotgun/update_icon_state()
	if(sawn_off)
		icon_state = "[initial(icon_state)]-sawn"
	else if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/revolver/widowmaker
	name = "Winchester Widowmaker"
	desc = "Old-world Winchester Widowmaker double-barreled 12 gauge shotgun, with mahogany furniture"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "widowmaker"
	item_state = "shotgundouble"
	icon_prefix = "shotgundouble"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	fire_delay = 2
	spread = 20
	force = 20
	sawn_desc = "Someone took the time to chop the last few inches off the barrel and stock of this shotgun. Now, the wide spread of this hand-cannon's short-barreled shots makes it perfect for short-range crowd control."
	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'
	equipsound = 'sound/f13weapons/equipsounds/shotgunequip.ogg'
	recoil = 0.55
	extra_damage = 2
	extra_penetration = 0.15
	pb_knockback = 2

/obj/item/gun/ballistic/revolver/widowmaker/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/twohanded/chainsaw))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

/obj/item/gun/ballistic/revolver/widowmaker/update_icon_state()
	if(sawn_off)
		icon_state = "[initial(icon_state)]-sawn"
	else if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/shotgun/hunting
	name = "Winchester Model 1897"
	desc = "Found everywhere, the 12 gauge pump is a popular means of self-defense due to its wide area of effect and large ammunition capacity."
	icon_state = "pump"
	item_state = "shotgunpump"
	icon_prefix = "shotgunpump"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal
	fire_delay = 1

/obj/item/gun/ballistic/shotgun/hunting/update_icon_state()
	if(sawn_off)
		icon_state = "[initial(icon_state)]-sawn"
	else if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/shotgun/police
	name = "Ithaca Model 37"
	desc = "A pre-war shotgun with large magazine and folding stock, made from steel and polymers."
	icon_state = "shotgunpolice"
	item_state = "shotgunpolice"
	icon_prefix = "shotgunpolice"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/police
	sawn_desc = "Portable but with poor recoil managment."
	w_class = WEIGHT_CLASS_NORMAL
	recoil = 0.5
	fire_delay = 1
	var/stock = FALSE
	can_flashlight = TRUE
	gunlight_state = "flightangle"
	flight_x_offset = 23
	flight_y_offset = 21

/obj/item/gun/ballistic/shotgun/police/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	toggle_stock(user)
	return TRUE

/obj/item/gun/ballistic/shotgun/police/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to toggle the stock.</span>"

/obj/item/gun/ballistic/shotgun/police/proc/toggle_stock(mob/living/user)
	stock = !stock
	if(stock)
		w_class = WEIGHT_CLASS_BULKY
		to_chat(user, "You unfold the stock.")
		recoil = 0.1
		spread = 0
	else
		w_class = WEIGHT_CLASS_NORMAL
		to_chat(user, "You fold the stock.")
		recoil = 0.5
	update_icon()

/obj/item/gun/ballistic/shotgun/police/update_icon_state()
	icon_state = "[current_skin ? unique_reskin[current_skin] : "shotgunpolice"][stock ? "" : "fold"]"

/obj/item/gun/ballistic/shotgun/trench
	name = "Winchester Model 12"
	desc = "A military shotgun designed for close-quarters fighting, equipped with a bayonet lug."
	icon_state = "trench"
	item_state = "shotguntrench"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	var/select = 0
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = TRUE
	fire_delay = 2
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 22

/obj/item/gun/ballistic/shotgun/trench/update_icon_state()
	if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"


///////////////////////////
//SEMI-AUTOMATIC SHOTGUNS//
///////////////////////////

//Semi-auto shotgun template
/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "semi-auto shotgun template"
	fire_delay = 6
	recoil = 0.1
	spread = 2

/obj/item/gun/ballistic/shotgun/automatic/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	..()
	src.pump(user)

/obj/item/gun/ballistic/shotgun/automatic/combat/update_icon_state()
	if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/shotgun/automatic/combat/auto5
	name = "Browning Auto-5"
	desc = "A semi automatic shotgun with a four round tube."
	fire_delay = 2.7
	recoil = 2
	icon_state = "auto5"
	item_state = "shotgunauto5"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/compact
	fire_sound = 'sound/f13weapons/auto5.ogg'

/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever
	name = "Winchester Model 1887"
	desc = "A pistol grip lever action shotgun with a five-shell capacity underneath plus one in chamber."
	icon_state = "shotgunlever"
	item_state = "shotgunlever"
	icon_prefix = "shotgunlever"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	fire_delay = 3
	slowdown = 0.25
	recoil = 2.1
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	fire_sound = 'sound/f13weapons/shotgun.ogg'
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 23
	knife_y_offset = 23

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead
	name = "Neostead 2000"
	desc = "An advanced shotgun with two separate magazine tubes, allowing you to quickly toggle between ammo types."
	icon_state = "neostead"
	item_state = "shotguncity"
	fire_delay = 5
	recoil = 1.3
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube
	force = 10
	var/toggled = FALSE
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to switch tubes.</span>"

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/Initialize()
	. = ..()
	if (!alternate_magazine)
		alternate_magazine = new mag_type(src)

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/attack_self(mob/living/user)
	. = ..()
	if(!magazine.contents.len)
		toggle_tube(user)

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/proc/toggle_tube(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		to_chat(user, "You switch to tube B.")
	else
		to_chat(user, "You switch to tube A.")

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/AltClick(mob/living/user)
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	toggle_tube(user)

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead_noalt
	name = "Neostead 2000"
	desc = "An advanced shotgun with two separate magazine tubes."
	icon_state = "neostead"
	item_state = "shotguncity"
	fire_delay = 5
	recoil = 1.3
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube_noalt
	force = 10

/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller
	name = "Winchester City-Killer shotgun"
	desc = "A semi automatic shotgun with black tactical furniture made by Winchester Arms. This particular model uses an internal tube magazine."
	icon_state = "citykiller"
	item_state = "shotguncity"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/citykiller
	fire_delay = 4
	autofire_shot_delay = 4.15
	automatic = 1
	recoil = 4.3
	fire_sound = 'sound/f13weapons/riot_shotgun.ogg'

/obj/item/gun/ballistic/automatic/shotgun/pancor
	name = "Pancor Jackhammer"
	desc = "The Jackhammer, despite its name, is an easy to control shotgun, even when fired on full automatic. The popular bullpup design, which places the magazine behind the trigger, makes the weapon well balanced & easy to control." //Nod to Fallout 2 in the description :)
	icon_state = "pancor"
	item_state = "cshotgun1"
	fire_sound = 'sound/f13weapons/repeater_fire.ogg'
	equipsound = 'sound/f13weapons/equipsounds/shotgunequip.ogg'
	mag_type = /obj/item/ammo_box/magazine/d12g
	is_automatic = TRUE
	autofire_shot_delay = 3.55
	fire_delay = 2.85
	recoil = 1.35
	automatic = 1
	pb_knockback = 1
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
