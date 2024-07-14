
/var/global/list
	global.planets[] = list("EARTH'S MOON" = locate(202,227,3),"EARTH" = locate(211,202,3), "NAMEK" = locate(147,130,3), "ARLIA" = locate(26,24,3), "VEGETA" = locate(212,20,3), "FRIEZA" = locate(220,112,3), "KAISHIN" = locate (47,108,3), "BAS" = locate (79,230,3))

obj
	spacepod
		var/saveRef = NULL;

		proc
			travelTo(atom/x){
				set waitfor = FALSE;

				var
					goTime = world.time;
					planet/planet = locate(x)

				saveRef = planet.name;

				ref:traveling = uppertext(rStrip_Escapes(planet.name))

				while(src && ref:traveling){
					if(world.time >= goTime){
						for(var/i=0,i<2,i++){
							var/obj/trail/A = new(loc)
							A.setDisplay("{W~{x")
							Move(get_step(src,a_get_dir(src,global.planets[ref:traveling])), a_get_dir(src,global.planets[ref:traveling]),0,0,TRUE)
							if(loc == global.planets[ref:traveling]){
								warpArea(rand(1,planet.getDX()),rand(1,planet.getDY()),x)
								ref:loc=src.loc
								send(buildMap(ref,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),ref)

								if(istype(planet,/moon)){
									send("You arrive on [saveRef].",ref)
								}else{
									send("You arrive on planet [saveRef].",ref)
								}

								if(rStrip_Escapes(saveRef) == "Namek"){
									qFac.updateVariable(ref,"Q004_TRAVEL_TO_NAMEK","Travel to Namek",TRUE);
									qFac.updateVariable(ref,"LS_06","Travel to Namek",TRUE);
								}
								ref:traveling=NULL;
								return
							}
						}
						ref:loc=src.loc
						send(buildMap(ref,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),ref)
						goTime = (world.time + 8);
					}
					sleep(world.tick_lag)
				}
			}
