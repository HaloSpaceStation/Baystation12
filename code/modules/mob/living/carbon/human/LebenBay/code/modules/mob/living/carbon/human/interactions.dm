/**********************************
*******Interactions code by HONKERTRON feat TestUnit with translations and code edits by Matt********
**Contains a lot ammount of ERP and MEHANOYEBLYA**
***********************************/

/mob/living/carbon/human/MouseDrop_T(mob/M as mob, mob/user as mob)
	if(M == src || src == usr || M != usr)		return
	if(usr.restrained())		return

	var/mob/living/carbon/human/H = usr
	H.partner = src
	make_interaction(machine)

/mob/proc/make_interaction()
	return

//Distant interactions
///mob/living/carbon/human/verb/interact(mob/M as mob)
//	set name = "Interact"
//	set category = "IC"
//
//	if (istype(M, /mob/living/carbon/human) && usr != M)
//		partner = M
//		make_interaction(machine)

/datum/species/human
	genitals = 1
	anus = 1

/mob/living/carbon/human/proc/get_pleasure_amt(hole)
	switch (hole)
		if ("anal")
			return 7 - (potenzia/5)
		if ("anal-2")
			return get_pleasure_amt("anal") * 0.50
		if ("vaginal")
			switch (potenzia)
				if (-INFINITY to 9)
					return potenzia * 0.33
				if (9 to 16)
					return potenzia * 0.66
				if (16 to INFINITY)
					return potenzia * 1.00
		if ("vaginal-2")
			return get_pleasure_amt("vaginal") * 2

/mob/living/carbon/human/proc/is_nude()
	return (!w_uniform) ? 1 : 0

/mob/living/carbon/human/make_interaction()
	set_machine(src)

	var/mob/living/carbon/human/H = usr
	var/mob/living/carbon/human/P = H.partner
	var/obj/item/organ/external/temp = H.organs_by_name[BP_R_HAND]
	var/hashands = (temp && temp.is_usable())
	if (!hashands)
		temp = H.organs_by_name[BP_L_HAND]
		hashands = (temp && temp.is_usable())
	temp = P.organs_by_name[BP_R_HAND]
	var/hashands_p = (temp && temp.is_usable())
	if (!hashands_p)
		temp = P.organs_by_name[BP_L_HAND]
		hashands = (temp && temp.is_usable())
	var/mouthfree = !(H.wear_mask)
	var/mouthfree_p = !(P.wear_mask)
	var/haspenis = H.has_penis()
	var/haspenis_p = P.has_penis()
	var/hasvagina = (H.gender == FEMALE && H.species.genitals)
	var/hasvagina_p = (P.gender == FEMALE && P.species.genitals)
	var/hasanus_p = P.species.anus
	var/isnude = H.is_nude()
	var/isnude_p = P.is_nude()

	H.lastfucked = null
	H.lfhole = ""

	var/dat = "<B><HR><FONT size=3>INTERACTIONS - [H.partner]</FONT></B><BR><HR>"
	//var/ya = "&#1103;"

	//dat +=  {"• <A href='?src=\ref[usr];interaction=bow'>Bow.</A><BR>"}
	//if (Adjacent(P))
	//	dat +=  {"• <A href='?src=\ref[src];interaction=handshake'>Ïîïðèâåòñòâîâàòü.</A><BR>"}
	//else
	//	dat +=  {"• <A href='?src=\ref[src];interaction=wave'>Ïîïðèâåòñòâîâàòü.</A><BR>"}
	if (hashands)
		dat +=  {"<font size=3><B>Hands:</B></font><BR>"}
		if (Adjacent(P))
			//dat +=  {"• <A href='?src=\ref[usr];interaction=handshake'>Give handshake.</A><BR>"}
			//dat +=  {"• <A href='?src=\ref[usr];interaction=hug'>Hug!</A><BR>"}
			//dat +=  {"• <A href='?src=\ref[usr];interaction=cheer'>Cheer!</A><BR>"}
			//dat +=  {"• <A href='?src=\ref[usr];interaction=five'>Highfive.</A><BR>"}
			//if (hashands_p)
			//	dat +=  {"• <A href='?src=\ref[src];interaction=give'>Give.</A><BR>"}
			//dat +=  {"• <A href='?src=\ref[usr];interaction=slap'><font color=red>Slap!</font></A><BR>"}
			if (isnude_p)
				//if (hasanus_p)
				//	dat += {"• <A href='?src=\ref[usr];interaction=assslap'>Slap some ass!</A><BR>"}
				if (hasvagina_p && (!P.mutilated_genitals))
					dat += {"<A href='?src=\ref[usr];interaction=fingering'>Put fingers in places...</A><BR>"}
			//if (P.species.name == "Tajaran")
			//	dat +=  {"• <A href='?src=\ref[usr];interaction=pull'><font color=red>Pull big fluffy tail!</font></A><BR>"}
			//	if(P.can_inject(H, 1))
			//		dat +=  {"• <A href='?src=\ref[usr];interaction=pet'>Pet.</A><BR>"}
			//dat +=  {"• <A href='?src=\ref[usr];interaction=knock'><font color=red>Knock upside the head.</font></A><BR>"}
		//dat +=  {"• <A href='?src=\ref[usr];interaction=fuckyou'><font color=red>Insult.</font></A><BR>"}
		//dat +=  {"• <A href='?src=\ref[usr];interaction=threaten'><font color=red>Threaten.</font></A><BR>"}

	if (mouthfree && (lying == P.lying || !lying))
		dat += {"<font size=3><B>Mouth:</B></font><BR>"}
		dat += {"<A href='?src=\ref[usr];interaction=kiss'>Kiss.</A><BR>"}
		if (Adjacent(P))
			//if (mouthfree_p)
			//	if (H.species.name == "Tajaran")
			//		dat += {"• <A href='?src=\ref[usr];interaction=lick'>Ëèçíóòü â ùåêó.</A><BR>"}
			if (isnude_p && (!P.mutilated_genitals))
				if (haspenis_p)
					dat += {"<A href='?src=\ref[usr];interaction=blowjob'><font color=purple>Give head.</font></A><BR>"}
				if (hasvagina_p)
					dat += {"<A href='?src=\ref[usr];interaction=vaglick'><font color=purple>Lick pussy.</font></A><BR>"}
				//if (hasanus_p)
				//	dat += {"• <A href='?src=\ref[usr];interaction=asslick'><font color=purple>Lick ass.</font></A><BR>"}
		//	dat +=  {"• <A href='?src=\ref[usr];interaction=spit'><font color=red>Spit.</font></A><BR>"}
		//dat +=  {"• <A href='?src=\ref[usr];interaction=tongue'><font color=red>Stick out tongue.</font></A><BR>"}

	if (isnude && usr.loc == H.partner.loc)
		if (haspenis && hashands)
			dat += {"<font size=3><B>ERP:</B></font><BR>"}
			if (isnude_p)
				if (hasvagina_p && (!P.mutilated_genitals))
					dat += {"<A href='?src=\ref[usr];interaction=vaginal'><font color=purple>Fuck vagina.</font></A><BR>"}
				if (hasanus_p)
					dat += {"<A href='?src=\ref[usr];interaction=anal'><font color=purple>Fuck ass.</font></A><BR>"}
				if (mouthfree_p)
					dat += {"<A href='?src=\ref[usr];interaction=oral'><font color=purple>Fuck mouth.</font></A><BR>"}
	if (isnude && usr.loc == H.partner.loc && hashands)
		if (hasvagina && haspenis_p && (!H.mutilated_genitals))
			dat += {"<font size=3><B>Vagina:</B></font><BR>"}
			dat += {"<A href='?src=\ref[usr];interaction=mount'><font color=purple>Mount!</font></A><BR><HR>"}

	var/datum/browser/popup = new(usr, "interactions", "Interactions", 340, 480)
	popup.set_content(dat)
	popup.open()

//INTERACTIONS
/mob/living/carbon/human
	var/mob/living/carbon/human/partner
	var/mob/living/carbon/human/lastfucked
	var/lfhole
	var/potenzia = 10
	var/resistenza = 200
	var/lust = 0
	var/erpcooldown = 0
	var/multiorgasms = 0
	var/lastmoan
	var/mutilated_genitals = 0 //Whether or not they can do the fug.
	var/virgin = FALSE //:mistake:

/mob/living/carbon/human/proc/cum(mob/living/carbon/human/H as mob, mob/living/carbon/human/P as mob, var/hole = "floor")
	var/message = ""
	var/turf/T

	if (H.gender == MALE)
		var/datum/reagent/blood/source = H.get_blood(H.vessel)
		if (P)
			T = get_turf(P)
		else
			T = get_turf(H)
		if (H.multiorgasms < H.potenzia)
			var/obj/effect/decal/cleanable/cum/C = new(T)
			// Update cum information.
			C.blood_DNA = list()
			if(source.data["blood_type"])
				C.blood_DNA[source.data["blood_DNA"]] = source.data["blood_type"]
			else
				C.blood_DNA[source.data["blood_DNA"]] = "O+"

		if (H.species.genitals)
			if (hole == "mouth" || H.zone_sel.selecting == "mouth")
				message = pick("cums right in [P]'s mouth.")
				var/datum/reagents/holder = new
				var/amt = rand(20,30)
				holder.add_reagent("semen", amt)
				holder.trans_to_mob(P, amt, CHEM_INGEST)

			else if (hole == "vagina")
				message = pick("cums in [P]'s pussy")

			else if (hole == "anus")
				message = pick("cums in [P]'s asshole.")
			else if (hole == "floor")
				message = "cums on the floor!"

		else
			message = pick("cums!", "orgams!")

		playsound(loc, "honk/sound/interactions/final_m[rand(1, 5)].ogg", 70, 1, 0)

		H.visible_message("<B>[H] [message]</B>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<B>[H] [message]</B>")
		H.lust = 5
		H.resistenza += 50

	else
		message = pick("cums!")
		H.visible_message("<B>[H] [message].</B>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<B>[H] [message].</B>")
		playsound(loc, "honk/sound/interactions/final_f[rand(1, 3)].ogg", 90, 1, 0)
		var/delta = pick(20, 30, 40, 50)
		src.lust -= delta

	H.druggy = 60
	H.multiorgasms += 1
	H.erpcooldown = rand(200, 450)
	if (H.multiorgasms > H.potenzia / 3)
		if (H.staminaloss < P.potenzia * 4)
			H.staminaloss += H.potenzia
	if (H.staminaloss > 100)
		H.druggy = 300
		H.erpcooldown = 600
	H.add_event("came", /datum/happiness_event/came)

	times_came++

mob/living/carbon/human/proc/fuck(mob/living/carbon/human/H as mob, mob/living/carbon/human/P as mob, var/hole)
	var/message = ""
	H.adjustStaminaLoss(2)
	switch(hole)

		if("vaglick")

			message = pick("licks [P].", "sucks [P]'s pussy.")

			if (H.lastfucked != P || H.lfhole != hole)
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += 10
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += 10
				if (P.lust >= P.resistenza)
					P.cum(P, H)
				else
					P.moan()
			H.do_fucking_animation(P)

		if("fingering")

			message = pick("fingers [P].", "fingers [P]'s pussy.")
			if (prob(35))
				message = pick("fingers [P] hard.")
			if (H.lastfucked != P || H.lfhole != hole)
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += 8
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += 8
				if (P.lust >= P.resistenza)
					P.cum(P, H)
				else
					P.moan()
			playsound(loc, "honk/sound/interactions/champ_fingering.ogg", 50, 1, -1)
			H.do_fucking_animation(P)

		if("blowjob")
			message = pick("sucks [P]'s dick.", "gives [P] head.")
			if (prob(35))
				message = pick("sucks [P] off.")
			if (H.lust < 6)
				H.lust += 6
			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += 10
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += 10
				if (P.lust >= P.resistenza)
					P.cum(P, H, "mouth")
			playsound(loc, "honk/sound/interactions/bj[rand(1, 11)].ogg", 50, 1, -1)
			H.do_fucking_animation(P)
			if (prob(P.potenzia))
				H.staminaloss += 3
				H.visible_message("<B>[H]</B> goes in deep on <B>[P]</B>.")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<B>[H]</B> goes in deep on <B>[P]</B>.")

		if("vaginal")
			message = pick("fucks [P].",)
			if (prob(35))
				message = pick("pounds [P]'s pussy.")

			if (H.potenzia >= 30)
				P.adjustBruteLoss(H.potenzia/5)
				P << "<span class = 'danger'>Your pussy starts to tear apart!</span>"

			if (H.lastfucked != P || H.lfhole != hole)
				message = pick(" shoves their dick into [P]'s pussy.")
				H.lastfucked = P
				H.lfhole = hole

			if(P.virgin)
				P.virgin = FALSE
				H.visible_message("<font color=purple><B>[H] pop's [P]'s cherry.</B></font>")

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += H.get_pleasure_amt("vaginal-2")
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
				playsound(P.loc.loc, 'sound/effects/clang.ogg', 50, 0, 0)
			H.lust += 10
			if (H.lust >= H.resistenza)
				H.cum(H, P, "vagina")

			if (P.stat != DEAD)
				P.lust += H.get_pleasure_amt("vaginal")
				if (H.potenzia > 20)
					P.staminaloss += H.potenzia * 0.25
				if (P.lust >= P.resistenza)
					P.cum(P, H)
				else
					P.moan()
			H.do_fucking_animation(P)
			playsound(loc, "honk/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)

		if("anal")

			message = pick("fucks [P]'s ass.")
			if (prob(35))
				message = pick("fucks [P]'s ass.")

			if (H.potenzia >= 30)
				P.adjustBruteLoss(H.potenzia/3)
				P << "<span class = 'danger'>Your ass starts to tear apart!</span>"

			if (H.lastfucked != P || H.lfhole != hole)
				message = pick(" shoves their dick into [P]'s asshole.")
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message]</B></font>")
				P.lust += H.get_pleasure_amt("anal-2")
			else
				H.visible_message("<font color=purple>[H] [message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message]</font>")
				playsound(P.loc.loc, 'sound/effects/clang.ogg', 50, 0, 0)
			H.lust += 12
			if (H.lust >= H.resistenza)
				H.cum(H, P, "anus")

			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				if (H.potenzia > 13)
					P.staminaloss += H.potenzia * 0.25
				P.lust += H.get_pleasure_amt("anal")
				if (P.lust >= P.resistenza)
					P.cum(P, H)
				else
					P.moan()
			H.do_fucking_animation(P)
			playsound(loc, "honk/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)

		if("oral")
			message = pick("fucks [P]'s throat.")
			if (prob(35))
				message = pick(" sucks [P]'s [P.gender == FEMALE ? "vag" : "dick"]..", " licks [P]'s [P.gender == FEMALE ? "vag" : "dick"]..")
			if (H.lastfucked != P || H.lfhole != hole)
				message = pick(" shoves their dick down [P]'s throat.")
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && H.stat != DEAD)
				H.visible_message("<font color=purple><B>[H][message]</B></font>")
				H.lust += 15
			else
				H.visible_message("<font color=purple>[H][message]</font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H][message]</font>")
				playsound(P.loc.loc, 'sound/effects/clang.ogg', 50, 0, 0)
			H.lust += 15
			if (H.lust >= H.resistenza)
				H.cum(H, P, "mouth")

			H.do_fucking_animation(P)
			playsound(loc, "honk/sound/interactions/oral[rand(1, 2)].ogg", 70, 1, -1)
			if (P.species.name == "Slime People")
				playsound(loc, "honk/sound/interactions/champ[rand(1, 2)].ogg", 50, 1, -1)
			if (prob(H.potenzia))
				P.staminaloss += 3
				H.visible_message("<B>[H] fucks [P]'s mouth.</B>")
				if (istype(P.loc, /obj/structure/closet))
					P.visible_message("<B>[H] fucks [P]'s mouth.</B>")


		if("mount")
			message = pick("fucks [P]'s dick", "rides [P]'s dick", "rides [P]")
			if (H.lastfucked != P || H.lfhole != hole)
				message = pick("begins to hop on [P]'s dick")
				H.lastfucked = P
				H.lfhole = hole

			if (prob(5) && P.stat != DEAD)
				H.visible_message("<font color=purple><B>[H] [message].</B></font>")
				P.lust += H.potenzia * 2
			else
				H.visible_message("<font color=purple>[H] [message].</font>")
			if(H.virgin)
				H.virgin = FALSE
				H.visible_message("<font color=purple><B>[P] pop's [H]'s cherry.</B></font>")
			if (istype(P.loc, /obj/structure/closet))
				P.visible_message("<font color=purple>[H] [message].</font>")
				playsound(P.loc.loc, 'sound/effects/clang.ogg', 50, 0, 0)
			H.lust += P.potenzia
			if (P.potenzia > 20)
				H.staminaloss += P.potenzia * 0.25
			if (H.lust >= H.resistenza)
				H.cum(H, P)
			else
				H.moan()
			if (P.stat != DEAD && P.stat != UNCONSCIOUS)
				P.lust += H.potenzia
				if (P.lust >= P.resistenza)
					P.cum(P, H, "vagina")
				else
					P.moan()
			H.do_fucking_animation(P)
			playsound(loc, "honk/sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)
			if (H.species.name == "Slime People")
				playsound(loc, "honk/sound/interactions/champ[rand(1, 2)].ogg", 50, 1, -1)

/mob/living/carbon/human/proc/moan()

	var/mob/living/carbon/human/H = src
	switch(species.name)
		if ("Human")
			if (prob(H.lust / H.resistenza * 65))
				var/message = pick("moans", "moans in pleasure",)
				H.visible_message("<B>[H]</B> [message].")
				var/g = H.gender == FEMALE ? "f" : "m"
				var/moan = rand(1, 7)
				if (moan == lastmoan)
					moan--
				if(!istype(loc, /obj/structure/closet))
					playsound(loc, "honk/sound/interactions/moan_[g][moan].ogg", 70, 1, 1)
				else if (g == "f")
					playsound(loc, "honk/sound/interactions/under_moan_f[rand(1, 4)].ogg", 70, 1, 1)
				lastmoan = moan


/mob/living/carbon/human/proc/handle_lust()
	lust -= 4
	if (lust <= 0)
		lust = 0
		lastfucked = null
		lfhole = ""
		multiorgasms = 0
	if (lust == 0)
		erpcooldown -= 1
	if (erpcooldown < 0)
		erpcooldown = 0

/mob/living/carbon/human/proc/do_fucking_animation(mob/living/carbon/human/P)
	var/pixel_x_diff = 0
	var/pixel_y_diff = 0
	var/final_pixel_y = initial(pixel_y)

	var/direction = get_dir(src, P)
	if(direction & NORTH)
		pixel_y_diff = 8
	else if(direction & SOUTH)
		pixel_y_diff = -8

	if(direction & EAST)
		pixel_x_diff = 8
	else if(direction & WEST)
		pixel_x_diff = -8

	if(pixel_x_diff == 0 && pixel_y_diff == 0)
		pixel_x_diff = rand(-3,3)
		pixel_y_diff = rand(-3,3)
		animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
		animate(pixel_x = initial(pixel_x), pixel_y = initial(pixel_y), time = 2)
		return

	animate(src, pixel_x = pixel_x + pixel_x_diff, pixel_y = pixel_y + pixel_y_diff, time = 2)
	animate(pixel_x = initial(pixel_x), pixel_y = final_pixel_y, time = 2)

/obj/item/weapon/enlarger
	name = "penis enlarger"
	desc = "Very special DNA mixture which helps YOU to enlarge your little captain."
	icon = 'icons/obj/items.dmi'
	icon_state = "dnainjector"
	item_state = "dnainjector"
	hitsound = null
	throwforce = 0
	w_class = 1
	throw_speed = 3
	throw_range = 15
	attack_verb = list("stabbed")

/obj/item/weapon/enlarger/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	if(istype(M, /mob/living/carbon/human) && (M.gender == MALE))
		M.potenzia = 30
		M << "<span class='warning'>Your penis extends!</span>"

	else if (istype(M, /mob/living/carbon/human) && M.gender == FEMALE)
		M << "<span class='warning'>It didn't affect you since you're female!</span>"

	..()

	qdel(src)

/obj/item/weapon/enlarger/attack_self(mob/user as mob)
	user << "<span class='warning'>You break the syringe. Gooey mass is dripping on the floor.</span>"
	qdel(src)

/obj/item/weapon/dildo
	name = "dildo"
	desc = "Hmmm, deal throw"
	icon = 'honk/icons/obj/items/dildo.dmi'
	icon_state = "dildo"
	item_state = "c_tube"
	throwforce = 0
	force = 10
	w_class = 1
	throw_speed = 3
	throw_range = 15
	attack_verb = list("slammed", "bashed", "whipped")
	var/hole = "vagina"
	var/pleasure = 10

/obj/item/weapon/dildo/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	var/hasvagina = (M.gender == FEMALE && M.species.genitals && M.species.name != "Unathi" && M.species.name != "Stok")
	var/hasanus = M.species.anus
	var/message = ""

	if(istype(M, /mob/living/carbon/human) && user.zone_sel.selecting == "groin" && M.is_nude())
		if (hole == "vagina" && hasvagina)
			if (user == M)
				message = pick("fucks their own pussy")//, "çàòàëêèâàåò â ñåá[ya] [rus_name]", "ïîãðóæàåò [rus_name] â ñâîå ëîíî")
			else
				message = pick("fucks [M] right in the pussy with the dildo", "jams it right into [M]")//, "çàòàëêèâàåò â [M] [rus_name]", "ïîãðóæàåò [rus_name] â ëîíî [M]")

			if (prob(5) && M.stat != DEAD && M.stat != UNCONSCIOUS)
				user.visible_message("<font color=purple><B>[user] [message].</B></font>")
				M.lust += pleasure * 2

			else if (M.stat != DEAD && M.stat != UNCONSCIOUS)
				user.visible_message("<font color=purple>[user] [message].</font>")
				M.lust += pleasure

			if (M.lust >= M.resistenza)
				M.cum(M, user, "floor")
			else
				M.moan()

			user.do_fucking_animation(M)
			playsound(loc, "honk/sound/interactions/bang[rand(4, 6)].ogg", 70, 1, -1)

		else if (hole == "anus" && hasanus)
			if (user == M)
				message = pick("fucks their ass")
			else
				message = pick("fucks [M]'s asshole")

			if (prob(5) && M.stat != DEAD && M.stat != UNCONSCIOUS)
				user.visible_message("<font color=purple><B>[user] [message].</B></font>")
				M.lust += pleasure * 2

			else if (M.stat != DEAD && M.stat != UNCONSCIOUS)
				user.visible_message("<font color=purple>[user] [message].</font>")
				M.lust += pleasure

			if (M.lust >= M.resistenza)
				M.cum(M, user, "floor")
			else
				M.moan()

			user.do_fucking_animation(M)
			playsound(loc, "honk/sound/interactions/bang[rand(4, 6)].ogg", 70, 1, -1)

		else
			..()
	else
		..()

/obj/item/weapon/dildo/attack_self(mob/user as mob)
	if(hole == "vagina")
		hole = "anus"
	else
		hole = "vagina"
	user << "<span class='warning'>Hmmm. Maybe we should put it in [hole]?!</span>"
