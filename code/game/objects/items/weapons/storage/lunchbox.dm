/obj/item/storage/lunchbox
	max_storage_space = 8 //slightly smaller than a toolbox
	name = "rainbow lunchbox"
	icon_state = "lunchbox_rainbow"
	item_state = "toolbox_pink"
	desc = "A little lunchbox. This one is the colors of the rainbow!"
	w_class = ITEM_SIZE_NORMAL
	max_w_class = ITEM_SIZE_SMALL
	var/filled = FALSE
	attack_verb = list("lunched")

/obj/item/storage/lunchbox/New()
	..()
	if(filled)
		var/list/lunches = lunchables_lunches()
		var/lunch = lunches[pick(lunches)]
		new lunch(src)

		var/list/snacks = lunchables_snacks()
		var/snack = snacks[pick(snacks)]
		new snack(src)

		var/list/drinks = lunchables_drinks()
		var/drink = drinks[pick(drinks)]
		new drink(src)

/obj/item/storage/lunchbox/filled
	filled = TRUE

/obj/item/storage/lunchbox/heart
	name = "heart lunchbox"
	icon_state = "lunchbox_lovelyhearts"
	item_state = "toolbox_pink"
	desc = "A little lunchbox. This one has cute little hearts on it!"

/obj/item/storage/lunchbox/heart/filled
	filled = TRUE

/obj/item/storage/lunchbox/cat
	name = "cat lunchbox"
	icon_state = "lunchbox_sciencecatshow"
	item_state = "toolbox_green"
	desc = "A little lunchbox. This one has a cute little science cat from a popular show on it!"

/obj/item/storage/lunchbox/cat/filled
	filled = TRUE

/obj/item/storage/lunchbox/egov
	name = "EarthGov brand lunchbox"
	icon_state = "lunchbox_egov"
	item_state = "toolbox_blue"
	desc = "A little lunchbox. This one is branded with the EarthGov logo!"

/obj/item/storage/lunchbox/egov/filled
	filled = TRUE

/obj/item/storage/lunchbox/scaf
	name = "\improper Sovereign Colonies lunchbox"
	icon_state = "lunchbox_scaf"
	item_state = "toolbox_red"
	desc = "A little lunchbox. This one is branded with the Sovereign Colonies logo! This one looks rather old, almost collectible..."

/obj/item/storage/lunchbox/scaf/filled
	filled = TRUE

/obj/item/storage/lunchbox/cti
	name = "\improper CTI lunchbox"
	icon_state = "lunchbox_cti"
	item_state = "toolbox_blue"
	desc = "A little lunchbox. This one is branded with the CTI logo!"

/obj/item/storage/lunchbox/cti/filled
	filled = TRUE

/obj/item/storage/lunchbox/cec
	name = "\improper CEC lunchbox"
	icon_state = "lunchbox_cec"
	item_state = "toolbox_yellow"
	desc = "A little lunchbox. This one is branded with the CEC logo!"

/obj/item/storage/lunchbox/cec/filled
	filled = TRUE

/obj/item/storage/lunchbox/unitology
	name = "\improper Unitology lunchbox"
	icon_state = "lunchbox_unit"
	item_state = "toolbox_syndi"
	desc = "A little lunchbox. This one is a sleek black and red, with a Marker symbol in the middle of it. made of a durable steel!"

/obj/item/storage/lunchbox/unitology/filled
	filled = TRUE

/obj/item/storage/lunchbox/TCC
	name = "\improper TCC lunchbox"
	icon_state = "lunchbox_tcc"
	item_state = "toolbox_syndi"
	desc = "A little lunchbox. This one is branded with the flag of the Terran Colonial Confederation!"

/obj/item/storage/lunchbox/syndicate/filled
	filled = TRUE

