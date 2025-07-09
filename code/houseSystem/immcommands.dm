Command/Wiz
	setowner
		name = "setowner"
		format = "setowner; !~searc(obj@item_loc) | !word; ?word | ?~searc(mob@loc);";
		internal_name = "setowner";
		immCommand = 1
		immReq = 1
		syntax = list("object | turf", "player")

		command(mob/Player/user, target, var/nameOrMob) {
			if (!target) {
				send("You need to specify an upgrade or {cturf{x", user)
				syntax(user, syntax)
				return
			}

			var/trueTarget = target == "turf" ? user.loc : target
			if (user && target && !nameOrMob) {
				//Display current owner
				send("[trueTarget] - Owner: [trueTarget:owner]", user)
				return
			}

			var/ownerName
			if (!istype(nameOrMob, /mob)) {
				if (nameOrMob == "NULL") {
					ownerName = NULL
				} else {
					var/rowCount = _rowCount("FROM `characters` WHERE `name`='[sanit(nameOrMob)]' COLLATE NOCASE;")
					if (rowCount == 0) {
						send("Player name not found", user)
						return
					}

					var/database/query/q = _query("SELECT * FROM `characters` WHERE `name`='[sanit(nameOrMob)]' COLLATE NOCASE;")
					q.NextRow()
					var/list/rowData = q.GetRowData()

					ownerName = rowData["name"]
				}
			} else {
				ownerName = nameOrMob:name
			}

			if(istype(trueTarget, /obj/item/HOUSESYSTEM/UPGRADES) || istype(trueTarget, /turf/HOUSESYSTEM/player)) {
				//set object owner
				trueTarget:owner = ownerName
				trueTarget:save()
				send("The new owner is now {Y[ownerName ? ownerName : "NULL"]{x", user)
				return
			}

			send("You cannot set the owner to this object/turf.", user)
		}

	getteleporters
		name = "getteleporters"
		format = "getteleporters";
		internal_name = "getteleporters";
		immCommand = 1
		immReq = 1

		command(mob/Player/user) {
			for(var/obj/item/T in game.teleporters)
			{
				var/n = T:teleportName ? T:teleportName : "No Custom Name"
				send("[n] ([T.x].[T.y].[T.z]) - [T:owner]", user)
			}
		}

	toggleConstruction
		name = "toggleconstruction"
		format = "toggleconstruction";
		internal_name = "toggleconstruction";
		immCommand = 1
		immReq = 1

		command(mob/Player/user) {
			if (houseSystem.constructionEnabled) {
				houseSystem.constructionEnabled = FALSE
				send("Construction is now disabled.", user)
			} else {
				houseSystem.constructionEnabled = TRUE
				send("Construction is now enabled.", user)
			}
		}
