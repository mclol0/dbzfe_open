mob/proc/canIT(mob/target){
	if(isImm){ return TRUE; }

	if(target.getArea() == get_area("king kai's planet") && src:race == KAIO){
		return TRUE;
	}

	if(src.getArea() == get_area("Hyperbolic Time Chamber")) {
		return FALSE;
	}

	if(istype(target,/mob/NPA) && target:difficultyLevel == EVENT_MOB || target.loc && target.loc.loc && target.loc.loc:locked || fCombat._hostiles() || checkPod() || !target.canSense(src)){
		return FALSE;
	}

	if (houseSystem.isPlayerTurf(target.loc)) {
		if (target.loc:itLocked && target.insideBuilding) {
			return FALSE
		}
	}

	return TRUE;
}

Command/Technique
	teleport
		name = "teleport"
		internal_name = "teleport"
		format = "~teleport; ?!searc(mob@mobiles) | ?~searc(mob@mobiles) | ?any";
		syntax = list("mobile | teleport pad")
		priority = 2
		_maxDistance = 0;
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Instantly transfer to your target's location.\n\n{YNote:{x {CThis skill cannot be used on targets that are inside specific areas, holding Dragon Balls or inside building rooms that have a teleport shield installed."

		command(mob/user, dest) {
			var/spawnDelay = user.isImm ? 0 : 10

			if (!user.isImm && user.insideMedPod) {
				var/obj/item/I = new houseSystem.UPGRADES[houseSystem.MEDPOD]
				send("You cannot teleport from inside [I.PREFIX][I.DISPLAY]", user)
				return FALSE
			}

			if(!user.isImm && user.hasDB()){
				send("You can't perform this while holding the dragonballs!",user);
				return
			}

			if (istype(dest, /mob)) {
				var/mob/target = dest
				if (target && !user.isImm && !user.canIT(target) || target && !user.isImm && target.hasDB()) {
					send("You cannot seem to sense your target.", user)
					return
				}

				if(user && target || user.isImm){
					if(!user.isImm && ..(user,target,TRUE,name,TRUE)){
						return;
					}

					if(user.loc == target.loc){
						send("You are already at [target.raceColor(target.name)]'s location!",user)
						return
					}

					user.iting=TRUE;
					sendTeleportMessage(user.isImm, user)

					spawn(spawnDelay){
						if(user && target){
							user.teleportMob(target, user.isImm)
						}else{
							user.iting=FALSE;
						}
					}

					return
				}
			} else {
				if (dest) {
					if(user.fCombat._hostiles() || user.checkPod()){
						send("You can't teleport right now!",user,TRUE);
						return
					}

					for(var/obj/item/HOUSESYSTEM/UPGRADES/TPAD/T in game.teleporters) {
						if (TextMatch(dest, T.teleportName, 1, 1) && T.hasAccess(user)) {
							if(!user.isImm && ..(user,T,TRUE,name,TRUE)){
								return;
							}

							if(user.loc == T.loc){
								send("You are already at [T.teleportName] location!",user)
								return
							}

							user.iting=TRUE;
							sendTeleportMessage(user.isImm, user)
							spawn(spawnDelay) {
								if (user && T && !T.loc:itLocked || user.isImm)
									user.teleportObj(T, user.isImm)
								else {
									user.iting = FALSE
								}
							}

							return
						}
					}
				}
			}

			syntax(user,getSyntax())
		}

		proc
			sendTeleportMessage(isImm, mob/user) {

				if (!isImm && user.race != KAIO) {
					send("{B* You place your index and middle fingers to your forehead!{x", user)
					if(user.invisible == FALSE) {
						send("{W*{x [user.raceColor(user.name)] places [user.determineSex(1)] index and middle fingers to [user.determineSex(1)] forehead!",_ohearers(0,user))
					}					
				} else if (!isImm && user.race == KAIO) {
					send("{B* You close your eyes and focus on your intended location!{x", user)
					if(user.invisible == FALSE) {
						send("{W*{x [user.raceColor(user.name)] closes [user.determineSex(1)] eyes and starts to focus!",_ohearers(0,user))
					}
				}
			}
