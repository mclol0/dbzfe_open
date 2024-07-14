Command/Public
	look
		name = "look"
		format = "~look; ?!searc(mob@all_mob_loc) | ?~searc(mob@all_mob_loc) | ?!searc(obj@corpse) | ?~searc(obj@corpse) | ?!searc(obj@container) | ?~searc(obj@container)";
		syntax = list("mobile | item name | container")
		canUseWhileRESTING = TRUE;
		priority=2
		helpCategory = "Movement"
		helpDescription = "Look at your surroundings, at a specific character or item in the ground, or at the contents of a given container."
		cancelsPushups = FALSE;

		command(mob/user, target) {
			//var/YOU = FALSE;

			if(target && isloc(user,target)){
				if(istype(target,/mob)){
					if(user == target){
						send("You look at yourself.",user)
						send("[user.raceColor(user.name)] looks at [user.determineSex(2)]self.",a_oview_extra(0,user,target))
						//YOU = TRUE;
					}else{
						send("You look at [target:raceColor(target:name)].",user)
						send("[user.raceColor(user.name)] looks at [target:raceColor(target:name)].",a_oview_extra(0,user,target))
						send("[user.raceColor(user.name)] looks at you.",target)
					}

					send("",user,TRUE);
					send(format_text("{Y [uppertext(target:name)]'S PROFILE{x"),user,TRUE)
					send(format_text("<al2></a><al12>Race:</a> <al45>[target:raceColor(determineRace(target:race))]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Form:</a> <al45>[gForm.getColor(target:form,target:form)]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Gender:</a> <al42>[determineGender(target:sex)]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Alignment:</a> <al45>[determineAlignment(target:alignment)]</a>"),user,TRUE)
					if(isnpc(target)){
						send(format_text("<al2></a><al12>Difficulty:</a> <al42>[determineDifficulty(target:difficultyLevel)]</a>"),user,TRUE)
					}
					send(format_text("{Y [uppertext(target:name)]'S VISUAL APPEARANCE{x"),user,TRUE)
					send(format_text("<al2></a><al12>Hair Length:</a> <al41>[target:visuals["hair_length"]]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Hair Color:</a> <al41>[target:visuals["hair_color"]]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Hair Style:</a> <al41>[target:visuals["hair_style"]]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Eye Color:</a> <al41>[target:visuals["eye_color"]]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Height:</a> <al41>[target:visuals["height"]]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Build:</a> <al41>[target:visuals["build"]]</a>"),user,TRUE)
					send(format_text("<al2></a><al12>Skin Color:</a> <al41>[target:visuals["skin_color"]]</a>"),user,TRUE)
					if(isplayer(target) && (target:race == SAIYAN || target:race == LEGENDARY_SAIYAN)){
						if(target:hasTail == TRUE){
							send(format_text("<al2></a><al12>Tail:</a> <al41>{GPresent{x</a>"),user,TRUE)
						}else{
							send(format_text("<al2></a><al12>Tail:</a> <al41>{RMissing{x</a>"),user,TRUE)
						}
					}
					if(target:findItems()){
						send(format_text("{Y [uppertext(target:name)]'S EQUIPMENT{x"),user,TRUE)
						for(var/i=1,i<EQUIPMENT_SLOTS,i++){
							if(target:equipment[i]){
								var/obj/item/x = target:equipment[i]
								send(format_text("<al2></a><al26>{Y\[{x{R[uppertext(_getName(i))]{x{Y\]{x</a> [x.DISPLAY]"),user,TRUE)
							}else{
								send(format_text("<al2></a><al26>{Y\[{x{R[uppertext(_getName(i))]{x{Y\]{x</a> {REmpty.{x"),user,TRUE);
							}
						}
						/*for(var/obj/item/i in target:equipment){
							var/c = "[i.PREFIX][i.DISPLAY] [i.EQ_MSG0] [i.EQ_MSG] [target:determineSex(1,YOU)] [_getName(target:equipment.Find(i))]"
							send(format_text("<al2></a><al[54+length(c) - length(rStrip_Escapes(c))]]>[c]</a>"),user)
						}*/
					}
					send("",user,TRUE);
				}else if(istype(target,/obj)){
					if (target:CONTAINER) {
						target:displayContents(user)
						return
					}

					//This is a normal item, show the description
					target:showDetails(user)
				}
			}
			else{
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)

				if(!user.insideBuilding && user.loc && user.loc.loc && user.loc.loc:moons && user.loc.loc:moons.len > 0){
					for(var/moon/x in user.loc.loc:moons){
						if(x.currentCycle == 5){
							user.transformOozaru();
						}
					}
				}
			}
		}