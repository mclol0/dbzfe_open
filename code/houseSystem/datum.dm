var/lastHouseID = 1 // Temporary holder for in-game map stuff.
var/HOUSESYSTEM/houseSystem = new();

#define INSIDE_MAP_X 3
#define INSIDE_MAP_Y 3

HOUSESYSTEM
	var
		list/TURFS[0]
		list/CAPSULES[0]
		list/COLORS[0]

		//DB Related
		DBHOUSESTABLE = "playerhouses"
		DBUPGRADESTABLE = "playerhouseupgrades"
		list/DBTABLES[0]
		FIXCMD = "hsfixdb"
		DBINTEGRITTYCHECK = FALSE

		//Room Names
		ENTRANCE = "entrance"
		ROOM = "room"
		STORAGE = "storage"
		TRAINING = "dojo"
		MEDBAY = "rest"
		DRESSER = "dresser"
		TELEPORT = "teleport"

		//Room/Upgrades
		MEDPOD = "medpod"

		//Upgrade Names
		STASH = "stash"
		TCONSOLE = "trainingconsole"
		TPAD = "teleporter"
		GRAVITYGEN = "gravitygenerator"
		TSHIELD = "teleportshield"
		WARDROBE = "wardrobe"
		OGENERATOR = "oxygengenerator"

		list/UPGRADES[0]

	New() {
		DBTABLES[DBHOUSESTABLE] = "CREATE TABLE `playerhouses` ( `ID` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, `owner` TEXT NOT NULL, `type` TEXT NOT NULL, `color` TEXT NOT NULL, `loc` TEXT NOT NULL, `upgrades` TEXT NOT NULL, `originalturf` TEXT NOT NULL, `instanceID` INTEGER, `attributes` TEXT )"
		DBTABLES[DBUPGRADESTABLE] = "CREATE TABLE `playerhouseupgrades` ( `ID` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, `loc` TEXT NOT NULL, `type` TEXT NOT NULL, `attributes` TEXT NOT NULL, `owner` TEXT NOT NULL )"

		UPGRADES[STASH] = /obj/item/HOUSESYSTEM/UPGRADES/STASH
		UPGRADES[TCONSOLE] = /obj/item/HOUSESYSTEM/UPGRADES/INTERACTABLE/TCONSOLE
		UPGRADES[TPAD] = /obj/item/HOUSESYSTEM/UPGRADES/TPAD
		UPGRADES[GRAVITYGEN] = /obj/item/HOUSESYSTEM/UPGRADES/INTERACTABLE/GRAVITYGEN
		UPGRADES[TSHIELD] = /obj/item/HOUSESYSTEM/UPGRADES/TSHIELD
		UPGRADES[MEDPOD] = /obj/item/HOUSESYSTEM/UPGRADES/MEDPOD
		UPGRADES[WARDROBE] = /obj/item/HOUSESYSTEM/UPGRADES/STASH/WARDROBE
		UPGRADES[OGENERATOR] = /obj/item/HOUSESYSTEM/UPGRADES/OXYGENGENERATOR

		TURFS[ENTRANCE] = /turf/HOUSESYSTEM/player/entrance
		TURFS[ROOM] = /turf/HOUSESYSTEM/player/room
		TURFS[STORAGE] = /turf/HOUSESYSTEM/player/storage
		TURFS[TRAINING] = /turf/HOUSESYSTEM/player/training
		TURFS[MEDBAY] = /turf/HOUSESYSTEM/player/medbay
		TURFS[DRESSER] = /turf/HOUSESYSTEM/player/dresser
		TURFS[TELEPORT] = /turf/HOUSESYSTEM/player/teleport

		CAPSULES[ENTRANCE] = /obj/item/HOUSESYSTEM/CAPSULE/ENTRANCE
		CAPSULES[ROOM] = /obj/item/HOUSESYSTEM/CAPSULE/ROOM
		CAPSULES[STORAGE] = /obj/item/HOUSESYSTEM/CAPSULE/STORAGE
		CAPSULES[TRAINING] = /obj/item/HOUSESYSTEM/CAPSULE/TRAINING
		CAPSULES[MEDBAY] = /obj/item/HOUSESYSTEM/CAPSULE/MEDBAY
		CAPSULES[DRESSER] = /obj/item/HOUSESYSTEM/CAPSULE/DRESSER
		CAPSULES[TELEPORT] = /obj/item/HOUSESYSTEM/CAPSULE/TROOM
		CAPSULES[STASH] = /obj/item/HOUSESYSTEM/CAPSULE/STASH
		CAPSULES[TCONSOLE] = /obj/item/HOUSESYSTEM/CAPSULE/TCONSOLE
		CAPSULES[TPAD] = /obj/item/HOUSESYSTEM/CAPSULE/TPAD
		CAPSULES[GRAVITYGEN] = /obj/item/HOUSESYSTEM/CAPSULE/GRAVITYGEN
		CAPSULES[TSHIELD] = /obj/item/HOUSESYSTEM/CAPSULE/TSHIELD
		CAPSULES[MEDPOD] = /obj/item/HOUSESYSTEM/CAPSULE/MEDPOD
		CAPSULES[OGENERATOR] = /obj/item/HOUSESYSTEM/CAPSULE/OXYGENGENERATOR
		CAPSULES[WARDROBE] = /obj/item/HOUSESYSTEM/CAPSULE/WARDROBE

		COLORS["dark yellow"] = "y"
		COLORS["yellow"] = "Y"
		COLORS["dark cyan"] = "c"
		COLORS["cyan"] = "C"
		COLORS["purple"] = "m"
		COLORS["magenta"] = "M"
		COLORS["dark red"] = "r"
		COLORS["red"] = "R"
		COLORS["dark blue"] = "b"
		COLORS["blue"] = "B"
		COLORS["dark green"] = "g"
		COLORS["green"] = "G"
		COLORS["dark gray"] = "D"
		COLORS["gray"] = "w"
		COLORS["white"] = "W"
		COLORS["orange"] = "o"
	}

	proc
		deletePlayer(name) {
			_query("DELETE FROM `[DBHOUSESTABLE]` WHERE `owner`='[name]';");
			_query("DELETE FROM `[DBUPGRADESTABLE]` WHERE `owner`='[name]';");
		}

		_deleteTurfFromDB(dbID) {
			_checkDBIntegrity()
			_query("DELETE FROM `[DBHOUSESTABLE]` WHERE ID = [num2text(dbID)];")
		}

		_loadTurfsFromDB(mob/user) {
			_checkDBIntegrity(user)
			var/database/query/q = _query("SELECT * FROM `[DBHOUSESTABLE]`;")

			var/list/rowData
			while(q.NextRow()) {
				rowData = q.GetRowData()
				var/list/locList = params2list(rowData["loc"])
				var/x = text2num(locList["x"])
				var/y = text2num(locList["y"])
				var/z = text2num(locList["z"])
				var/turf/T = locate(x, y, z)

				if (T) {
					T.Change(text2path(rowData["type"]))
					T:owner = rowData["owner"]
					T:roomColor = rowData["color"]
					T:currentUpgrades = _params2list(rowData["upgrades"])
					T:dbID = text2num(rowData["ID"])
					T:originalTurf = rowData["originalturf"]
					T:instanceId = rowData["instanceID"] ? rowData["instanceID"] : NULL

					if (rowData["attributes"]) {
						var/list/attrList = params2list(rowData["attributes"])
						if (attrList["allowedaccess"])
							T:allowedAccess = params2list(attrList["allowedaccess"])
						if (attrList["deniedaccess"])
							T:deniedAccess = params2list(attrList["deniedaccess"])
					}
				}
			}
		}

		_saveTurfToDB(list/loc, type, color, owner, list/upgrades, originalTurf, attrList=list(), instanceId=NULL, dbID=NULL) {
			_checkDBIntegrity()

			upgrades = upgrades ? upgrades : list()
			if (!dbID) {
				_query("INSERT INTO `[DBHOUSESTABLE]` (owner, type, color, loc, upgrades, originalturf, instanceId, attributes) VALUES('[owner]', '[type]', '[color]', '[list2params(loc)]', '[list2params(upgrades)]', '[originalTurf]', [instanceId ? instanceId : "NULL"], '[sanit(list2params(attrList))]');")
			} else {
				_query("UPDATE `[DBHOUSESTABLE]` SET `owner`='[owner]', `type`='[type]', `color`='[color]', `loc`='[list2params(loc)]', `upgrades`='[list2params(upgrades)]', `instanceID` = [instanceId], attributes='[sanit(list2params(attrList))]' WHERE `ID` = [dbID];")
			}
		}

		_saveUpgradeToDB(list/loc, type, list/attributes, owner, dbID=NULL) {
			_checkDBIntegrity()
			attributes = attributes ? attributes : list()
			if (!dbID) {
				_query("INSERT INTO `[DBUPGRADESTABLE]` (loc, type, attributes, owner) VALUES('[list2params(loc)]', '[type]', '[sanit(list2params(attributes))]', '[owner]')")
			} else {
				_query("UPDATE `[DBUPGRADESTABLE]` SET loc='[list2params(loc)]', type='[type]', owner='[owner]', attributes='[sanit(list2params(attributes))]' WHERE ID = [dbID]")
			}
		}

		_loadUpgradesFromDB() {
			_checkDBIntegrity()
			var/database/query/q = _query("SELECT * FROM `[DBUPGRADESTABLE]`;")

			var/list/rowData
			while(q.NextRow()) {
				rowData = q.GetRowData()
				var/list/locList = params2list(rowData["loc"])
				var/x = text2num(locList["x"])
				var/y = text2num(locList["y"])
				var/z = text2num(locList["z"])

				var/T = text2path(rowData["type"])
				var/list/attributes = params2list(rowData["attributes"])
				var/O = rowData["owner"]

				//Create a new item in the location
				var/obj/item/HOUSESYSTEM/I = new T(locate(x, y, z))
				I.insideBuilding = I.loc:instanceId
				I.owner = O

				I:loadAttributes(attributes)
				I.dBID = text2num(rowData["ID"])
			}
		}

		_removeFromSharedHouses(playerName){
			for(var/turf/HOUSESYSTEM/player/p){
				p._removeAccess(playerName);
			}

			for(var/obj/item/HOUSESYSTEM/UPGRADES/m){
				m.removeAccess(playerName);
			}
		}

		_deleteUpgradeFromDB(dBID) {
			_checkDBIntegrity()
			_query("DELETE FROM `[DBUPGRADESTABLE]` WHERE ID = [dBID]")
		}

		loadSystemData() {
			_loadTurfsFromDB()
			_loadUpgradesFromDB()
		}

		getLastID(tableName, owner){
			var/rowCount = _rowCount("FROM `[tableName]`;");

			if(!rowCount) return 1;

			var
				database/query/q = _query("SELECT `ID` FROM `[tableName]` ORDER BY `ID` DESC LIMIT 1;");
				list/rowData;

			q.NextRow();

			rowData = q.GetRowData();

			return text2num(rowData["ID"]);
		}

		build(mob/user, turf/targetTurf, var/instanceId) {
			var/originalTurf = user.loc.type
			if (targetTurf) {
				user.changeTurf(targetTurf, 0)
			}

			// Grant ownership to the player
			var/turf/HOUSESYSTEM/player/T = user.loc
			T.owner = user.name
			T.originalTurf = originalTurf
			T.instanceId = instanceId

			// Save the turf information
			send("You grab a Corp capsule and drop it in front of you. A new [T.CREATEMSG] pops up right before your eyes!", user)
			T.save()
			T.dbID = getLastID(DBHOUSESTABLE)

			if (istype(T, TURFS[ENTRANCE]) && !instanceId) {
				//Save again to store the instance id
				T.instanceId = T.dbID
				T.save()
			}
		}

		getNearbyInstanceID(mob/user) {
			for(var/OT in t_oview(1, user)) {
				if (istype(OT, /turf/HOUSESYSTEM/player) && OT:isOwner(user) && OT:loc != user.loc) {
					return OT:instanceId
				}
			}

			return NULL
		}

		changeTurfColor(mob/user, color) {
			var/turf/HOUSESYSTEM/player/currentTurf = user.loc

			currentTurf.switchColor(color)
			var/colorChar = houseSystem.COLORS[color]
			send("You press the {[colorChar][color]{x button on the control panel of this room.", user)
			currentTurf.save()
		}

		canBuild(mob/user, turf/targetTurf) {
			if(user.getArea() == get_area("earth")){
				send("Cannot build here", user)
				return FALSE
			}
			// Check if player is in safe zone
			if (user.isSafe())
			{
				send("Cannot build in safe room", user)
				return FALSE
			}

			// Check invalid turfs
			var/turf/currentTurf = user.loc
			if (isPlayerTurf(currentTurf)) {
				send("You cannot build on this location", user)
				return FALSE
			}

			// Check if the current turf has density or is water
			if (currentTurf.density || currentTurf:tType == WATER || currentTurf:tType == MOUNTAIN) {
				send("You cannot build on water, mountains or locations that you cannot walk through", user)
				return FALSE
			}

			//Check targetTurf positioning

			if (ispath(targetTurf, /turf/HOUSESYSTEM/player) && getAdjacentTurfInstanceID(user) || user.isImm || ispath(targetTurf, /turf/HOUSESYSTEM/player/entrance) && !getAdjacentTurfInstanceID(user)) {
				return TRUE
			}

			send(format_text("Invalid build location. You need to place a room:\n<al2></a>1) Adjacent to an entrance OR\n<al2></a>2) Adjacent to another already built room you own AND\n<al2></a>3) Not in between two different houses."), user)
			return FALSE
		}

		colorsToString(separator=",") {
			var/V = ""
			for(var/I in COLORS) {
				if (V != "")
					V = "[V][separator]"

				var/colorChar = COLORS[I]
				V = "[V]{[colorChar][I]{x"
			}

			return V
		}

		turfsToString(separator=", ") {
			return __listToText(TURFS, separator)
		}

		upgradesToString(separator=", ") {
			return __listToText(UPGRADES, separator)
		}

		isPlayerTurf(turf/currentTurf) {
			for(var/T in TURFS) {
				if (istype(currentTurf, TURFS[T])) {
					return TRUE
				}
			}

			return FALSE
		}

		isUpgrade(obj/O) {
			for(var/I in UPGRADES) {
				if (istype(O, UPGRADES[I])) {
					return TRUE
				}
			}

			return FALSE
		}

		canEnterHouse(mob/user) {
			if (!istype(user.loc, TURFS[ENTRANCE])) {
				send("There is no entrance to a house here.", user)
				return FALSE
			}

			if (user.insideBuilding) {
				send("You seem to be already inside a building. Did you mean to exit?", user)
				return FALSE
			}

			if (!user.loc:hasAccess(user) && !user.isImm) {
				send("You try to open the door but it won't activate for you.", user)
				send("[user.raceColor(user.name)] tries to open the door but it doesn't activate for [user.determineSex(2)].", _ohearers(user, 0))
				return FALSE
			}

			return TRUE
		}

		canExitHouse(mob/user) {
			if (!istype(user.loc, TURFS[ENTRANCE])) {
				send("There is no door to exit the house here.", user)
				return FALSE
			}

			if (!user.insideBuilding) {
				send("You seem to be out already. Did you mean to enter?", user)
				return FALSE
			}

			return TRUE
		}

		canEnterTurf(mob/m, turf/T)
		{
			if (isPlayerTurf(T) && !T:isOwner(m) && !m.insideBuilding && T.type != TURFS[ENTRANCE]) {
				return FALSE
			}

			if (isPlayerTurf(T) && T:isOwner(m) && !m.insideBuilding && m.density == T.density) {
				return FALSE
			}

			if (m.insideBuilding && !isPlayerTurf(T)) {
				return FALSE
			}

			return TRUE
		}

		_checkPlayerTurfs(mob/user) {
			for(var/turf/AT in t_oview(1,user)) {
				if (ispath(AT.type, /turf/HOUSESYSTEM/player)) {
					return FALSE
				}
			}

			return TRUE
		}

		getOxygenGeneratorByInstance(var/instanceID){
			for(var/obj/item/HOUSESYSTEM/UPGRADES/OXYGENGENERATOR/o){
				if(o.insideBuilding == instanceID){
					return TRUE
				}
			}

			return FALSE
		}

		getGravityGeneratorByInstance(var/instanceID){
			for(var/obj/item/HOUSESYSTEM/UPGRADES/INTERACTABLE/GRAVITYGEN/o){
				if(o.insideBuilding == instanceID){
					return TRUE
				}
			}

			return FALSE
		}

		getAdjacentTurfInstanceID(mob/user) {
			var/instanceId = NULL
			var/firstIdFound = NULL
			var/list/instanceIDs[] = list()

			for(var/turf/Turf in t_oview(1,user)){
				var/turf/checkTurf = Turf;
				for (var/T in TURFS) {
					if (checkTurf.type == TURFS[T]) {
						if (checkTurf:isOwner(user)) {
							instanceId = checkTurf:instanceId

							if (!firstIdFound) {
								firstIdFound = checkTurf:instanceId
							}

							instanceIDs.Add(checkTurf:instanceId);
						}
					}
				}
			}

			for(var/X in instanceIDs){
				if(firstIdFound != X){
					return NULL
				}
			}

			return instanceId
		}

		_checkDBIntegrity(mob/user, var/checkOnly = FALSE, var/forceCheck = FALSE)
		{
			var/finalResult = forceCheck ? FALSE : DBINTEGRITTYCHECK
			if (!DBINTEGRITTYCHECK || forceCheck) {
				if (user && user.isImm) send("Validating DB Structure for the House System", user)

				var/list/checkResults = list()
				for(var/T in DBTABLES) {
					var/rowCount = _rowCount("FROM sqlite_master WHERE type='table' and name = '[T]'")

					if (rowCount == 0) {
						checkResults += FALSE
						world.log << "Table '[T]' was not found on the DB."
						if (user && user.isImm) send("Table '[T]' was not found on the DB.", user)

						if (!checkOnly) {
							world.log << "Executing create statement for table '[T]'."
							_query(DBTABLES[T])
						}
					} else {
						checkResults += TRUE
					}
				}

				if (!checkOnly) {
					finalResult = _checkDBIntegrity(user, TRUE)
				} else {
					var/secondCheck = TRUE
					for(var/C in checkResults) {
						if (!C) {
							secondCheck = FALSE
						}

						if (forceCheck && user) {
							var/result = C ? "PASSED" : "FAILED"
							send("Integrity check for the table [result] passed succesfully.", user)
						}
					}

					return secondCheck
				}
			}

			if (!checkOnly) {
				DBINTEGRITTYCHECK = finalResult
			}

			return finalResult
		}

		_getNameFromPath(var/list/L, var/path) {
			for(var/name in L)
			{
				if (L[name] == path) {
					return name
				}
			}
		}