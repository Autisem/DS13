/mob/living/carbon/process_resist()

	//drop && roll
	if(on_fire && !buckled)
		fire_stacks -= 1.2
		Weaken(3)
		spin(32,2)
		visible_message(
			"<span class='danger'>[src] rolls on the floor, trying to put themselves out!</span>",
			"<span class='notice'>You stop, drop, and roll!</span>"
			)
		sleep(30)
		if(fire_stacks <= 0)
			visible_message(
				"<span class='danger'>[src] has successfully extinguished themselves!</span>",
				"<span class='notice'>You extinguish yourself.</span>"
				)
			ExtinguishMob()
		return TRUE

	//unbuckling yourself
	if(buckled)
		if (buckled.resist_buckle(src))
			spawn()
				escape_buckle()
			return TRUE
		else
			return FALSE

	if(..())
		return TRUE

	if(handcuffed)
		spawn() escape_handcuffs()
	else if(legcuffed)
		spawn() escape_legcuffs()

/mob/living/carbon/proc/escape_handcuffs()
	//if(!(last_special <= world.time)) return

	//This line represent a significant buff to grabs...
	// We don't have to check the click cooldown because /mob/living/verb/resist() has done it for us, we can simply set the delay
	set_click_cooldown(100)

	if(can_break_cuffs()) //Don't want to do a lot of logic gating here.
		break_handcuffs()
		return

	var/obj/item/handcuffs/HC = handcuffed

	//A default in case you are somehow handcuffed with something that isn't an obj/item/handcuffs type
	var/breakouttime = 1200
	var/displaytime = 2 //Minutes to display in the "this will take X minutes."
	//If you are handcuffed with actual handcuffs... Well what do I know, maybe someone will want to handcuff you with toilet paper in the future...
	if(istype(HC))
		breakouttime = HC.breakouttime
		displaytime = breakouttime / 600 //Minutes

	var/mob/living/carbon/human/H = src
	if(istype(H) && H.gloves && istype(H.gloves,/obj/item/clothing/gloves/rig))
		breakouttime /= 2
		displaytime /= 2

	visible_message(
		"<span class='danger'>\The [src] attempts to remove \the [HC]!</span>",
		"<span class='warning'>You attempt to remove \the [HC]. (This will take around [displaytime] minutes and you need to stand still)</span>"
		)

	if(do_after(src, breakouttime, incapacitation_flags = INCAPACITATION_DEFAULT & ~INCAPACITATION_RESTRAINED))
		if(!handcuffed || buckled)
			return
		visible_message(
			"<span class='danger'>\The [src] manages to remove \the [handcuffed]!</span>",
			"<span class='notice'>You successfully remove \the [handcuffed].</span>"
			)
		drop_from_inventory(handcuffed)

/mob/living/carbon/proc/escape_legcuffs()
	set_click_cooldown(100)

	if(can_break_cuffs()) //Don't want to do a lot of logic gating here.
		break_legcuffs()
		return

	var/obj/item/legcuffs/HC = legcuffed

	//A default in case you are somehow legcuffed with something that isn't an obj/item/legcuffs type
	var/breakouttime = 1200
	//If you are legcuffed with actual legcuffs... Well what do I know, maybe someone will want to legcuff you with toilet paper in the future...
	if(istype(HC))
		breakouttime = HC.breakouttime

	visible_message(
		SPAN_DANGER("[usr] attempts to remove \the [HC]!"),
		SPAN_WARNING("You attempt to remove \the [HC]. (This will take around [breakouttime / 10] seconds and you need to stand still)")
		)

	if(do_after(src, breakouttime, incapacitation_flags = INCAPACITATION_DEFAULT & ~INCAPACITATION_RESTRAINED))
		if(!legcuffed || buckled)
			return
		visible_message(
			SPAN_DANGER("[src] manages to remove \the [legcuffed]!"),
			SPAN_NOTICE("You successfully remove \the [legcuffed].")
			)

		drop_from_inventory(legcuffed)
		legcuffed = null
		update_inv_legcuffed()

/mob/living/carbon/proc/break_legcuffs()
	to_chat(src, SPAN_WARNING("You attempt to break your legcuffs. (This will take around 5 seconds and you need to stand still)"))
	visible_message(SPAN_DANGER("[src] is trying to break the legcuffs!"))

	if(do_after(src, 5 SECONDS, incapacitation_flags = INCAPACITATION_DEFAULT & ~INCAPACITATION_RESTRAINED))
		if(!legcuffed || buckled)
			return

		visible_message(
			SPAN_DANGER("[src] manages to break the legcuffs!"),
			SPAN_WARNING("You successfully break your legcuffs.")
			)

		say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ))

		qdel(legcuffed)
		legcuffed = null
		update_inv_legcuffed()

/mob/living/carbon/proc/can_break_cuffs()
	if(HULK in mutations)
		return 1

/mob/living/carbon/proc/break_handcuffs()
	visible_message(
		"<span class='danger'>[src] is trying to break \the [handcuffed]!</span>",
		"<span class='warning'>You attempt to break your [handcuffed.name]. (This will take around 5 seconds and you need to stand still)</span>"
		)

	if(do_after(src, 5 SECONDS, incapacitation_flags = INCAPACITATION_DEFAULT & ~INCAPACITATION_RESTRAINED))
		if(!handcuffed || buckled)
			return

		visible_message(
			"<span class='danger'>[src] manages to break \the [handcuffed]!</span>",
			"<span class='warning'>You successfully break your [handcuffed.name].</span>"
			)

		say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ))

		qdel(handcuffed)
		handcuffed = null
		if(buckled && buckled.buckle_require_restraints)
			buckled.unbuckle_mob()
		update_inv_handcuffed()

/mob/living/carbon/human/can_break_cuffs()
	if(species.can_shred(src,1))
		return 1
	return ..()

//Returning anything but true will make the mob unable to resist out of this buckle
/atom/proc/resist_buckle(var/mob/living/user)
	return TRUE

/mob/living/proc/escape_buckle()
	if(buckled)
		buckled.user_unbuckle_mob(src)

/mob/living/carbon/escape_buckle()
	set_click_cooldown(100)
	if(!buckled) return

	if(!restrained())
		..()
	else
		visible_message(
			SPAN_DANGER("[usr] attempts to unbuckle themself!"),
			SPAN_WARNING("You attempt to unbuckle yourself. (This will take around 2 minutes and you need to stand still)")
			)


		if(do_after(usr, 2 MINUTES, incapacitation_flags = INCAPACITATION_DEFAULT & ~(INCAPACITATION_RESTRAINED | INCAPACITATION_BUCKLED_FULLY)))
			if(!buckled)
				return
			visible_message(SPAN_DANGER("\The [usr] manages to unbuckle themself!"),
							SPAN_NOTICE("You successfully unbuckle yourself."))
			buckled.user_unbuckle_mob(src)


/mob/living/carbon/escape_buckle()
	if(src.handcuffed && istype(src.buckled, /obj/effect/energy_net))
		var/obj/effect/energy_net/N = src.buckled
		N.escape_net(src) //super snowflake but is literally used NOWHERE ELSE.-Luke
		return

	set_click_cooldown(100)
	if(!buckled) return

	if(!restrained())
		..()
	else
		visible_message(
			"<span class='danger'>[usr] attempts to unbuckle themself!</span>",
			"<span class='warning'>You attempt to unbuckle yourself. (This will take around 2 minutes and you need to stand still)</span>"
			)


		if(do_after(usr, 2 MINUTES, incapacitation_flags = INCAPACITATION_DEFAULT & ~(INCAPACITATION_RESTRAINED | INCAPACITATION_BUCKLED_FULLY)))
			if(!buckled)
				return
			visible_message("<span class='danger'>\The [usr] manages to unbuckle themself!</span>",
							"<span class='notice'>You successfully unbuckle yourself.</span>")
			buckled.user_unbuckle_mob(src)
