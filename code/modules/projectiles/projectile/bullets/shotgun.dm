/obj/item/projectile/bullet/shotgun_slug
	name = "12g shotgun slug"
	damage = 42
	stamina = 15
	sharpness = SHARP_POINTY
	wound_bonus = 45
	bare_wound_bonus = 30
	armour_penetration = 0.3
	spread = 2
	wound_falloff_tile = -7.5
	supereffective_damage = 62
	supereffective_faction = list("supermutant", "deathclaw", "raider", "wastebot", "radscorpion")

/obj/item/projectile/bullet/pellet
	var/tile_dropoff = 0
	var/tile_dropoff_s = 0

/obj/item/projectile/bullet/pellet/shotgun_buckshot
	name = "buckshot pellet"
	damage = 12
	wound_bonus = 35
	bare_wound_bonus = 90
	wound_falloff_tile = -15.5
	supereffective_damage = 9.5
	tile_dropoff = 3.5
	tile_dropoff_s = 2

	supereffective_faction = list("hostile", "ant", "supermutant", "cazador", "raider", "gecko", "radscorpion")

/obj/item/projectile/bullet/pellet/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_s
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/item/projectile/bullet/pellet/shotgun_improvised
	damage = 4
	wound_bonus = 62
	bare_wound_bonus = 90
	wound_falloff_tile = -15.5
	tile_dropoff = 2
	tile_dropoff_s = 2

/obj/item/projectile/bullet/pellet/shotgun_improvised/Initialize()
	. = ..()
	range = rand(1, 8)

/obj/item/projectile/bullet/pellet/shotgun_improvised/on_range()
	do_sparks(1, TRUE, src)
	..()

/obj/item/projectile/bullet/pellet/flechette
	name = "flechette"
	damage = 2
	stamina = 2
	armour_penetration = 0.95
	wound_bonus = 15
	bare_wound_bonus = 15
	sharpness = SHARP_POINTY //whoosh
	tile_dropoff = 0
	tile_dropoff_s = 0
	hitsound = 'sound/effects/wounds/pierce1.ogg'
