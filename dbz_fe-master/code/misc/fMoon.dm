#define CYCLE_DURATION 2 HOURS

moon
	parent_type = /planet

	var
		list/CYCLES[] = list("New","Waxing Crescent","First Quarter","Waxing Gibbous","Full","Waning Gibbous","Third Quarter","Waning Crescent");
		life = 0;
		currentCycle = 1;
		hostPlanet = NULL;
		planet/planetRef = NULL;

	proc
		_loadMoon(){
			var/rowCount = _rowCount("FROM `moons` WHERE `name`='[sanit(rStrip_Escapes(name))]' AND `hostPlanet`='[hostPlanet]';");

			if(!rowCount){
				world.log << "Moon [name] not found in database now creating entry.";

				_saveMoon();
			}else{
				world.log << "Moon [name] found in database now loading variables.";

				var
					database/query/q = _query("SELECT * FROM `moons` WHERE `name`='[sanit(rStrip_Escapes(name))]' AND `hostPlanet`='[hostPlanet]';");
					list/row;

				q.NextRow()

				row = q.GetRowData();

				currentCycle = text2num(row["currentCycle"]);
				life = text2num(row["life"]);
			}
		}

		_saveMoon(){
			var/rowCount = _rowCount("FROM `moons` WHERE `name`='[sanit(rStrip_Escapes(name))]' AND `hostPlanet`='[hostPlanet]';");

			if(!rowCount){
				_query("INSERT INTO `moons` (`hostPlanet`, `currentCycle`, `life`, `name`) VALUES ('[hostPlanet]', '[currentCycle]', '[life]', '[sanit(rStrip_Escapes(name))]');");
			}else{
				world.log << "Saving moon..";
				_query("UPDATE `moons` SET `life`='[life]', `currentCycle`='[currentCycle]' WHERE `name`='[sanit(rStrip_Escapes(name))]' AND `hostPlanet`='[hostPlanet]';");
			}
		}

		_cyclePassage(){
			set waitfor = FALSE;
			set background = TRUE;

			while(src){

				if(life >= CYCLE_DURATION){
					currentCycle++;

					if(currentCycle > CYCLES.len){
						currentCycle = 1;
					}

					life = 0;
				}

				if(!atmosphere){
					for(var/mob/Player/m in contents){ if(!m.suffocating && !houseSystem.getOxygenGeneratorByInstance(m.insideBuilding)){ m._suffocate(); } }
				}

				sleep(5 SECONDS);

				life += 50;
			}
		}


	New(){
		..()

		if(hostPlanet){
			planetRef = get_area(hostPlanet);

			if(!planetRef){
				world.log << "Failed to find host planet of moon [name].";
			}else{
				planetRef.obtainMoon(src);
			}
		}

		_cyclePassage();
	}

	earth
		name = "{YEarth's{x {WMoon{x";
		locked = FALSE;
		gravity = 0.17;
		atmosphere = FALSE;
		hostPlanet = "earth";
		wrapArea = TRUE;
		hideEdges = FALSE;

