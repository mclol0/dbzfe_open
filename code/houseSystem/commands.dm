#define CHECK_ROOM 0
#define CHECK_UPGRADE 1

Command/Public
	build
		name = "build"
		format = "build; !~searc(obj@inventory)";
		internal_name = "build";
		syntax = list("room capsule")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Deploy a new room in your current location from a capsule acquired from Dr.Brief."

		command(mob/Player/user, obj/item/C) {
			if (_checkMedPod(user)) {
				return
			}

			if (!C) {
				syntax(user, getSyntax())
				return
			}

			var/turf/T = _getCapsuleTarget(C, CHECK_ROOM)
			if (!T) {
				send("This is not a capsule used for building.", user)
				return
			}

			if (houseSystem.canBuild(user, T))
			{
				var/adjacentInstance = houseSystem.getAdjacentTurfInstanceID(user)
				houseSystem.build(user, T, adjacentInstance)
				user.destroyItem(C)
				return
			}
		}

	allow
		name = "allow"
		format = "allow; !~searc(obj@item_loc) | !word; ?word | ?~searc(mob@loc);";
		internal_name = "allow";
		syntax = list("object | here", "player | mob")
		helpCategory = "House System"
		helpDescription = "Provide access to a room or upgrade to a specific player. This will allow the target player to enter a given room or to access all features of the selected upgrade. Allowing players to the entrance of a home will allow them to enter through the door."

		command(mob/Player/user, target, var/nameOrMob) {
			if (!target) {
				syntax(user, getSyntax())
				return
			}

			var/trueTarget = target == "here" ? user.loc : target
			if(_allowDenyCheck(user, trueTarget, nameOrMob)) {
				var/name
				if (!istype(nameOrMob, /mob)) {
					name = getNameFromDB(nameOrMob)
				} else {
					name = nameOrMob:name
				}

				if(istype(trueTarget, /obj/item/HOUSESYSTEM/UPGRADES) || istype(trueTarget, /turf/HOUSESYSTEM/player)) {
					var/targetMsg = istype(trueTarget, /obj/item/HOUSESYSTEM/UPGRADES) ? "to [trueTarget:DISPLAY]" : "here"
					if (trueTarget:isAllowed(name)) {
						send("{Y[name]{x already has access [targetMsg].", user)
						return
					}

					trueTarget:giveAccess(name)

					send("{Y[name]{x now has access [targetMsg].", user)
					return
				}
			}
		}

	deny
		name = "deny"
		format = "deny; !~searc(obj@item_loc) | !word; ?word | ?~searc(mob@loc);";
		internal_name = "deny";
		syntax = list("object | here", "player | mob | all")
		helpCategory = "House System"
		helpDescription = "Remove access to a room or upgrade for the selected player. This allows you to specific which rooms someone cannot go to in your home, providing you with sections that can be closed inside a home even if another player can gain access to the house."

		command(mob/Player/user, target, var/nameOrMob) {
			if (!target) {
				syntax(user, getSyntax())
				return
			}

			var/trueTarget = target == "here" ? user.loc : target
			if(_allowDenyCheck(user, trueTarget, nameOrMob)) {
				var/name
				if (!istype(nameOrMob, /mob)) {
					if (lowertext(nameOrMob) == "all") {
						trueTarget:allowedAccess = list()
						trueTarget:save()
						send("All accesses have been revoked.", user)
						return
					} else {
						name = getNameFromDB(nameOrMob)
					}
				} else {
					name = nameOrMob:name
				}

				if(istype(trueTarget, /obj/item/HOUSESYSTEM/UPGRADES)) {
					var/targetMsg = "to [trueTarget:DISPLAY]"
					if (!trueTarget:isAllowed(name)) {
						send("{Y[name]{x is already not allowed to access [targetMsg].", user)
						return
					}
					trueTarget:removeAccess(name)

					send("{Y[name]{x has no more access [targetMsg].", user)
					return
				} else if (istype(trueTarget, /turf/HOUSESYSTEM/player)) {
					var/targetMsg = "here"

					trueTarget:removeAccess(name)

					send("{Y[name]{x has been denied access [targetMsg].", user)
					return
				}
			}
		}

	paint
		name = "paint"
		format = "paint; !any";
		internal_name = "paint";
		syntax = list("color")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		priority = 4;
		helpCategory = "House System"
		helpDescription = "Change the color for the location that you are currently standing on. This will make the room in the map appear with the desired color."

		command(mob/Player/user, color) {
			if (_checkMedPod(user)) {
				return
			}

			if (!houseSystem.isPlayerTurf(user.loc)) {
				if (!user.loc:isOwner(user)) {
					send("You need to be on a location that you own to change the color of the room.", user)
					return
				}

				send("You are not on a player owned location", user)
				return
			}

			var/colors = houseSystem.colorsToString(", ")
			if (!color) {
				send("Please select a color. Valid colors are: [colors]", user)
				syntax(user, getSyntax())
				return
			}

			if (!(color in houseSystem.COLORS)) {
				send("Please select a valid color. Valid colors are: [colors]", user)
				syntax(user, getSyntax())
				return
			}

			houseSystem.changeTurfColor(user, color)
		}

	unbuild
		name = "unbuild"
		format = "unbuild; ?any";
		internal_name = "unbuild";
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Completely remove a room from a house you own. Doing this will return the capsule used for said room to your inventory."

		command(mob/Player/user, var/force) {
			if (_checkMedPod(user)) {
				return
			}

			if (houseSystem.isPlayerTurf(user.loc)) {
				var/list/playersInBuilding = _playersInBuilding(user, user.loc:instanceId)
				if (playersInBuilding.len > 0) {
					if (!user.isImm) {
						send("You cannot build while there are other players inside the building.", user)
						return
					} else {
						send("There seem to be other players inside the building. Be careful to not trap users inside buildings!", user)
					}
				}

				if (user.loc:isOwner(user) || user.isImm) {
					var/forceRemoval = force && lowertext(force) == "force"
					if (!user.loc:hasUpgrades() || forceRemoval) {
						user.loc:unbuild(user, forceRemoval)
						return
					}

					send("The room you are trying to remove still has upgrades. repeat this command with '{Rforce{x' to unbuild the room without caring about upgrades.\nThis will {RNOT{x return upgrade capsules, only the room capsule.", user)
					syntax = list("force")
					syntax(user, getSyntax())
					return
				}

				send("You are not on a room that you own.", user)
				return
			}

			send("You are not on a player owned location", user)
		}

	visitors
		visitors
		name = "visitors"
		format = "~visitors;";
		internal_name = "visitors";
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "See if there is visitor inside the building that you are currently on."

		command(mob/Player/user) {
			if (user.insideBuilding > 0) {
				var/list/playersInBuilding = _playersInBuilding(user, user.loc:instanceId)
				if (playersInBuilding.len > 0) {
					//Print the list
					var/list/buffer = list()
					buffer += "There are [playersInBuilding.len] visitors in this building:\n"
					for(var/mob/p in playersInBuilding) {
						buffer += "<al2></a>- [p.raceColor(p.name)]\n"
					}
					send(format_text(implodetext(buffer, "")), user)
					return
				}

				send("There are no visitors in this building.", user)
				return
			}

			send("You are not inside a building.", user)
		}

	evict
		name = "evict"
		format = "~evict; !word";
		internal_name = "evict";
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		syntax = list("name")
		helpCategory = "House System"
		helpDescription = "Evict players from inside a buildings that are owned by you."

		command(mob/Player/user, var/name) {
			if (user.insideBuilding > 0) {
				if (!name && name != user.name) {
					send("Who are you trying to evict?", user)
					syntax(user, getSyntax())
					return
				}

				var/list/playersInBuilding = _playersInBuilding(user, user.loc:instanceId, name)
				if (playersInBuilding.len > 0) {
					for(var/mob/p in playersInBuilding) {
						p.insideBuilding = 0
						send("You evicted [p.raceColor(p.name)] from the building!", user)
						send("[user.raceColor(user.name)] has evicted you from the building!", p)
					}

					return
				}

				send("There is no one with that name inside the building", user)
				return
			}

			send("You are not inside a building.", user)
		}

	install
		name = "install"
		format = "install; ?!searc(obj@inventory)|?~searc(obj@inventory)";
		internal_name = "install";
		syntax = list("upgrade")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Install an upgrade capsule previously acquired from Dr. Brief. This needs to be performed while inside a building and if the upgrade limit for the room has not been met."

		command(mob/Player/user, obj/item/upgrade) {
			if (_checkMedPod(user)) {
				return
			}

			if (!upgrade) {
				syntax(user, getSyntax())
				return
			}

			var/obj/item/I = _getCapsuleTarget(upgrade, CHECK_UPGRADE)
			if (!I) {
				send("This is not an upgrade module.", user)
				return
			}

			// Check if the player owns the room and that the upgrade can be installed
			if (houseSystem.isPlayerTurf(user.loc)) {
				if (user.loc:isOwner(user) || user.isImm) {
					if (_canInstallUpgrade(user, upgrade)) {
						// Call the installUpgrade method
						upgrade:install(user)

						send("You install [upgrade.PREFIX][upgrade.DISPLAY] in the room.", user)
						user.destroyItem(upgrade)
						return
					}

					send("You have reached the maximum number of [upgrade.DISPLAY] in this room.", user)
					return
				}

				send("You can only install upgrades if you are an owner of the room.", user)
				return
			}

			send("You are not on a player owned location.", user)
		}

	uninstall
		name = "uninstall"
		format = "uninstall; !searc(obj@item_loc)|!~searc(obj@item_loc)";
		internal_name = "uninstall";
		syntax = list("upgrade")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Remove an upgrade that is currently installed in a room you own. This will return the capsule used for the upgrade to the inventory."

		command(mob/Player/user, obj/item/upgrade) {
			if (_checkMedPod(user)) {
				return
			}

			if (user.loc:isOwner(user) || user.isImm) {
				if (!upgrade || !istype(upgrade, /obj/item/HOUSESYSTEM/UPGRADES)) {
					send("This is not a valid object to try to uninstall.", user)
					syntax(user, getSyntax())
					return
				}

				upgrade:uninstall(user)
			} else {
				send("Only the room owner is allowed to uninstall upgrades.", user)
			}
		}

	inspect
		name = "inspect"
		format = "inspect;";
		internal_name = "inspect";
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Look at the room details of the location that you are currently standing on."

		command(mob/Player/user) {
			if (_checkMedPod(user)) {
				return
			}

			if (!houseSystem.isPlayerTurf(user.loc)) {
				send("You are not on a player owned location.", user)
				return
			}

			var/turf/currentTurf = user.loc
			if (currentTurf:hasAccess(user) || user.isImm) {
				var/list/buffer = currentTurf:createInfoBuffer()

				send(implodetext(buffer, ""), user, TRUE)
				return
			}

			send("You cannot inspect this location", user)
		}

	config
		name = "config"
		format = "config; !~searc(obj@item_loc); ?word; ?any";
		internal_name = "config";
		syntax = list("upgrade", "setting", "value")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Interact with an installed ugprade and change its settings. Upgrades can have different settings."

		command(mob/Player/user, obj/item/HOUSESYSTEM/UPGRADES/upgrade, setting, value) {
			if (_checkMedPod(user)) {
				return
			}

			if (!upgrade) {
				syntax(user, getSyntax())
				return
			}

			if (upgrade && houseSystem.isUpgrade(upgrade) && setting) {
				if (!upgrade:hasAccess(user) && !user.isImm) {
					_configReply(user, "You are not authorized to change configuration settings for [upgrade.PREFIX][upgrade.DISPLAY].")
					return
				}

				if (setting in upgrade.CONFIGURABLEVALUES) {
					var/reply = upgrade.preConfig(user, setting, value)
					_configReply(user, reply)
					return
				} else {
					//Incorrect setting
					listValidSettings(user, upgrade)
					return
				}

				_configReply(user, "Sorry, I can't help with that yet.")
				return
			}

			if (!setting && !value) {
				listValidSettings(user, upgrade, FALSE)
			}

			syntax(user, getSyntax())
		}

	start
		name = "start"
		format = "~start; !~searc(obj@item_loc); ?word";
		internal_name = "start";
		syntax = list("upgrade")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Activate an installed upgrades so that their effects are activated."

		command(mob/Player/user, obj/item/upgrade, confirm) {
			if (!upgrade)
			{
				send("Start what?", user)
				syntax(user, getSyntax())
				return
			}

			if (upgrade && istype(upgrade, /obj/item/HOUSESYSTEM/UPGRADES/INTERACTABLE)) {
				upgrade:preStart(user, confirm)
				return
			}

			send("You cannot interact with [upgrade.PREFIX][upgrade.DISPLAY].", user)
		}

	stop
		name = "stop"
		format = "~stop; !~searc(obj@item_loc);";
		internal_name = "stop";
		syntax = list("upgrade")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Deactivate an installed upgrade."

		command(mob/Player/user, obj/item/upgrade) {
			if (!upgrade)
			{
				send("Start what?", user)
				syntax(user, getSyntax())
				return
			}

			if (upgrade && istype(upgrade, /obj/item/HOUSESYSTEM/UPGRADES/INTERACTABLE)) {
				upgrade:preStop(user)
				return
			}

			send("You cannot interact with [upgrade.PREFIX][upgrade.DISPLAY].", user)
		}

	eqswitch
		name = "eqswitch"
		format = "~eqswitch; !~searc(obj@item_loc);";
		internal_name = "eqswitch";
		syntax = list("wardrobe name")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Switch your current equipment with the one in an installed wardrobe in the room."

		command(mob/Player/user, var/obj/item/upgrade) {
			if (!upgrade) {
				send("What wardrobe are you trying to take equipment from?", user)
				syntax(user, getSyntax())
				return
			}

			if (upgrade && istype(upgrade, houseSystem.UPGRADES[houseSystem.WARDROBE])) {
				upgrade:switchEq(user)
				return
			}

			send("This is not a wardrobe", user)
		}

	eqstore
		name = "eqstore"
		format = "~eqstore; !~searc(obj@item_loc);";
		internal_name = "eqstore";
		syntax = list("wardrobe name")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = FALSE;
		helpCategory = "House System"
		helpDescription = "Place pieces of your currently equipped item into an installed wardrobe in the room. Slots already occupied by a piece of equipment in the upgrade will not be replaced by this."

		command(mob/Player/user, var/obj/item/upgrade) {
			if (!upgrade) {
				send("What wardrobe are you trying to put your equipment on?", user)
				syntax(user, getSyntax())
				return
			}

			if (upgrade && istype(upgrade, houseSystem.UPGRADES[houseSystem.WARDROBE])) {
				upgrade:storeEq(user)
				return
			}

			send("This is not a wardrobe", user)
		}

	proc
		_playersInBuilding(mob/user, var/instanceID, var/userName) {
			var/list/results = list()
			for(var/mob/p in game.players) {
				if (p.insideBuilding == instanceID && p != user && !p.isImm) {
					if (userName && __textMatch(p.name, userName, FALSE, FALSE) || !userName) { 
						results += p
					}
				}
			} 

			return results
		}

		_allowDenyCheck(mob/user, var/target, var/nameOrMob) {
			if (!istype(target, /obj/item/HOUSESYSTEM) && !istype(target, /turf/HOUSESYSTEM)) {
				send("You can use this command only on player owned rooms/objects", user)
				return FALSE
			}

			if (!target:isOwner(user)) {
				send("You can only provide access if you are the owner.", user)
				return FALSE
			}

			if (user && target && !nameOrMob) {
				//Display current owner
				var/buffer = list()
				buffer += "[target] - Owner: {Y[target:owner]{x\n"
				buffer += _sharedPermissions(target)
				send(implodetext(buffer, ""), user)
				return FALSE
			}

			return TRUE
		}

		_sharedPermissions(target) {
			var/list/buffer = list()

			buffer += "Allowed Access To:\n"
			if (target:allowedAccess.len > 0) {
				for(var/N in target:allowedAccess) {
					buffer += format_text("<al2></a>{G[N]{x\n")
				}
			} else {
				buffer += format_text("<al2></a>None\n")
			}

			if (istype(target, /turf/HOUSESYSTEM)) {
				buffer += "\n"
				buffer += "Denied Access To:\n"
				if (target:deniedAccess.len > 0) {
					for(var/N in target:deniedAccess) {
						buffer += format_text("<al2></a>{R[N]{x\n")
					}
				} else {
					buffer += format_text("<al2></a>None\n")
				}
			}

			return buffer
		}
		listValidSettings(mob/user, obj/item/HOUSESYSTEM/UPGRADES/upgrade, invalid=TRUE) {
			if (upgrade.CONFIGURABLEVALUES.len > 0) {
				var/settings = __listToText(upgrade.CONFIGURABLEVALUES, ", ")
				var/validSettings = upgrade.CONFIGURABLEVALUES.len == 1 ? "The only valid setting is: [settings]." : "Valid settings are: [settings]"
				var/invalidMsg = invalid ? "The selected setting is not valid" : "Missing setting"
				_configReply(user, "[invalidMsg] for [upgrade.DISPLAY]. [validSettings]")
				return
			}

			_configReply(user, "[upgrade.DISPLAY] does not see to have any configurable setting.")
		}

		_configReply(mob/user, msg) {
			send("{CAn automated house assistant says, '{W[msg]{C'{x", user.getAllRoom())
		}

		_checkMedPod(mob/user) {
			if (user.insideMedPod) {
				var/obj/item/I = new houseSystem.UPGRADES[houseSystem.MEDPOD]
				send("You cannot do this while resting inside [I.PREFIX][I.DISPLAY]", user)
				del I
				return TRUE
			}

			return FALSE
		}

		_checkUpgradeInList(list/items, upgradePath) {
			for(var/obj/I in items) {
				if (istype(I, upgradePath)) {
					return I
				}
			}

			return NULL
		}

		_checkRoom(room) {
			for(var/T in houseSystem.TURFS) {
				if (lowertext(room) == lowertext(T)) {
					return TRUE
				}
			}

			return FALSE
		}

		_getCapsuleTarget(obj/item/capsule, check) {
			for(var/I in houseSystem.CAPSULES) {
				if (capsule.type == houseSystem.CAPSULES[I])
					var/name = houseSystem._getNameFromPath(houseSystem.CAPSULES, capsule.type)
					if (check == CHECK_ROOM)
						return houseSystem.TURFS[name]
					if (check == CHECK_UPGRADE)
						return houseSystem.UPGRADES[name]
			}

			return NULL
		}

		_getCapsule(mob/user, name) {
			var/capsulePath = houseSystem.CAPSULES[name]
			var/obj/item/C = locate(capsulePath) in user.contents

			return C
		}

		_canInstallUpgrade(mob/user, obj/item/upgrade) {
			var/upgradeName = houseSystem._getNameFromPath(houseSystem.CAPSULES, upgrade.type)
			var/turf/HOUSESYSTEM/player/currentRoom = user.loc

			var/currentUpgrades = currentRoom.currentUpgrades[upgradeName]
			var/maxUpgrades = currentRoom.maxUpgrades[upgradeName]

			return currentUpgrades < maxUpgrades
		}