proc
	getAttackDelay(Command/Technique/t, fCombat/c, mob/target){
		if("[target.ID]" in c.comboList){
			var
				comboL[] = c.comboList["[target.ID]"]
				xTendCombo = FALSE;

			if(!target.unconscious && comboL[c.comboCount["[target.ID]"]] == t.comboName){
				c.mobRef:_doEnergy(1);
				target._doEnergy(1);
				c.comboCount["[target.ID]"]++;
				if(c.comboCount["[target.ID]"] > comboL.len){
					if(decimal_prob(fightExtendCombo)){ xTendCombo = TRUE; }

					if(c.mobRef:shyouken && decimal_prob(fightShyoukenCombo) || xTendCombo){
						send("{B[c.mobRef:fCombat.comboCount["[target.ID]"] - 1]{x {Rhit combo!{x",c.mobRef)
						c.comboList.Remove("[target.ID]")
						c.comboCount.Remove("[target.ID]")
						/* SEND EM FLYING*/
						if(xTendCombo && (game.dir2text_map(game.dirRev(c.mobRef:dir)) in target.Exits(TRUE))){
							var
								sendDir = game.dirRev(c.mobRef:dir);
								noCol = TRUE;
								oldLoc = NULL;

							send("{B*{x Your [t.name] sends [target.raceColor(target.name)] flying [game.dir2text(sendDir)]!",c.mobRef)
							send("{W*{x [c.mobRef:raceColor(c.mobRef:name)] [t.name] sends [target.raceColor(target.name)] flying [game.dir2text(sendDir)]!",a_oview_extra(0,c.mobRef,target))
							send("{R*{x [c.mobRef:raceColor(c.mobRef:name)] [t.name] sends you flying [game.dir2text(sendDir)]!",target)

							for(var/i=rand(2,5),i>0,i--){
								oldLoc=target.loc;
								if((game.dir2text(sendDir) in target.Exits())) { target.Move(get_step(target,sendDir), sendDir, 0, 0, TRUE) }
								if(oldLoc==target.loc){
									send(buildMap(target,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),target);
									noCol = FALSE;
									c.mobRef:fCombat.doDamage(target,5,10,"collision damage",c)
									break;
								} else { continue }
							}

							if(noCol){ send(buildMap(target,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),target); }
						}
						/* SEND EM FLYING*/

						var/canZanz = FALSE;
						if(c.mobRef:techniques.Find(/Command/Technique/zanzoken) && c.mobRef:loc != target.loc){ canZanz = TRUE; }

						c.mobRef:fCombat.buildCombo(target,canZanz);
						target.stunTime = (world.time + 40);
					}else{
						target.stunTime = world.time
					}
				}
				return world.time;
			}else{
				if(t.breakCombo){
					target.stunTime = world.time + 31
					c.comboList.Remove("[target.ID]")
					c.comboCount.Remove("[target.ID]")
				}
				return (world.time + t.delay);
			}
		}
		return (world.time + t.delay);
	}

Command/Public
	command(mob/user){
		if(!istype(user,/mob/Player/Immortal) && game.checkCooldown(user.name,internal_name)){
			send("You can't use [name] for another [num2text((game.coolDowns["([user.name])[internal_name]"] - world.time) / 10,3)] second(s)!",user)
			return TRUE;
		}
	}

Command/Technique/Form
	var
		formName = NULL

	helpCategory = "Forms"

	getDescription(legendaryFormName=NULL) {
		var/list/buffer = list("[helpDescription]\n")
		if (formName) {
			var/forms = istype(formName, /list) ? formName : list(formName)
			if (legendaryFormName) {
				forms += legendaryFormName
			}

			var/first = TRUE
			for(var/f in forms) {
				if (!f) { continue }
				var/fForm/form = gForm.get(f);
				if (form) {
					if (form.fCost && form.fCost > 0) {
						buffer += "\nThis form costs: [form.fCost] Lab Credits\n"
					}

					if (!first) {
						buffer += "\n"
					}

					buffer += "\n[form.fColor][form.name]{x Stats:\n"
					buffer += format_text("<al2></a><al19>Bonus KI</a>: [form.bonusKI]\n")
					buffer += format_text("<al2></a><al19>Bonus STR</a>: [form.bonusSTR]\n")
					buffer += format_text("<al2></a><al19>Bonus ARM</a>: [form.bonusARM]\n")
					buffer += format_text("<al2></a><al19>Bonus STA</a>: [form.bonusSTA]\n")
					buffer += format_text("<al2></a><al19>Gain Mod</a>: [form.gMod]%\n")
					buffer += format_text("<al2></a><al19>Flight Speed Mod</a>: [form.fsMod]\n")
					buffer += format_text("<al2></a><al19>Gravity Resistance</a>: [form.gravRes]")

					if (form.fUNI) {
						buffer += "\n\n{YThis form is permanent and cannot be reverted.{x"
					}

					first = FALSE
				}
			}
		}

		return implodetext(buffer, "")
	}

Command/Technique

	var/skillDatum = NULL
	var/delay = attackDelay;
	var/tmp/CAST_MSG = "a sudden surge of energy"; //Message displayed to nearby players from energy attacks (Kamehameha when fired etc);

	getDescription() {
		if (skillDatum) {
			var/skill = new skillDatum
			var/list/buffer = list("[helpDescription]\n")
			buffer += skill:getHelp(src)
			del skill

			return implodetext(buffer, "")
		}

		return ..()
	}

	getSyntax() {
		if (skillDatum) {
			var/skill = new skillDatum
			if (istype(skill, /fEAttk)) {
				if (skill:maxBarrageLoad > 1 && canChangeBarrage) {
					syntax = list("1-[skill:maxBarrageLoad]", "mobile")
				}

				var/rangeStr = ""
				if (_maxDistance) {
					rangeStr = " {C(Range: [_minDistance]~[_maxDistance] rooms){x"
				}

				return "[..()][rangeStr]"
			}
		}

		return ..()
	}

	command(mob/user, mob/target, isEnergy=FALSE, attkName=NULL,or=FALSE){
		//if(!user && !target && tType in list(MELEE)){ . = FALSE; }

		if(!istype(user,/mob/Player/Immortal) && game.checkCooldown(user.name,internal_name)){
			send("You can't use [name] for another [num2text((game.coolDowns["([user.name])[internal_name]"] - world.time) / 10,3)] second(s)!",user)
			return TRUE;
		}

		if(!or){
			if(user && target && target.unconscious && !canFinish){
				send("You can't attack [target.raceColor(target.name)], you must finish [target.determineSex(2)]!",user)
				. = TRUE;
			}
			if(!istype(user.loc.loc,/planet/arena) && target){
				if (istype(target, /mob)) {
					if (!target.isSafe()) {
						if(user && target && game.hasPKed(user,target) && !user.fCombat.hostileTargets.Find(target) && !target.hasDB() || user && target && target.unconscious && canFinish && user.loc.loc:finishLocked || user && target && isplayer(user) && isplayer(target) && user.getMaxPL() < 1000 && !user.hasDB() || user && target && isplayer(user) && isplayer(target) && target.getMaxPL() < 1000 && !target.hasDB() || user && target && isnpc(target) && !target:hostile || user && target && user.fCombat.checkAlly(target) || user && target && target.fCombat.hostileTargets.len && !user.fCombat.findAlly(target) && isnpc(target) || user && target && target.fCombat.lastTarget && isnpc(target.fCombat.lastTarget) && isplayer(user) && isplayer(target) && !(target in user.fCombat.hostileTargets) && !user.fCombat.findAlly(target) || user && target && user.maxpl > target.maxpl * 3 && !target.hasDB() && isplayer(user) && isplayer(target) && !(target in user.fCombat.hostileTargets)){
							send("You can't attack [target.raceColor(target.name)]!",user)
							. = TRUE;
						}
					}
				}
			}
			if(!isEnergy && user.kiAttk){
				user.cancelKi()
				. = FALSE;
			}
			/*if(isEnergy && name != attkName){
				send("You are already charging your [name]!",user)
				. = TRUE;
			}*/
		}

		if(!. && user && target){
			if (istype(target, /mob)) {
				if (!user.isSafe() && !target.isSafe() && (tType in list(MELEE,ENERGY))) {
					target:fCombat.lastTarget = user
					user.fCombat.lastTarget = target
					if(!(target in user.fCombat.hostileTargets)){user.fCombat.addHostile(target)}
				}
			}
		}
	}