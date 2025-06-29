DBZFE
	var
		world_log = file("dbzfe.log")
		Logger/logger = new(NULL,"SERVER");
		name = "{YDrag({x{R*{x{Y)n{x{RBall Z:{x {WFighter's{x {YEdition{x"
		respawnDaemon/rDaemon
		corpseDaemon/cDaemon
		database/DB
		players[] = list()
		banned_players[] = list()
		banned_ips[] = list()
		locked = FALSE;
		multiplay = FALSE;
		safeTypes[] = list(/turf/earth/safe_zone=TRUE,/turf/earth/gero_lab=TRUE);
		geroTypes[] = list(/turf/earth/gero_lab=TRUE);
		skillList[] = list();
		skillNames[] = list();
		skillTypeNames[] = list();
		skillTypeInternalNames[] = list();
		itemDB[] = list();
		mysteryList[] = list();
		eventList[] = list();
		itemPrefixes[] = list();
		itemNames[] = list();
		itemTypes[] = list();
		npcNames[] = list();
		coolDowns[] = list();
		pkList[] = list();
		mobiles[] = list();
		aggroMobs[] = list();
		teleporters[] = list();
		teachList[] = list(); // Save list of NPCS that teach a given skill

		list/meleeTargets[] = list();
		list/energyTargets[] = list();

		escape_character = "{"
		xterm_escape_character = "^"

		dir_text[] = list(
		    "north",       // 1
		    "south", ,     // 2
		    "east",        // 4
		    "northeast",   // 5
		    "southeast", , // 6
		    "west",        // 8
		    "northwest",   // 9
		    "southwest"    // 10
		)

		map_dir_text[] = list(
		    "north",       // 1
		    "south", ,     // 2
		    "east",        // 4
		    "ne",   // 5
		    "se", , // 6
		    "west",        // 8
		    "nw",   // 9
		    "sw"    // 10
		)

		dir_text_reverse[] = list(
		    "south",       // 1
		    "north", ,     // 2
		    "west",        // 4
		    "southwest",   // 5
		    "northwest", , // 6
		    "east",        // 8
		    "southeast",   // 9
		    "northeast"    // 10
		)

		xterm_escapes[] = list()
		byond_escapes[] = list("{d" = "<font color=#000000>", "{D" = "<font color=#909090>", "{w" = "<font color=#cfcfcf>", "{W" = "<font color=#ffffff>", "{c" = "<font color=#008080>", "{C" = "<font color=#00ffff>", "{m" = "<font color=#cf00cf>", "{M" = "<font color=#ff00ff>", "{r" = "<font color=#cf0000>", "{R" = "<font color=#ff0000>", "{b" = "<font color=#0000cf>", "{B" = "<font color=#0000ff>", "{g" = "<font color=#008000>", "{G" = "<font color=#00ff00>", "{y" = "<font color=#cfcf00>", "{Y" = "<font color=#ffff00>", "{x" = "</font>")
		telnet_escapes[] = list("{d" = "\[0;30m","{D" = "\[1;30m","{w" = "\[0;37m","{W" = "\[1;37m","{c" = "\[0;36m","{C" = "\[1;36m","{m" = "\[0;35m","{M" = "\[1;35m","{r" = "\[0;31m","{R" = "\[1;31m","{b" = "\[0;34m","{B" = "\[1;34m","{g" = "\[0;32m","{G" = "\[1;32m","{y" = "\[0;33m","{Y" = "\[1;33m","{x" = "\[0m","{o" = "\[38;5;166m")

	proc
		addTargeting(name,ATTACKID,type){
			switch(type){
				if(MELEE){
					meleeTargets += list("[name]" = "[ATTACKID]");
				}

				if(ENERGY){
					energyTargets += list("[name]" = "[ATTACKID]");
				}
			}
		}

		removeTargeting(name,ATTACKID,type){
			switch(type){
				if(MELEE){
					meleeTargets -= list("[name]" = "[ATTACKID]");
				}

				if(ENERGY){
					energyTargets -= list("[name]" = "[ATTACKID]");
				}
			}
		}

		findPlayer(name){
			var/FOUND = FALSE;

			for(var/mob/Player/m in players){
				if(lowertext(name) == lowertext(m.name)){
					FOUND = m;
					break;
				}
			}

			return FOUND;
		}

		itemValues(){
			for(var/K in typesof(/obj/item)){

				if(K == /obj/item/corpse) continue

				var/obj/item/X = new K

				itemPrices.Add(list("[X.type]" = X.PRICE))

				del(X)
			}
		}

		checkCooldown(name,skill){
			if(coolDowns.Find("([name])[skill]") && (world.time < coolDowns["([name])[skill]"])){
				return TRUE;
			}

			return FALSE;
		}

		addCooldown(name,skill,time){
			if(!coolDowns.Find("([name])[skill]")){
				coolDowns.Add(list("([name])[skill]" = (world.time + time)))
				return TRUE;
			}else{
				if((world.time >= coolDowns["([name])[skill]"])){
					coolDowns["([name])[skill]"] = (world.time + time)
				}else{
					coolDowns["([name])[skill]"] = (coolDowns["([name])[skill]"] + time);
				}
				return TRUE;
			}

			return FALSE;
		}

		hasPKed(killer,victim){
			if(pkList.Find("([killer])-([victim])") && (world.time < pkList["([killer])-([victim])"])){
				return TRUE;
			}

			return FALSE;
		}

		addPK(killer,victim){
			if(!pkList.Find("([killer])-([victim])")){
				pkList.Add(list("([killer])-([victim])" = (world.time + PK_TIME)))
				return TRUE;
			}else{
				if((world.time >= pkList["([killer])-([victim])"])){
					pkList["([killer])-([victim])"] = (world.time + PK_TIME)
				}else{
					pkList["([killer])-([victim])"] = (pkList["([killer])-([victim])"] + PK_TIME);
				}
				return TRUE;
			}
		}

		buildItem_list(){
			set waitfor=FALSE;

			try{
				for(var/C in typesof(/obj/item)){
					var/obj/item/i = new C

					if(istype(i,/obj/item)){
						if(length(i.DISPLAY) > 0 && i.SHOW_ITEMDB == TRUE){
							itemPrefixes += list(i.type = i.PREFIX);
							itemNames += list(i.type = i.DISPLAY);
							itemTypes += list(rStrip_Escapes(i.DISPLAY) = i.type);
							itemDB += list(i.DISPLAY = "[i.DISPLAY][i.DESC ? "\n[i.DESC]" : ""]\nSTA: [ncheck(i.BONUS_STA)]\nKI: [ncheck(i.BONUS_KI)]\nSTRENGTH: [ncheck(i.BONUS_STR)]\nARMOR: [ncheck(i.BONUS_ARM)]\nMAGIC FIND: [ncheck(i.BONUS_MF)]\nSLOT: [uppertext(_getName(i.SLOT))]\nWEIGHT: {D[i.WEIGHT] kgs.{x\nBUY PRICE: [i.PRICE]\nDROP CHANCE: [i.DROP_CHANCE]%\nITEM TAGS: [i.itemTags()]");
						}
					}

					del(i);
				}
			}
			catch{
			}
		}

		buildNPC_list(){
			set waitfor=FALSE;

			for(var/C in typesof(/mob/NPA)){
				var/mob/NPA/i = new C

				if(length(i.name) > 0){
					npcNames += list(i.type = i.raceColor(i.name));
				}

				if (i.teach.len > 0) {
					buildTeachListFromNPC(i, i.teach)
				}

				if (i.teachShow.len > 0) {
					buildTeachListFromNPC(i, i.teachShow)
				}

				if (i.teachDelayed.len > 0) {
					for(var/f in i.teachDelayed) {
						var/fForm/form = gForm.get(f)
						buildTeachListFromNPC(i, i.teachDelayed[f], form.name)
					}
				}

				i.respawn = FALSE;

				del(i);
			}
		}

		buildTeachListFromNPC(var/mob/npc, var/list/skillList, form=NULL) {

			if (skillList.len > 0) {
				for(var/s in skillList) {
					var/list/currentTeachers = teachList[s]
					if (!currentTeachers) {
						currentTeachers = list()
					}
					var/npcPlanet = getAreaFromPath(npc)
					var/teacherStr = form ? "[npc.name] ([form]) in [npcPlanet]" : "[npc.name] in [npcPlanet]"
					currentTeachers.Add(teacherStr)
					teachList[s] = currentTeachers
				}
			}
		}

		getAreaFromPath(var/mob/NPA/npc) {
			if (istype(npc, /mob/NPA/earth)) return "Earth"
			if (istype(npc, /mob/NPA/arlia)) return "Arlia"
			if (istype(npc, /mob/NPA/freezer)) return "Freezer"
			if (istype(npc, /mob/NPA/hfil)) return "HFIL"
			if (istype(npc, /mob/NPA/kaishin)) return "Kaishin"
			if (istype(npc, /mob/NPA/kaio_planet)) return "King Kaio Planet"
			if (istype(npc, /mob/NPA/korins)) return "Korins Tower"
			if (istype(npc, /mob/NPA/namek)) return "Namek"
			if (istype(npc, /mob/NPA/snakeway)) return "Snakeway"
			if (istype(npc, /mob/NPA/vegeta)) return "Vegeta"

			return "No area found"
		}

		text2Dir(direction){
			switch(direction){
				if("north"){
					return NORTH;
				}

				if("northeast" || "ne"){
					return NORTHEAST;
				}

				if("northwest" || "nw"){
					return NORTHWEST;
				}

				if("south"){
					return SOUTH;
				}

				if("southeast" || "se"){
					return SOUTHEAST;
				}

				if("southwest" || "sw"){
					return SOUTHWEST;
				}

				if("east"){
					return EAST;
				}

				if("west"){
					return WEST;
				}
			}

			return NULL;
		}

		buildSkill_list(){
			set waitfor=FALSE;

			for(var/C in typesof(/Command/Technique)){
				var/Command/Technique/skill = new C

				if(length(skill.internal_name) > 0){
					skillList += list("[skill.internal_name]" = skill.type);
					skillNames += list("[skill.internal_name]" = "[skill.name]");
					skillTypeNames += list(skill.type = skill.name);
					skillTypeInternalNames += list(skill.type = skill.internal_name);
				}

				del(skill);
			}
		}

		getSkillName(path){
			var
				returnSkill = NULL;

			if(skillTypeNames.Find(path)){
				returnSkill = skillTypeInternalNames[path];
			}

			return returnSkill;
		}

		getSkillPath(var/internal_name){
			var
				returnSkill = NULL;

			if(skillList.Find(internal_name)){
				returnSkill = skillList[internal_name];
			}

			return returnSkill;
		}

		buildMystery_list(){
			set waitfor=FALSE;

			for(var/i in typesof(/obj/item)){
				try{
					var/obj/item/x = new i;

					if(!x.MISC && !x.NO_MYSTERY && length(x.DISPLAY) > 0){
						mysteryList += list(x.type = x.DROP_CHANCE);
					}else{ del(x); }

					del(x);
				}

				catch{
				}
			}
		}

		buildEvent_list(){
			set waitfor=FALSE;

			eventList += list(/obj/item/FEARS_PAULDRONS = 1.00);

			for(var/i in typesof(/obj/item)){
				try{
					var/obj/item/x = new i;

					if(!x.MISC && length(x.DISPLAY) > 0){
						eventList += list(x.type = x.DROP_CHANCE);
					}else{ del(x); }

					del(x);
				}

				catch{
				}
			}
		}

		lastRankUpdate(){
			var/database/query/q = _query("SELECT `last_ranking_update` FROM `info`;");
			q.NextRow()
			var/list/row = q.GetRowData();

			return row["last_ranking_update"];
		}

		saveDragonballs(){

			_query("UPDATE `info` SET `earth_db_cooldown`='[DBDatum.COOLDOWN]';");
			_query("UPDATE `info` SET `namek_db_cooldown`='[DBDatum_NAMEK.COOLDOWN]';");

			for(var/obj/item/DRAGONBALLS/d){
				var/rowCount = _rowCount("FROM `dragonballs` WHERE `ID`='[d.type]';");

				if(rowCount){
					_query("UPDATE `dragonballs` SET `x`='[d.x]', `y`='[d.y]', `z`='[d.z]' WHERE `ID`='[d.type]';");
				}else{
					_query("INSERT INTO `dragonballs` (`ID`, `x`, `y`, `z`) VALUES ('[d.type]', '[d.x]', '[d.y]', '[d.z]');");
				}
			}

			for(var/obj/item/NAMEK_DRAGONBALLS/d){
				var/rowCount = _rowCount("FROM `dragonballs` WHERE `ID`='[d.type]';");

				if(rowCount){
					_query("UPDATE `dragonballs` SET `x`='[d.x]', `y`='[d.y]', `z`='[d.z]' WHERE `ID`='[d.type]';");
				}else{
					_query("INSERT INTO `dragonballs` (`ID`, `x`, `y`, `z`) VALUES ('[d.type]', '[d.x]', '[d.y]', '[d.z]');");
				}
			}
		}

		initShops(){
			/*var
				korinsStock = shop.itemQuantity("/mob/NPA/korins/Korin","/obj/item/SENZU_BEAN")*/

			shop.updateItem("/mob/NPA/earth/Bulma","/obj/item/MYSTERY_BOX",1,TRUE);
			shop.updateItem("/mob/NPA/earth/Bulma","/obj/item/SCOUTER",1,TRUE);
			shop.updateItem("/mob/NPA/earth/Bulma","/obj/item/GOLD_BAR",1,TRUE);
			shop.updateItem("/mob/NPA/earth/Bulma","/obj/item/SILVER_BAR",1,TRUE);

			/*if(korinsStock == 0) {
				shop.updateItem("/mob/NPA/korins/Korin","/obj/item/SENZU_BEAN",3,FALSE);
			}*/
		}

		loadDragonballs(){
			var/rowCount = _rowCount("FROM `dragonballs`;");

			if(!rowCount){
				game.logger.info("No dragonballs found... creating now!");
				new /obj/item/DRAGONBALLS/ONE_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),1));
				new /obj/item/DRAGONBALLS/TWO_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),1));
				new /obj/item/DRAGONBALLS/THREE_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),1));
				new /obj/item/DRAGONBALLS/FOUR_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),1));
				new /obj/item/DRAGONBALLS/FIVE_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),1));
				new /obj/item/DRAGONBALLS/SIX_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),1));
				new /obj/item/DRAGONBALLS/SEVEN_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),1));

				new /obj/item/NAMEK_DRAGONBALLS/ONE_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),2));
				new /obj/item/NAMEK_DRAGONBALLS/TWO_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),2));
				new /obj/item/NAMEK_DRAGONBALLS/THREE_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),2));
				new /obj/item/NAMEK_DRAGONBALLS/FOUR_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),2));
				new /obj/item/NAMEK_DRAGONBALLS/FIVE_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),2));
				new /obj/item/NAMEK_DRAGONBALLS/SIX_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),2));
				new /obj/item/NAMEK_DRAGONBALLS/SEVEN_STAR_DRAGONBALL(locate(rand(1,world.maxx),rand(1,world.maxy),2));
			}else{
				var
					database/query/q = _query("SELECT * FROM `dragonballs`;");
					database/query/q2 = _query("SELECT * FROM `info`;");
					list/rowData;
					list/rowData2;
					dbPath = NULL;


				q2.NextRow()
				rowData2 = q2.GetRowData();

				DBDatum.COOLDOWN = text2num(rowData2["earth_db_cooldown"]);
				DBDatum_NAMEK.COOLDOWN = text2num(rowData2["namek_db_cooldown"]);

				while(q.NextRow()){
					rowData = q.GetRowData();

					dbPath = text2path(rowData["ID"]);

					new dbPath(locate(text2num(rowData["x"]),text2num(rowData["y"]),text2num(rowData["z"])));
				}
			}
		}

		logOOC(sender, message){
			_query("INSERT INTO `ooclog` (date, sender, message) VALUES ('[systemTime()]', '[sender]', '[sanit(message)]');")
		}

		dirRev(DIR){
			switch(DIR){
				if(NORTH) return SOUTH
				if(SOUTH) return NORTH
				if(EAST) return WEST
				if(WEST) return EAST
				if(NORTHEAST) return SOUTHWEST
				if(SOUTHWEST) return NORTHEAST
				if(NORTHWEST) return SOUTHEAST
				if(SOUTHEAST) return NORTHWEST
			}
		}

		checkClient(client/c, name){
			var
				count = 0;

			for(var/mob/Player/m in game.players){
				if(c && m.client && c.address == m.client.address && lowertext(name) != lowertext(m.name)){
					count++;
				}
			}

			if(count > 0) { return TRUE; }

			return FALSE;
		}

		checkOnline(name){
			for(var/mob/Player/m in game.players){
				if(lowertext(m.name) == lowertext(name)){
					return m
				}
			}
			return NULL;
		}

		_connectPlayer(client/c, name){
			var
				mob/foundMob = NULL;
				mob/oldMob = c.mob;

			for(var/mob/Player/m in game.players){
				if(lowertext(m.name) == lowertext(name)){
					foundMob = m;
					break;
				}
			}

			if(foundMob){
				send("You have been {RDISCONNECTED{x!",foundMob)
				send("This account has been logged into from a different location.",foundMob);
				sleep(1);
				if(foundMob.output) foundMob.output.uninit();
				foundMob.linkTime = 1;
				if(foundMob.client){ del foundMob.client; }
				c.mob = foundMob;
				del oldMob;
				return TRUE;
			}

			return FALSE;
		}

		wizLocked(){
			if(game.locked){
				return "Wizlocked";
			}else{
				return "OPEN";
			}
		}

		mapdir(dir, reverse=0)
		{
			if(!isnum(dir) || dir < 1 || dir > 10 || dir == 3 || dir == 7) { return "center" }

			if(reverse){
				return dir_text_reverse[dir]
			}
			else{
				return dir_text[dir]
			}
		}

		dir2text(dir, reverse=0)
		{
			if(!isnum(dir) || dir < 1 || dir > 10 || dir == 3 || dir == 7) { return "here" }

			if(reverse){
				return dir_text_reverse[dir]
			}
			else{
				return dir_text[dir]
			}
		}

		dir2text_map(dir, reverse=0)
		{
			if(!isnum(dir) || dir < 1 || dir > 10 || dir == 3 || dir == 7) { return "here" }

			if(reverse){
				return dir_text_reverse[dir]
			}
			else{
				return map_dir_text[dir]
			}
		}

		healSafe(){
			set waitfor=FALSE;

			while(src){
				for(var/mob/Player/m in game.players){
					if(m.isSafe() && !m.doingPushups){
						m._doEnergy(10);
						m.currpl = clamp(m.currpl + ret_percent(10,m.getMaxPL()), MIN_PL, m.getMaxPL());
					}
				}
				sleep(3 SECONDS);
			}
		}

		dailyReboot(){
			set waitfor=FALSE;

			spawn(1){
				sleep(23 HOURS);
				send("{y\[{x{YWORLD{x{y\]{x The server will be rebooting in 1 hour.",game.players);
				sleep(30 MINUTES);
				send("{y\[{x{YWORLD{x{y\]{x The server will be rebooting in 30 minutes.",game.players);
				sleep(15 MINUTES);
				send("{y\[{x{YWORLD{x{y\]{x The server will be rebooting in 15 minutes.",game.players);
				sleep(10 MINUTES);
				send("{y\[{x{YWORLD{x{y\]{x The server will be rebooting in 5 minutes.",game.players);
				sleep(4 MINUTES);
				send("{y\[{x{YWORLD{x{y\]{x The server will be rebooting in 1 minute.",game.players);
				sleep(1 MINUTE);
				send("{y\[{x{YWORLD{x{y\]{x The server is now rebooting.",game.players);
				world.Reboot();
			}
		}

		loadBans(){
			if(fexists("[data_dir]/bans.sav")){
				var/savefile/F=new("[data_dir]/bans.sav")
				F["bannedPlayers"] >> banned_players
				F["bannedIPS"] >> banned_ips
				game.logger.info("[banned_players.len] player bans loaded.")
				game.logger.info("[banned_ips.len] ip bans loaded.")
			}else{
				game.logger.warn("No ban savefile found creating one now!")
				saveBans()
			}
		}

		saveBans(){
			var/savefile/F=new("[data_dir]/bans.sav")
			F["bannedPlayers"] << banned_players
			F["bannedIPS"] << banned_ips
		}

		banPlayer(name){
			banned_players.Add(name)
			saveBans()
		}

		unbanPlayer(name){
			banned_players.Remove(name)
			saveBans()
		}

		banIp(ip){
			banned_ips.Add(ip)
			saveBans()
		}

		unbanIp(ip){
			banned_ips.Remove(ip)
			saveBans()
		}

		addWiz(name, level){
			_query("UPDATE `characters` SET `wizlevel`='[level]' WHERE `name`='[name]' COLLATE NOCASE;")
		}

		removeWiz(name){
			_query("UPDATE `characters` SET `wizlevel`='0' WHERE `name`='[name]' COLLATE NOCASE;")
		}

		immCheck(name){
			var
				rowCount = _rowCount("FROM `characters` WHERE `name`='[name]' COLLATE NOCASE AND `wizlevel`>'0';")

			if(rowCount > 0){
				return TRUE;
			}else{
				return FALSE;
			}
		}

		immLevel(name){
			var
				rowCount = _rowCount("FROM `characters` WHERE `name`='[name]' COLLATE NOCASE;")

			if(rowCount > 0){
				var/database/query/q = _query("SELECT `wizlevel` FROM `characters` WHERE `name`='[name]' COLLATE NOCASE AND `wizlevel`>'0';")
				q.NextRow()
				var/list/row = q.GetRowData()
				return text2num(row["wizlevel"])
			}else{
				return 0
			}
		}

		immMsg(text){
			for(var/mob/m in game.players){
				if(m.isImm){
					send(text,m,TRUE);
				}
			}
		}

		translateIP(ip){
			var/iplist[] = list("204.209.44.14" = "mudconnect.com")
			if(ip in iplist){
				return iplist[ip]
			}else{
				return ip;
			}
		}

		forceRankUpdate(){
			set waitfor = FALSE;

			_query("UPDATE `info` SET `last_ranking_update`='[systemTime()]';");
			_query("DELETE FROM `power_ranking`;");

			var/database/query/q = _query("SELECT `name`, `stats` FROM `characters` WHERE `wizlevel`='0';");

			while(q.NextRow()){
				var
					list/row = q.GetRowData()
					list/player = params2list(row["stats"]);
					rowCount = _rowCount("FROM `power_ranking` WHERE `name`='[rankColor(text2num(player["race"]),row["name"])]';");

				if(rowCount > 0){
					_query("UPDATE `power_ranking` SET `powerlevel`='[player["maxpl"]]' WHERE `name`='[rankColor(text2num(player["race"]),row["name"])]'");
				}else{
					_query("INSERT INTO `power_ranking` (`name`, `powerlevel`) VALUES ('[rankColor(text2num(player["race"]),row["name"])]', '[player["maxpl"]]')");
				}

				sleep(world.tick_lag);
			}
		}

		updateRanking(){
			set waitfor=FALSE;

			var/_updateTime = 2 HOURS;
			var/_lastTime = 2 HOURS;

			while(src){

				if(world.time >= _lastTime){
					_query("UPDATE `info` SET `last_ranking_update`='[systemTime()]';");
					_query("DELETE FROM `power_ranking`;");

					var/database/query/q = _query("SELECT `name`, `stats` FROM `characters` WHERE `wizlevel`='0';");

					while(q.NextRow()){
						var
							list/row = q.GetRowData()
							list/player = params2list(row["stats"]);
							rowCount = _rowCount("FROM `power_ranking` WHERE `name`='[rankColor(text2num(player["race"]),row["name"])]';");


						if(rowCount > 0){
							_query("UPDATE `power_ranking` SET `powerlevel`='[player["maxpl"]]' WHERE `name`='[rankColor(text2num(player["race"]),row["name"])]'");
						}else{
							_query("INSERT INTO `power_ranking` (`name`, `powerlevel`) VALUES ('[rankColor(text2num(player["race"]),row["name"])]', '[player["maxpl"]]')");
						}

						sleep(world.tick_lag);
					}

					_lastTime = (world.time + _updateTime);
				}
				sleep(world.tick_lag);
			}
		}
