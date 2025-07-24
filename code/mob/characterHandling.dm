mob/cClient
	proc/racePath(r){
		switch(r){
			if(SAIYAN){return new /mob/Player/Saiyan}
			if(HUMAN){return new /mob/Player/Human}
			if(NAMEK){return new /mob/Player/Namekian}
			if(ANDROID){return new /mob/Player/Android}
			if(ICER){return new /mob/Player/Icer}
			if(HALFBREED){return new /mob/Player/Halfbreed}
			if(IMMORTAL){return new /mob/Player/Immortal}
			if(KAIO){return new /mob/Player/Kaio}
			if(DEMON){return new /mob/Player/Demon}
			if(GENIE){return new /mob/Player/Genie}
			if(LEGENDARY_SAIYAN){return new /mob/Player/Legendary_Saiyan}
			if(KANASSAN){return new /mob/Player/Kanassan}
			if(ALIEN){return new /mob/Player/Alien}
			if(SPIRIT){return new /mob/Player/Spirit}
			if(BIO_ANDROID){ return new /mob/Player/Bio_Android }
			if(REMORT_ANDROID){return new /mob/Player/Remort_Android}
		}

		game.logger.error("Couldn't find race path")
	}

	proc/loadCharacter(name,COPYOVER=FALSE){
		var
			loadVariables = list(
				"race",
				"sex",
				"alignment",
				"currpl",
				"maxpl",
				"curreng",
				"maxeng",
				"compression",
				"form",
				"labcredits",
				"pvpk",
				"pvpd",
				"pvek",
				"pved",
				"arenaw",
				"arenal",
				"prompt",
				"simultaneous",
				"hasTail",
				"zenni",
				"showDefense",
				"frozen",
				"shortNUM",
				"demonWeapon",
				"insideBuilding",
				"disableMap",
				"defenseOnly",
				"sensePL",
				"sensePLMode",
			)

			itemRowCount = _rowCount("FROM `inventory` WHERE `owner`='[name]' COLLATE NOCASE;")
			database/query/q = _query("SELECT * FROM `characters` WHERE `name`='[name]' COLLATE NOCASE;")

		q.NextRow()

		var
			list/rowData = q.GetRowData()
			load_variables = params2list(rowData["stats"])
			load_equipment = params2list(rowData["equipment"])
			load_techniques = params2list(rowData["techniques"])
			race = text2num(load_variables["race"])
			mob/Player/m
			X = text2num(load_variables["x"]) ? text2num(load_variables["x"]) : 1
			Y = text2num(load_variables["y"]) ? text2num(load_variables["y"]) : 1
			Z = text2num(load_variables["z"]) ? text2num(load_variables["z"]) : 1

		if(game.immCheck(name)){ race = IMMORTAL; isImm = TRUE; }

		m = racePath(race)

		m.name = rowData["name"];

		if(isImm){ m.immLevel = game.immLevel(m.name); m.isImm = TRUE; }

		for(var/x in m.vars){
			if(x in loadVariables){
				if(isnum(text2num(load_variables[x]))){
					m.vars[x] = text2num(load_variables[x])
				}else{
					if(length(load_variables[x]) > 0){
						m.vars[x] = load_variables[x]
					}
				}
			}
		}

		m.visuals = params2list(rowData["visuals"])

		for(var/x in load_equipment){
			var/itemPath = text2path(load_equipment[x])
			if (!itemPath) {
				itemPath = migrateOldPath(load_equipment[x])
			}

			if(!isnum(text2num(x))){
				var/obj/item/z = createItem(itemPath)

				if(z){ m.addInv(z); }
			}else{
				var/obj/item/z = createItem(itemPath)

				if(z){ m.equipment[text2num(x)] = z; }
			}
		}

		if(itemRowCount>0){
			var
				database/query/i = _query("SELECT `ID`, `type` FROM `inventory` WHERE `owner`='[name]' COLLATE NOCASE;");
				list/data;

			while(i.NextRow()){
				data = i.GetRowData()
				var/item = text2path(data["type"])
				if (!item) {
					item = migrateOldPath(data["type"])
				}
				var/obj/item/z = createItem(item)
				if(z){
					z.dBID = text2num(data["ID"]);
					z.Move(m)
				}else{
					_query("DELETE FROM `inventory` WHERE `ID`='[data["ID"]]';");
				}
			}
		}

		for(var/x in load_techniques){
			if(!m.techniques.Find(x)){
				m.techniques += list(game.getSkillPath(x));
			}
		}

		m.channels = params2list(rowData["channels"])

		m.loc=locate(X,Y,Z)

		m.loadAliases();
		m.loadQuests();

		// We need to convert the skillExp from a string to a list of numbers
		var/list/skillExp = params2list(rowData["skillExp"])
		for(var/x in skillExp) {
			m.skillExp[x] = text2num(skillExp[x])
		}

		m.sensePL = ("sensePL" in load_variables) ? text2num(load_variables["sensePL"]) : isAndroid(m) || m.hasSkill("perception")
		m.sensePLMode = ("sensePLMode" in load_variables) ? load_variables["sensePLMode"] : "number"

		client.mob = m

		if(COPYOVER){ 
			send(" {Y({x{R*{x{Y){x  And before you know it, everything has changed  {Y({x{R*{x{Y){x ",m,TRUE); 
		}

		del(src)
	}

mob/Player
	proc/loadAliases(){
		var
			aliasCount = _rowCount("FROM `aliases` WHERE `owner`='[name]';")

		if(aliasCount > 0){
			var
				database/query/alias = _query("SELECT `command`, `function` FROM `aliases` WHERE `owner`='[name]';")
				list/rowData;

			if(aliasList.len > 0) { aliasList.Cut(); }

			while(alias.NextRow()){
				rowData = alias.GetRowData();
				aliasList += list("[rowData["command"]]" = "[rowData["function"]]");
			}

			return TRUE;
		}

		return FALSE;
	}

	proc/saveSQLCharacter(){
		if(!canSave) return FALSE;

		last_seen = "[timeGetTime("month")]/[timeGetTime("date")]/[timeGetTime("year")] [timeGetTime("time")] EST"

		var
			saveVariables = list(
				"race",
				"sex",
				"alignment",
				"currpl",
				"maxpl",
				"curreng",
				"maxeng",
				"x",
				"y",
				"z",
				"compression",
				"form",
				"labcredits",
				"pvpk",
				"pvpd",
				"pvek",
				"pved",
				"arenaw",
				"arenal",
				"prompt",
				"simultaneous",
				"last_seen",
				"hasTail",
				"zenni",
				"showDefense",
				"frozen",
				"shortNUM",
				"demonWeapon",
				"insideBuilding",
				"disableMap",
				"defenseOnly",
				"sensePL",
				"sensePLMode"
			)

			saveParams = list()
			visualParams = list()
			eqParams = list()
			cParams = list()

			rowCount = _rowCount("FROM `characters` WHERE `name`='[name]' COLLATE NOCASE;")

		/* Save Character */
		for(var/x in saveVariables){
			saveParams += list("[x]" = vars["[x]"])
		}
		/* Save Character END */

		/* Save Visuals */
		for(var/x in visuals){
			visualParams += list("[x]" = visuals["[x]"])
		}
		/* Save Visuals END */

		/* Save Equipment */
		for(var/obj/item/i in equipment){
			eqParams += list("[equipment.Find(i)]" = "[i.type]")
		}
		/* Save Equipment END */

		/* Save Techniques */
		for(var/c in techniques){
			cParams += list(game.getSkillName(c))
		}
		/* Save Equipment END */

		if(rowCount > 0){
			_query("UPDATE `characters` SET `visuals`='[list2params(visualParams)]', `stats`='[list2params(saveParams)]', `equipment`='[list2params(eqParams)]', `techniques`='[list2params(cParams)]', `channels`='[list2params(channels)]', `skillExp`='[list2params(skillExp)]' WHERE `name`='[name]' COLLATE NOCASE;")
		}else{
			_query("INSERT INTO `characters` (`name`, `email`, `password`, `visuals`, `stats`, `equipment`, `techniques`, `channels`, `wizlevel`, `skillExp`) VALUES ('[name]', '[email]', '[password]', '[list2params(visualParams)]', '[list2params(saveParams)]', '[list2params(eqParams)]', '[list2params(cParams)]', '[list2params(channels)]', '0', '[vars["skillExp"]]');")
		}

		if(!isImm){ update_ranking(); }

		return TRUE;
	}

// Mapping from old scouter paths to new ones
var/list/pathMigration = list(
    "/obj/item/SCOUTER" = "/obj/item/SCOUTER/GREEN_SCOUTER",
    "/obj/item/RED_SCOUTER" = "/obj/item/SCOUTER/RED_SCOUTER",
    "/obj/item/MASTER_ROSHIS_SUNGLASSES" = "/obj/item/SCOUTER/MASTER_ROSHIS_SUNGLASSES",
    "/obj/item/GENERAL_TAO_POWER_GOGGLES" = "/obj/item/SCOUTER/GENERAL_TAO_POWER_GOGGLES",
    "/obj/item/SHENRONS_LENSES_OF_WISDOM" = "/obj/item/SCOUTER/SHENRONS_LENSES_OF_WISDOM",
    "/obj/item/PORUNGAS_LENSES_OF_DEFIANCE" = "/obj/item/SCOUTER/PORUNGAS_LENSES_OF_DEFIANCE",
    "/obj/item/BLACK_STAR_LENSES_OF_MALICE" = "/obj/item/SCOUTER/BLACK_STAR_LENSES_OF_MALICE",
    "/obj/item/GOLDEN_SCOUTER" = "/obj/item/SCOUTER/GOLDEN_SCOUTER",
    "/obj/item/GODLY_FLAME_SCOUTER" = "/obj/item/SCOUTER/GODLY_FLAME_SCOUTER",
    "/obj/item/RADITZS_SCOUTER_HEADPIECE" = "/obj/item/SCOUTER/RADITZS_SCOUTER_HEADPIECE"
)

proc/migrateOldPath(oldPath) {
    var/newType = pathMigration[oldPath]
    return newType ? text2path(newType) : oldPath
}
