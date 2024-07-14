turf
	HOUSESYSTEM
		player
			var
				dbID = NULL
				owner = NULL
				DISPLAYCHAR = NULL
				DISPLAYNAME = NULL
				roomColor = NULL
				list/currentUpgrades[0]
				list/maxUpgrades[0]
				CREATEMSG = NULL
				originalTurf = NULL
				DESC = NULL
				itLocked = FALSE
				instanceId = 0
				list/allowedAccess = list()
				list/deniedAccess = list()

			density = TRUE

			New(){
				..()

				// Build the default list of upgrades
				for(var/U in houseSystem.UPGRADES) {
					maxUpgrades[U] = 0
				}

				//default for all
				maxUpgrades[houseSystem.TSHIELD] = 1
			}

			showDisplay() {
				var/colorChar = houseSystem.COLORS[roomColor]
				return "{[colorChar][DISPLAYCHAR]{x"
				switch(roomColor) {
					if ("red") return "{R[DISPLAYCHAR]{x"
					if ("yellow") return "{Y[DISPLAYCHAR]{x"
					if ("blue") return "{B[DISPLAYCHAR]{x"
					if ("magenta") return "{M[DISPLAYCHAR]{x"
				}
			}

			Enter(mob/m, turf/oldloc) {

				if ((!m.density && !m.insideBuilding) || (m.density && m.insideBuilding && m.insideBuilding == oldloc:instanceId) || type == houseSystem.TURFS[houseSystem.ENTRANCE]) {
					return 1
				}

				if (isDenied(m.name)) {
					send("You are not allowed to go in there.", m)
					return FALSE
				}

				..()
			}

			Exit(mob/m, turf/newloc) {
				if (istype(m, /obj) || !m:insideBuilding || (houseSystem.isPlayerTurf(newloc) && m:insideBuilding == newloc:instanceId)) {
					return 1
				}

				..()
			}

			proc
				save() {
					var/list/locList[0]
					locList["x"] = x
					locList["y"] = y
					locList["z"] = z

					var/list/attrList = list()

					attrList["allowedaccess"] = list2params(allowedAccess)
					attrList["deniedaccess"] = list2params(deniedAccess)

					houseSystem._saveTurfToDB(locList, type, roomColor, owner, currentUpgrades, originalTurf, attrList, instanceId, dbID)
				}

				isOwner(mob/user)
				{
					return owner == user.name
				}

				hasAccess(mob/user) {
					if (isOwner(user) || isAllowed(user.name) || !owner) {
						return TRUE
					}

					return FALSE
				}

				giveAccess(name) {
					if (!(name in allowedAccess)) {
						allowedAccess += name
					}

					if ((name in deniedAccess)) {
						deniedAccess -= name
					}

					save()
				}

				isAllowed(name) {
					return (name in allowedAccess) && !(name in deniedAccess)
				}

				isDenied(name) {
					return (name in deniedAccess)
				}

				_removeAccess(name){
					if ((name in allowedAccess)) {
						allowedAccess -= name
					}

					save()
				}

				removeAccess(name) {
					if ((name in allowedAccess)) {
						allowedAccess -= name
					}

					if (!(name in deniedAccess)) {
						deniedAccess += name
					}

					save()
				}

				switchColor(color) {
					src.roomColor = color
				}

				getName() {
					return src.DISPLAYNAME
				}

				addUpgrade(upgrade) {
					currentUpgrades[upgrade] += 1
					save()
				}

				removeUpgrade(upgrade) {
					currentUpgrades[upgrade] -= 1
					save()
				}

				createInfoBuffer() {
					var/list/buffer = list()

					buffer += "[getName()]\n"
					buffer += "[DESC]\n"
					buffer += format_text("<al9>Owner:</a>[owner]\n")
					buffer += format_text("Upgrades:\n")

					for(var/U in maxUpgrades) {
						if (maxUpgrades[U] > 0) {
							var/itemPath = houseSystem.UPGRADES[U]
							var/obj/item/I = new itemPath
							var/C = !currentUpgrades[U] ? 0 : currentUpgrades[U]
							buffer += format_text("<al2></a>- <al20>[I.DISPLAY]:</a>[C] of [maxUpgrades[U]]\n")
						}
					}

					return buffer
				}

				hasUpgrades() {
					for(var/U in currentUpgrades) {
						var/current = text2num(currentUpgrades[U])
						if (current > 0) {
							return TRUE
						}
					}

					return FALSE
				}

				unbuild(mob/user, removeUpgrades = FALSE) {
					//Create the object to put back in the player inv
					var/room = houseSystem._getNameFromPath(houseSystem.TURFS, type)
					var/turfPath = houseSystem.CAPSULES[room]
					var/obj/item/newCapsule = new turfPath

					if (removeUpgrades) {
						//Remove all upgrades
						var/items = user.getItemRoom(TRUE)
						for(var/i in items) {
							if (istype(i, /obj/item/HOUSESYSTEM/UPGRADES)) {
								i:uninstall(user, FALSE)
							}
						}
					}

					//Delete the object
					var/turf/HOUSESYSTEM/player/T = user.loc
					houseSystem._deleteTurfFromDB(T.dbID)

					//Restore original turf
					user.changeTurf(T.originalTurf, 0)

					//Add the item to the inventory
					user.addInv(newCapsule)
					send("You push a button and the room in front of you collapses into [newCapsule.PREFIX][newCapsule.DISPLAY].", user)
					user.insideBuilding = FALSE
				}



			room
				DISPLAYCHAR = ">"
				roomColor = "red"
				CREATEMSG = "Room"
				DISPLAYNAME = "Room"

				New() {
					..()
					maxUpgrades[houseSystem.STASH] = 1
				}

			storage
				DISPLAYCHAR = "&"
				roomColor = "red"
				CREATEMSG = "Storage Room"
				DISPLAYNAME = "Storage Room"

				New() {
					..()
					maxUpgrades[houseSystem.STASH] = 4
				}

			training
				DISPLAYCHAR = "#"
				roomColor = "red"
				CREATEMSG = "Dojo"
				DISPLAYNAME = "Dojo"

				New() {
					..()
					maxUpgrades[houseSystem.TCONSOLE] = 1
					maxUpgrades[houseSystem.GRAVITYGEN] = 1
				}

				Crossed(atom/movable/Obj) {

					if (istype(Obj, /mob) && Obj:getGravity() > 15 ) {
						spawn() send("You feel the weight upon your shoulders as you enter into this room.", Obj)
						Obj:_underGravity()
					}

					return 1
				}


			medbay
				DISPLAYCHAR = "+"
				roomColor = "red"
				CREATEMSG = "Resting Room"
				DISPLAYNAME = "Resting Room"
				New() {
					..()
					maxUpgrades[houseSystem.MEDPOD] = 1
					maxUpgrades[houseSystem.OGENERATOR] = 1
				}

			dresser
				DISPLAYCHAR = "$"
				roomColor = "red"
				CREATEMSG = "Dresser"
				DISPLAYNAME = "Dresser"

				New() {
					..()
					maxUpgrades[houseSystem.WARDROBE] = 1
				}

			entrance
				DISPLAYCHAR = "%"
				roomColor = "yellow"
				CREATEMSG = "Entrance"
				density = FALSE
				DISPLAYNAME = "Entrance"

			teleport
				DISPLAYCHAR = "v"
				roomColor = "red"
				CREATEMSG = "Teleport Room"
				density = TRUE
				DISPLAYNAME = "Teleport Room"

				New() {
					..()
					maxUpgrades[houseSystem.TSHIELD] = 0
					maxUpgrades[houseSystem.TPAD] = 1
				}