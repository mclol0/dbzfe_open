obj/var/insideBuilding = FALSE;

proc
	createItem(path){
		try{
			var/obj/item/p = new path;

			return p;
		}

		catch(var/exception/e){
			world.log << "[e.file]:[e.line] createItem() tried to create an item that doesn't exist."
			return FALSE
		}
	}

	getDropChance(var/item){
		var/obj/item/i = new item;

		if(!i.CAN_DROP) { return 0.00; }

		return i.DROP_CHANCE;
	}

	getLastID(){
		var
			rowCount = _rowCount("FROM `inventory`;");

		if(!rowCount) return 1;

		var
			database/query/q = _query("SELECT `ID` FROM `inventory` ORDER BY `ID` DESC LIMIT 1;");
			list/rowData;

		q.NextRow();

		rowData = q.GetRowData();

		return text2num(rowData["ID"]);
	}

obj/item/
	proc
		weightCheck(mob/M){
			var
				totalWeight = (WEIGHT + M.totalWeight());

			if(totalWeight >= M.calcMaxWeight()){
				return FALSE;
			}

			return TRUE;
		}

		itemTags(){
			var/tags[] = list();

			if(MISC){
				tags += "{Dno mystery boxes{x";
				tags += "{Dnon obtainable by drop{x";
			}

			if (!CAN_SELL) {
				tags += "{Dcannot sell{x";
			}

			if(NO_MYSTERY) {
				tags += "{Dno mystery boxes{x";
			}

			if (!STOCK_SHOP) {
				tags += "{Dcannot be rebought{x";
			}

			if(!CAN_DROP){
				tags += "{Dcharacter bound{x";
			}

			if(EDIBLE){
				tags += "{Dedible{x";
			}

			if(SMOKEABLE){
				tags += "{Dsmokeable{x";
			}

			if(STACKABLE){
				tags += "{Dstackable{x";
			}

			if(ANNOUNCE_DROP){
				tags += "{Dannounce on drop{x";
			}

			return "{C({x[implodetext(tags,"{C/{x")]{C){x";
		}

		decayItem(oldLoc){
			set waitfor=FALSE;

			var
				decayTime = (world.time + 15 MINUTES);

			while(loc == oldLoc){
				if(world.time >= decayTime){
					send("[PREFIX][DISPLAY] decays.",oview(0,src))
					clean() // del replace
					break;
				}
				sleep(world.tick_lag)
			}
		}

	text="{ri{x"
	display="{ri{x"

	var
		dBID = 0; // Database ID used for loading and saving the item.
		CONTAINER = FALSE;
		DESC = NULL;
		EQUIPABLE = FALSE;
		PREFIX = NULL;
		DISPLAY = NULL;
		SLOT = NULL;
		SINGLE_DISPLAY;
		MULTI_DISPLAY;
		STACKABLE = TRUE;
		EDIBLE = FALSE;
		SMOKEABLE = FALSE;
		CAN_PICKUP = TRUE;
		DESTRUCTABLE = TRUE;
		DECAY = TRUE;
		EQ_MSG = NULL;
		EQ_MSG0 = "worn";
		BONUS_KI = 0;
		BONUS_STR = 0;
		BONUS_ARM = 0;
		BONUS_STA = 0;
		BONUS_MF = 0;
		BONUS_TENACITY = 0;
		WEIGHT = 0.1;
		PL_REQ = 0; //Powerlevel requirement
		DROP_CHANCE = 12.50 // Default drop chance.
		ANNOUNCE_DROP = FALSE; // Do we announce to the world this item has dropped?
		MISC = FALSE; // Are we a misc item such as dragonballs or mystery box etc?
		CAN_DROP = TRUE; // Can the item be dropped upon death?
		PRICE = 0 // Price we are sold at in shops.
		NO_MYSTERY = FALSE; // Can it be dropped from a mystery box?
		STOCK_SHOP = TRUE; // Are we listed in a shop if we are sold to a shop?
		OR_PRICE = FALSE; // Do we sell for full price as well and buy for full price?
		CAN_STASH = TRUE; // Can this item be stashed in a container?
		SHOW_IN_MAP = TRUE; //Should this item be displayed or not in build_map
		MAX_ITEMS = 0; //How many items can we put inside a container
		CAN_GIVE = TRUE; //Can this item be given to someone else through the give command
		CAN_SELL = TRUE; //Can this item be sold to NPC stores
		SHOW_ITEMDB = TRUE;

	proc
		onEquip(mob/m)
		onRemove(mob/m)
		
		_open(mob/m){
			if(CONTAINER){
				send("You open [PREFIX][DISPLAY].",m);
				send("[m.raceColor(m.name)] opens [PREFIX][DISPLAY].",_ohearers(0,m));
				return TRUE;
			}else{
				send("You can't open this!",m);
				return FALSE;
			}
		}

		_eat(mob/m){
			if(EDIBLE || isplayer(m) && m.isImm){
				send("You eat [PREFIX][DISPLAY].",m)
				send("[m.raceColor(m.name)] eats [PREFIX][DISPLAY].",_ohearers(0,m))
				return TRUE;
			}
			send("You can't eat this!",m)
			return FALSE;
		}

		_smoke(mob/m){
			if(SMOKEABLE || isplayer(m) && m.isImm){
				send("You smoke [PREFIX][DISPLAY].",m)
				send("[m.raceColor(m.name)] smokes [PREFIX][DISPLAY].",_ohearers(0,m))
				return TRUE;
			}
			send("You can't smoke this!",m)
			return FALSE;
		}

		_equip(mob/m){
			var/Sl = SLOT; // So we can adjust the slot ID for items such as rings in the code block ex if we have a ring on the left finger switch it to the right.

			if(!EQUIPABLE){
				send("You can't equip this!",m)
				return FALSE;
			}

			if(SLOT == FINGERS){
				if(!m.equipment[LEFT_FINGER]){
					Sl = LEFT_FINGER;
				}else if(!m.equipment[RIGHT_FINGER]){
					Sl = RIGHT_FINGER;
				}else{
					Sl=pick(LEFT_FINGER,RIGHT_FINGER);
				}
			}

			if(m.equipment[Sl]){
				m.removeItem(m.equipment[Sl],m);
			}

			send("You equip [PREFIX][DISPLAY] [EQ_MSG] your [_getName(Sl)]!",m)
			send("[m.raceColor(m.name)] equip's [PREFIX][DISPLAY] [EQ_MSG] [m.determineSex(1)] [_getName(Sl)]!",_ohearers(0,m))
			onEquip(m)
			m.remInv(src)
			loc = NULL;
			m.equipment[Sl] = src
			if(m.curreng<m.getMaxEN() && !m.regenStam){ m:regenStam() }
			if(m.currpl<m.getMaxPL() && !m.regenPL){ m:regenPL() }
			if(m.currpl>m.getMaxPL()){m.currpl=m.getMaxPL()}

			return TRUE;
		}

		_unequip(mob/m, var/mute=FALSE){
			var/_SLOT = m.equipment.Find(src);

			if(m.equipment[_SLOT]){
				if (!mute) {
					send("You unequip [PREFIX][DISPLAY] from your [_getName(_SLOT)]!",m)
					send("[m.raceColor(m.name)] unequip's [PREFIX][DISPLAY] from [m.determineSex(1)] [_getName(_SLOT)]!",_ohearers(0,m))
				}
				onRemove(m)
				m.equipment[_SLOT] = NULL;
				m.addInv(src);
				if(m.curreng>m.getMaxEN()){ m.curreng=m.getMaxEN() }
				if(m.currpl>m.getMaxPL()){m.currpl=m.getMaxPL()}
			}else{
				return FALSE;
			}
			return TRUE;
		}

		_getStatus(){
			if(loc:tType == WATER){
				return "floating in the water";
			}else{
				return "laying on the ground";
			}
		}

		stash(mob/m, obj/item/I) {
			send("You cannot put [I.PREFIX][I.DISPLAY] in [PREFIX][DISPLAY]", m);
		}

		addItem(obj/item/I) {
			contents += I
		}

		displayContents(mob/m) {
			send("You look in [DISPLAY].",m)
			send("[m.raceColor(m.name)] looks in [DISPLAY].",_ohearers(0,m))
			send("[DISPLAY]:",m)
			var/empty = TRUE
			if(contents:len>0){
				for(var/obj/item/i in contents){
					send(" [i.PREFIX][i.DISPLAY]",m)
				}
				empty = FALSE
			}

			if (istype(src, /obj/item/corpse) && src:zenniValue>0) {
				send(" {G[commafy(src:zenniValue)]{x {YZenni{x",m)
				empty = FALSE
			}

			if(empty) send(" Empty.",m)
			return
		}

		loot(mob/m, item) {
			var/looted = FALSE
			var/isCorpse = istype(src, /obj/item/corpse)

			if(isCorpse){
				if(!(m.name in list("[src:killer]","[src:owner]"))){
					send("You can't loot this corpse you have no claim to it!",m,TRUE);
					return;
				}
			}

			if(item){
				var/obj/item/I = NULL;

				if (TextMatch("zenni", item, 1, 1)){
					looted = lootZenni(m)
				} else {
					for(var/obj/item/i in src.contents){
						if(TextMatch(rStrip_Escapes(i.DISPLAY),item,1, 1)){
							I = i
							break
						}
					}

					if(I){
						send("You obtain [I:PREFIX][I:DISPLAY] from [src.DISPLAY].",m)
						send("[m.raceColor(m.name)] obtains [I:PREFIX][I:DISPLAY] from [src.DISPLAY].",_ohearers(0,m))
						src.contents -= I
						m.addInv(I)
						looted = TRUE
					}else{
						send("Loot what?", m)
						return
					}
				}
			}else{
				looted = lootZenni(m)
				if(src.contents.len>0){
					for(var/obj/item/i in src.contents){
						send("You obtain [i.PREFIX][i.DISPLAY] from [src.DISPLAY].",m)
						send("[m.raceColor(m.name)] obtains [i.PREFIX][i.DISPLAY] from [src.DISPLAY].",_ohearers(0,m))
						src.contents -= i
						m.addInv(i)
						if (isCorpse) {
							if(src:isPlayerCORPSE){ break }
						}
					}
					looted = TRUE
				}

				if (!looted) {
					send("[src.DISPLAY] is empty.",m)
				}

				looted = TRUE
			}

			if (isCorpse && looted) {
				if(src:isPlayerCORPSE){del(src);}
			}
		}

		lootZenni(mob/m) {
			if(istype(src, /obj/item/corpse)) {
				if (src:zenniValue > 0) {
					send("You obtain {G[commafy(src:zenniValue)]{x {YZenni{x from [src.DISPLAY].",m)
					send("[m.raceColor(m.name)] obtains {G[commafy(src:zenniValue)]{x {YZenni{x from [src.DISPLAY].",_ohearers(0,m))
					m.zenni += src:zenniValue;
					src:zenniValue = 0;
					return TRUE
				}
			}

			return FALSE
		}

		_getDesc() {
			return DESC
		}

		showDetails(mob/m, obj/item/compareItem, STATS_ONLY=FALSE) {
			var/list/buffer = list()

			if(!STATS_ONLY){
				buffer += !compareItem ? "[DISPLAY]\n" : "[DISPLAY] - ${G[PRICE ? commafy(PRICE) : 0]{x {YZenni{x\n"
				buffer += !_getDesc() ? "" : "{m--------{x\n"
				buffer += !_getDesc() ? "" : "[_getDesc()]\n"
				buffer += !_getDesc() ? "" : "{m--------{x\n"

				buffer += "\n"

				if (EQUIPABLE)
					buffer += "Worn on: {D[uppertext(_getName(SLOT))]{x\n"

				buffer += compareItem ? "Stats (comparing with [compareItem.DISPLAY]):\n" : "Stats:\n"
				var/weightString = compareItem ? "[WEIGHT] ([ncheck(WEIGHT - compareItem.WEIGHT)])" : "[WEIGHT]"
				buffer += _statField("Weight", weightString)
				if (EQUIPABLE) {
					var/staString = compareItem ? "[BONUS_STA] ([ncheck(BONUS_STA - compareItem.BONUS_STA)])" : "[BONUS_STA]"
					buffer += _statField("Stamina", staString)

					var/kiString = compareItem ? "[BONUS_KI] ([ncheck(BONUS_KI - compareItem.BONUS_KI)])" : "[BONUS_KI]"
					buffer += _statField("Ki", kiString)

					var/strString = compareItem ? "[BONUS_STR] ([ncheck(BONUS_STR - compareItem.BONUS_STR)])" : "[BONUS_STR]"
					buffer += _statField("Strength", strString)

					var/armString = compareItem ? "[BONUS_ARM] ([ncheck(BONUS_ARM - compareItem.BONUS_ARM)])" : "[BONUS_ARM]"
					buffer += _statField("Armor", armString)

					var/mfString = compareItem ? "[BONUS_MF] ([ncheck(BONUS_MF - compareItem.BONUS_MF)])" : "[BONUS_MF]"
					buffer += _statField("Magic Find", mfString)
				}
			}else{
				if(BONUS_STA>0){
					var/staString = "{G+[commafy(BONUS_STA)]{x"
					buffer += _statField("{YSTA{x", staString, TRUE)
				}

				if(BONUS_KI>0){
					var/kiString = "{G+[commafy(BONUS_KI)]{x"
					buffer += _statField("{YKI{x", kiString, TRUE)
				}

				if(BONUS_STR>0){
					var/strString = "{G+[commafy(BONUS_STR)]{x"
					buffer += _statField("{YSTR{x", strString, TRUE)
				}

				if(BONUS_ARM>0){
					var/armString = "{G+[commafy(BONUS_ARM)]{x"
					buffer += _statField("{YARM{x", armString, TRUE)
				}

				if(BONUS_MF>0){
					var/mfString = "{G+[commafy(BONUS_MF)]{x"
					buffer += _statField("{YMF{x", mfString, TRUE)
				}

				return implodetext(buffer,"");
			}

			send(implodetext(buffer, ""), m)
		}

		_statField(var/stat, var/msg, NO_BREAK=FALSE) {
			return format_text("<al2></a><al10>[stat]</a>: {D[msg]{x[NO_BREAK ? "" : "\n"]")
		}

	SCOUTER
		var/SCOUTER_LEVEL = 2

		onEquip(mob/m) {
			m.sensePL = TRUE
		}

		onRemove(mob/m) {
			m.sensePL = FALSE
		}

	SCOUTER/GREEN_SCOUTER
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{GGreen Scouter{x"
		SINGLE_DISPLAY = "{GGreen Scouter{x"
		MULTI_DISPLAY = "{GGreen Scouter{x"
		MULTI = TRUE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 0
		BONUS_STR = 5
		BONUS_ARM = 5
		BONUS_STA = 5
		BONUS_MF = 100
		WEIGHT = 0.1
		DROP_CHANCE = 25.00
		PRICE = 500
		SCOUTER_LEVEL = 1

	SCOUTER/RED_SCOUTER
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{RRed Scouter{x"
		SINGLE_DISPLAY = "{RRed Scouter{x"
		MULTI_DISPLAY = "{RRed Scouter{x"
		MULTI = TRUE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 15
		BONUS_STR = 15
		BONUS_ARM = 15
		BONUS_STA = 15
		BONUS_MF = 200
		WEIGHT = 0.1
		DROP_CHANCE = 7.00
		PRICE = 2500

	WHITE_FUSION_BOOTS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{WWhite{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {WBoo{x{Yts{x"
		MULTI = FALSE;
		SLOT = FEET;
		STACKABLE = TRUE;
		BONUS_KI = 115
		BONUS_STR = 17
		BONUS_ARM = 13
		BONUS_STA = 171
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 2.00
		PRICE = 5000

	BLACK_FUSION_BOOTS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DBlack{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {WBoo{x{Yts{x"
		MULTI = FALSE;
		SLOT = FEET;
		STACKABLE = TRUE;
		BONUS_STA = 110
		BONUS_KI = 127
		BONUS_STR = 17
		WEIGHT = 0.1
		BONUS_ARM = 21
		BONUS_MF = 0
		DROP_CHANCE = 2
		PRICE = 5000

	DEMON_PRINCE_GLOVES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{WWhite{x {bDemon Prince{x {DGloves{x"
		SINGLE_DISPLAY = "{WWhite{x {bDemon Prince{x {DGloves{x"
		MULTI_DISPLAY = "{WWhite{x {bDemon Prince{x {DGloves{x"
		MULTI = TRUE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 125
		BONUS_STR = 15
		BONUS_ARM = 12
		BONUS_STA = 143
		BONUS_MF = 100
		WEIGHT = 0.1
		DROP_CHANCE = 2.00
		ANNOUNCE_DROP = TRUE
		PRICE = 5000

	WHITE_BOOTS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{WWhite{x {DBoots{x"
		SINGLE_DISPLAY = "{WWhite{x {DBoots{x"
		MULTI_DISPLAY = "{WWhite{x {DBoots{x"
		MULTI = TRUE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 10
		BONUS_STR = 2
		BONUS_ARM = 1
		BONUS_STA = 15
		BONUS_MF = 100
		WEIGHT = 0.1
		DROP_CHANCE = 12.50
		PRICE = 500

	WHITE_GLOVES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{WWhite{x {wGloves{x"
		SINGLE_DISPLAY = "{WWhite{x {wGloves{x"
		MULTI_DISPLAY = "{WWhite{x {wGloves{x"
		MULTI = TRUE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 20
		BONUS_STR = 3
		BONUS_ARM = 0
		BONUS_STA = 15
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 12.50
		PRICE = 500

	KING_VEGETA_MEDALLION
		EQUIPABLE = TRUE;
		DISPLAY = "{cKing Vegeta's{x {YMedallion{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 30
		BONUS_STR = 7
		BONUS_ARM = 5
		BONUS_STA = 47
		BONUS_MF = 400
		WEIGHT = 0.1
		DROP_CHANCE = 12.50
		PRICE = 500

	KING_VEGETA_CAPE
		EQUIPABLE = TRUE;
		DISPLAY = "{cKing Vegeta's{x {DCape{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 100
		BONUS_STR = 40
		BONUS_ARM = 50
		BONUS_STA = 0
		BONUS_MF = 500
		WEIGHT = 0.5
		MISC = TRUE;
		STOCK_SHOP = FALSE
		DROP_CHANCE = 0.00
		PRICE = 100000

	ANDROID_17_SCARF
		EQUIPABLE = TRUE;
		DISPLAY = "{DAndroid 17's{x {RScarf{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 60
		BONUS_STR = 13
		BONUS_ARM = 10
		BONUS_STA = 70
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 7.50
		PRICE = 2500

	ANDROID_18_PEARL_NECKLACE
		EQUIPABLE = TRUE;
		DISPLAY = "{DAndroid 18's{x {WPearl{x {YNecklace{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 120
		BONUS_STR = 45
		BONUS_ARM = 32
		BONUS_STA = 85
		BONUS_MF = 600
		WEIGHT = 0.1
		DROP_CHANCE = 6.50
		PRICE = 2500

	ANDROID_19_HAT
		EQUIPABLE = TRUE;
		DISPLAY = "{DAndroid 19's{x {RHat{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 60
		BONUS_STR = 23
		BONUS_ARM = 20
		BONUS_STA = 60
		BONUS_MF = 300
		WEIGHT = 0.1
		DROP_CHANCE = 7.50
		PRICE = 2500

	ZARBON_CIRCLET
		EQUIPABLE = TRUE;
		DISPLAY = "{bZarbon's{x {YCirclet{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 99
		BONUS_STR = 15
		BONUS_ARM = 15
		BONUS_STA = 30
		BONUS_MF = 150
		WEIGHT = 0.1
		PRICE = 1000

	ZARBON_EARRING
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{bZarbon's{x {YEarrings{x"
		SINGLE_DISPLAY = "{bZarbon's{x {YEarring{x"
		MULTI_DISPLAY = "{bZarbon's{x {YEarring{x"
		MULTI = TRUE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 110
		BONUS_STR = 35
		BONUS_ARM = 20
		BONUS_STA = 45
		BONUS_MF = 250
		WEIGHT = 0.1
		PRICE = 1000

	BROLYS_EARRINGS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{cBroly's{x {YEarrings{x"
		SINGLE_DISPLAY = "{cBroly's{x {YEarring{x"
		MULTI_DISPLAY = "{cBroly's{x {YEarring{x"
		MULTI = TRUE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 500;
		BONUS_STR = 250;
		BONUS_ARM = 250;
		BONUS_STA = 250;
		BONUS_MF = 550;
		WEIGHT = 0.3;
		MISC = TRUE;
		STOCK_SHOP = FALSE
		NO_MYSTERY = TRUE;
		ANNOUNCE_DROP = TRUE
		PRICE = 100000
		DROP_CHANCE = 10.00

	LIGHT_TURBAN
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{wLight{x {Wturban{x"
		SINGLE_DISPLAY = "{wLight{x {Wturban{x"
		MULTI_DISPLAY = "{wLight{x {Wturban{x"
		MULTI = TRUE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 50
		BONUS_STR = 10
		BONUS_ARM = 15
		BONUS_STA = -1
		BONUS_MF = 0
		WEIGHT = 3
		PRICE = 500

	KESSINS_KNEE_GUARDS
		EQUIPABLE = TRUE;
		DISPLAY = "{MKessin's{x {WKnee{x {DGuards{x"
		MULTI = FALSE;
		SLOT = KNEES;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI =  160
		BONUS_STR = 50
		BONUS_ARM = 36
		BONUS_STA = 80
		BONUS_MF = 510
		WEIGHT = 0.5
		PRICE = 55000

	HEAVY_TURBAN
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{wHeavy{x {Wturban{x"
		SINGLE_DISPLAY = "{wHeavy{x {Wturban{x"
		MULTI_DISPLAY = "{wHeavy{x {Wturban{x"
		MULTI = TRUE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 80
		BONUS_STR = 20
		BONUS_ARM = 30
		BONUS_STA = -15
		BONUS_MF = 0
		WEIGHT = 12
		PRICE = 500

	KING_COLD_CAPE
		EQUIPABLE = TRUE;
		DISPLAY = "{DKing{x {mCold's{x {DC{x{Rap{x{De{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 130
		BONUS_STR = 45
		BONUS_ARM = 55
		BONUS_STA = 40
		BONUS_MF = 120
		WEIGHT = 5
		PRICE = 2500

	MASTER_ROSHI_INSIGNIA
		EQUIPABLE = TRUE;
		DISPLAY = "{yMaster Roshi's{x {wInsignia{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 50
		BONUS_STR = 15
		BONUS_ARM = 10
		BONUS_STA = 20
		BONUS_MF = 50
		WEIGHT = 0.1
		PRICE = 1000

	SCOUTER/MASTER_ROSHIS_SUNGLASSES
		EQUIPABLE = TRUE;
		DISPLAY = "{yMaster Roshi's{x {DSunglasses{x"
		MULTI = FALSE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "over";
		BONUS_KI = 45
		BONUS_STR = -2
		BONUS_ARM = -2
		BONUS_STA = 20
		BONUS_MF = 350
		WEIGHT = 0.1
		PRICE = 1000
		SCOUTER_LEVEL = 1

	THE_THIRD_EYE
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "Third {WE{x{Dy{x{we{x"
		MULTI = FALSE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI =  120
		BONUS_STR = 20
		BONUS_ARM = 20
		BONUS_STA = 120
		BONUS_MF = 250
		WEIGHT = 0.1
		PRICE = 2500

	GOKUS_WEIGHTED_WRISTBANDS
		EQUIPABLE = TRUE;
		DISPLAY = "{cGoku's{x Weighted {RWr{x{bis{x{Rtb{x{ban{x{Rds{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI =  50
		BONUS_STR = -15
		BONUS_ARM = 20
		BONUS_STA = 0
		BONUS_MF = 0
		WEIGHT = 25
		PRICE = 500

	CELLS_CARAPACE_KNEE_CAPS
		EQUIPABLE = TRUE;
		DISPLAY = "{GCell's{x {DC{x{ga{x{Dr{x{ga{x{Dp{x{ga{x{Dc{x{ge{x {mKnee{x {DCaps{x"
		MULTI = FALSE;
		SLOT = KNEES;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI =  85
		BONUS_STR = 20
		BONUS_ARM = 20
		BONUS_STA = 35
		BONUS_MF = 250
		WEIGHT = 0.1
		PRICE = 1500

	CELLS_CARAPACE_CHEST_PLATE
		EQUIPABLE = TRUE;
		DISPLAY = "{GCell's{x {DC{x{ga{x{Dr{x{ga{x{Dp{x{ga{x{Dc{x{ge{x {mChest{x {DPlate{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI =  85
		BONUS_STR = 20
		BONUS_ARM = 40
		BONUS_STA = 25
		BONUS_MF = 0
		WEIGHT = 3.1
		PRICE = 1500

	CELLS_CHITINOUS_WING_PLATES
		EQUIPABLE = TRUE;
		DISPLAY = "{GCell's{x {DC{x{gh{x{Di{x{gt{x{Di{x{gn{x{Do{x{gu{x{Ds{x {mWing{x {DPlates{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI =  45
		BONUS_STR = 23
		BONUS_ARM = 33
		BONUS_STA = 25
		BONUS_MF = 0
		WEIGHT = 1
		PRICE = 1500

	CELLS_CHITINOUS_FOOT_PLATES
		EQUIPABLE = TRUE;
		DISPLAY = "{GCell's{x {DC{x{gh{x{Di{x{gt{x{Di{x{gn{x{Do{x{gu{x{Ds{x {mFoot{x {DPlates{x"
		MULTI = FALSE;
		SLOT =FEET;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI =  25
		BONUS_STR = 22
		BONUS_ARM = 33
		BONUS_STA = 25
		BONUS_MF = 0
		WEIGHT = 1
		PRICE = 1500

	CELLS_CHITINOUS_SLEEVES
		EQUIPABLE = TRUE;
		DISPLAY = "{GCell's{x {DC{x{gh{x{Di{x{gt{x{Di{x{gn{x{Do{x{gu{x{Ds{x {mSl{x{Deev{x{mes{x"
		MULTI = FALSE;
		SLOT = ARMS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI =  35
		BONUS_STR = 23
		BONUS_ARM = 31
		BONUS_STA = 35
		BONUS_MF = 0
		WEIGHT = 1
		PRICE = 1500

	KING_KAI_INSIGNIA
		EQUIPABLE = TRUE;
		DISPLAY = "{mKing{x {CKai's{x {wInsignia{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI =  55
		BONUS_STR = 15
		BONUS_ARM = 23
		BONUS_STA = 150
		BONUS_MF = 100
		WEIGHT = 0.1
		PRICE = 1500

	HFILFIRE_BRAND
		EQUIPABLE = TRUE;
		DISPLAY = "{WH{x{RF{x{WI{x{RL{x{rfire{x {RBr{x{Da{x{Rnd{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI =  55
		BONUS_STR = 25
		BONUS_ARM = 15
		BONUS_STA = 160
		BONUS_MF = 50
		WEIGHT = 0.1
		PRICE = 1500

	HEAVY_METAL_CHESTPLATE
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{WHeavy{x {DMetal{x {wChestplate{x"
		SINGLE_DISPLAY = "{WHeavy{x {DMetal{x {wChestplate{x"
		MULTI_DISPLAY = "{WHeavy{x {DMetal{x {wChestplate{x"
		MULTI = TRUE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = -70
		BONUS_STR = -20
		BONUS_ARM = 55
		BONUS_STA = 25
		BONUS_MF = 0
		WEIGHT = 50
		PRICE = 1500

	SAIYAN_BATTLE_ARMOR
		EQUIPABLE = TRUE;
		DISPLAY = "{cSaiyan{x {rBattle{x {WArmor{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 15
		BONUS_STR = 13
		BONUS_ARM = 14
		BONUS_STA = 15
		BONUS_MF = 0
		WEIGHT = 1
		PRICE = 500

	METAL_CHESTPLATE
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{DMetal{x {wChestplate{x"
		SINGLE_DISPLAY = "{DMetal{x {wChestplate{x"
		MULTI_DISPLAY = "{DMetal{x {wChestplate{x"
		MULTI = TRUE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		BONUS_KI = -30
		BONUS_STR = -10
		BONUS_ARM = 15
		BONUS_STA = 15
		BONUS_MF = 0
		WEIGHT = 25
		PRICE = 1500

	GINYU_FORCE_BATTLE_ARMOR
		EQUIPABLE = TRUE;
		DISPLAY = "{mGinyu{x {YForce{x {rBattle{x {WArmor{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 55
		BONUS_STR = 15
		BONUS_ARM = 19
		BONUS_STA = 25
		BONUS_MF = 0
		WEIGHT = 5
		PRICE = 1500

		/*Tao Set*/
	GENERAL_TAO_PINK_KIMONO
		EQUIPABLE = TRUE;
		DISPLAY = "{yGeneral Tao's{x {MPink{x {RKimono{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 15
		BONUS_STR = 10
		BONUS_ARM = 10
		BONUS_STA = 12
		BONUS_MF = 0
		WEIGHT = 0.5
		PRICE = 1500

	KILL_YOU_INSIGNIA
		EQUIPABLE = TRUE;
		DISPLAY = "{MK{x{RILL YO{MU{x {DInsignia{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 30
		BONUS_STR = 34
		BONUS_ARM = -20
		BONUS_STA = 15
		BONUS_MF = 50
		WEIGHT = 0.1
		DROP_CHANCE = 1.00
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	SCOUTER/GENERAL_TAO_POWER_GOGGLES
		EQUIPABLE = TRUE;
		DISPLAY = "{yGeneral Tao's{x {DPo{x{Rw{x{Der{x {DGo{Rggl{x{Des{x"
		MULTI = FALSE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 15
		BONUS_STR = 11
		BONUS_ARM = 10
		BONUS_STA = 11
		BONUS_MF = 30
		WEIGHT = 0.3
		DROP_CHANCE = 7.50
		PRICE = 2500
		SCOUTER_LEVEL = 1
	/*TAO SET END*/

	DR_GERO_VEST
		EQUIPABLE = TRUE
		DISPLAY = "{DDr. Gero's{x {YVest{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 50
		BONUS_STR = 25
		BONUS_ARM = 30
		BONUS_STA = 80
		BONUS_MF = 30
		WEIGHT = 0.3
		DROP_CHANCE = 7.50
		PRICE = 2500

	GOLD_FUSION_VEST
		EQUIPABLE = TRUE
		DISPLAY = "{YGold{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {YV{x{Des{x{Yt{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 90
		BONUS_STR = 55
		BONUS_ARM = 41
		BONUS_STA = 110
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 2.50
		PRICE = 3500

	ORANGE_FUSION_VEST
		EQUIPABLE = TRUE
		DISPLAY = "{oOrange{x {DF{x{ou{x{Ds{x{oi{x{Do{x{on{x {oV{x{Des{x{ot{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 120
		BONUS_STR = 57
		BONUS_ARM = 43
		BONUS_STA = 100
		BONUS_MF = 300
		WEIGHT = 0.5
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	GODLY_FLAME_VEST
		EQUIPABLE = TRUE
		DISPLAY = "{YGo{x{rdly{x {RFlame{x {BVest{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 180
		BONUS_STR = 80
		BONUS_ARM = 140
		BONUS_STA = 100
		BONUS_MF = 1000
		WEIGHT = 0.1
		DROP_CHANCE = 0.1
		ANNOUNCE_DROP = TRUE
		PRICE = 100000

	GODLY_FLAME_BOOTS
		EQUIPABLE = TRUE
		DISPLAY = "{YGo{x{rdly{x {RFlame{x {WBoots{x"
		MULTI = FALSE
		SLOT = FEET
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 145
		BONUS_STR = 40
		BONUS_ARM = 80
		BONUS_STA = 250
		BONUS_MF = 1000
		WEIGHT = 0.1
		DROP_CHANCE = 0.1
		ANNOUNCE_DROP = TRUE
		PRICE = 100000

	GODLY_FLAME_BRACERS
		EQUIPABLE = TRUE
		DISPLAY = "{YGo{x{rdly{x {RFlame{x {wBracers{x"
		MULTI = FALSE
		SLOT = WRISTS
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 140
		BONUS_STR = 250
		BONUS_ARM = 40
		BONUS_STA = 50
		BONUS_MF = 1000
		WEIGHT = 0.1
		DROP_CHANCE = 0.1
		ANNOUNCE_DROP = TRUE
		PRICE = 100000

	GODLY_FLAME_GLOVES
		EQUIPABLE = TRUE
		DISPLAY = "{YGo{x{rdly{x {RFlame{x {WGloves{x"
		MULTI = FALSE
		SLOT = HANDS
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 200
		BONUS_STR = 80
		BONUS_ARM = 80
		BONUS_STA = 40
		BONUS_MF = 1000
		WEIGHT = 0.1
		DROP_CHANCE = 0.1
		ANNOUNCE_DROP = TRUE
		PRICE = 100000

	GODLY_FLAME_HELMET
		EQUIPABLE = TRUE
		DISPLAY = "{YGo{x{rdly{x {RFlame{x {YHelmet{x"
		MULTI = FALSE
		SLOT = HEAD
		STACKABLE = TRUE
		EQ_MSG = "on"
		BONUS_KI = 100
		BONUS_STR = 80
		BONUS_ARM = 180
		BONUS_STA = 30
		BONUS_MF = 800
		WEIGHT = 0.1
		DROP_CHANCE = 0.1
		ANNOUNCE_DROP = TRUE
		PRICE = 100000

	SCOUTER/GODLY_FLAME_SCOUTER
		EQUIPABLE = TRUE
		DISPLAY = "{YGo{x{rdly{x {RFlame{x {GScouter{x"
		MULTI = FALSE
		SLOT = EYE
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 750
		BONUS_STR = 200
		BONUS_ARM = 200
		BONUS_STA = 200
		BONUS_MF = 750
		WEIGHT = 0.1
		DROP_CHANCE = 0.1
		ANNOUNCE_DROP = TRUE
		PRICE = 100000
		var/active = TRUE

	BLACK_FUSION_BRACERS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DBlack {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {DBracers{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 110
		BONUS_STR = 35
		BONUS_ARM = 52
		BONUS_STA = 60
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 2
		PRICE = 5000

	/*Super Chest Set*/
	SUPER_FUSION_VEST
		EQUIPABLE = TRUE
		DISPLAY = "{o({x{MSuper{x{o){x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {YV{x{Des{x{Yt{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 110
		BONUS_STR = 56
		BONUS_ARM = 63
		BONUS_STA = 75
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	SUPER_WHITE_CAPE
		EQUIPABLE = TRUE
		DISPLAY = "{o({x{MSuper{x{o){x {WWhite {x{wCape{x"
		MULTI = FALSE
		SLOT = SHOULDERS
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 120
		BONUS_STR = -30
		BONUS_ARM = 80
		BONUS_STA = 150
		BONUS_MF = 0
		WEIGHT = 35
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	SUPER_DRAGON_GI
		EQUIPABLE = TRUE
		DISPLAY = "{o({x{MSuper{x{o){x {gD{x{wr{x{ga{x{wg{x{go{x{wn {x{oGi{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 160
		BONUS_STR = 86
		BONUS_ARM = 51
		BONUS_STA = 160
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	SUPER_MYSTIC_GI
		EQUIPABLE = TRUE
		DISPLAY = "{o({x{MSuper{x{o){x {B({x{CMystic{x{B){x {gD{x{wr{x{ga{x{wg{x{go{x{wn {x{oGi{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 100
		BONUS_STR = 65
		BONUS_ARM = 42
		BONUS_STA = 270
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	FUSION_BAGGY_WHITE_PANTS
		EQUIPABLE = TRUE;
		DISPLAY = "{DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {wBaggy{x {WWhite{x {wPants{x"
		MULTI = FALSE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 110
		BONUS_STR = 67
		BONUS_ARM = 40
		BONUS_STA = 70
		BONUS_MF = 0
		WEIGHT = 1
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	ORANGE_FUSION_PANTS
		EQUIPABLE = TRUE;
		DISPLAY = "{oOr{x{Ban{x{oge{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {oP{x{Ba{x{on{x{Bt{x{os{x"
		MULTI = FALSE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 90
		BONUS_STR = 76
		BONUS_ARM = 33
		BONUS_STA = 61
		BONUS_MF = 0
		WEIGHT = 1
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	/*Super set continued*/

	BARDOCKS_HEADBAND
		EQUIPABLE = TRUE
		DISPLAY = "{cBardock's{x {RHeadband{x"
		MULTI = FALSE
		SLOT = HEAD
		STACKABLE = TRUE
		EQ_MSG = "around"
		BONUS_KI = 20
		BONUS_STR = 20
		BONUS_ARM = 10
		BONUS_STA = 15
		BONUS_MF = 260
		WEIGHT = 1
		PRICE = 500

	BARDOCKS_BATTLE_ARMOR
		EQUIPABLE = TRUE
		DISPLAY = "{cBardock's{x {gBattle{x {YArmor{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 10
		BONUS_STR = 10
		BONUS_ARM = 20
		BONUS_STA = 10
		BONUS_MF = 210
		WEIGHT = 1
		PRICE = 500

/*AfterLife Epics.*/
	DEMONIC_BREASTPLATE
		EQUIPABLE = TRUE
		DISPLAY = "{RD{x{we{x{Rm{x{Do{x{Rn{x{wi{x{Rc{x {DBreastplate{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 75
		BONUS_STR = 27
		BONUS_ARM = 25
		BONUS_STA = 55
		BONUS_MF = 210
		WEIGHT = 17
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	ANGELIC_BREASTPLATE
		EQUIPABLE = TRUE
		DISPLAY = "{CA{x{Wng{x{Ye{x{Wli{x{Cc{x {WBreastplate{x"
		MULTI = FALSE
		SLOT = CHEST
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 55
		BONUS_STR = 25
		BONUS_ARM = 27
		BONUS_STA = 77
		BONUS_MF = 210
		WEIGHT = 17
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	HFILFIRE_HORNS
		EQUIPABLE = TRUE;
		DISPLAY = "{WH{x{RF{x{WI{x{RL{x{rfire{x {RHo{x{Dr{x{Rns{x";
		MULTI = FALSE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		EQ_MSG0 = "from"
		BONUS_KI = 70
		BONUS_STR = 27
		BONUS_ARM = 22
		BONUS_STA = 50
		BONUS_MF = 270
		WEIGHT = 0.1
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	HEAVENLY_HALO
		EQUIPABLE = TRUE;
		DISPLAY = "{CH{x{Wea{x{Yve{x{Wnl{x{Cy{x {YHalo{x";
		MULTI = FALSE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "above"
		EQ_MSG0 = "floating"
		BONUS_KI = 50
		BONUS_STR = 24
		BONUS_ARM = 27
		BONUS_STA = 70
		BONUS_MF = 250
		WEIGHT = 0.1
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE;
		PRICE = 10000

	METAL_ARMPLATE
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{DMetal{x {wArmplate{x"
		SINGLE_DISPLAY = "{DMetal{x {wArmplate{x"
		MULTI_DISPLAY = "{DMetal{x {wArmplate{x"
		MULTI = TRUE;
		SLOT = ARMS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 0
		BONUS_STR = -5
		BONUS_ARM = 20
		BONUS_STA = 16
		BONUS_MF = 0
		WEIGHT = 8
		PRICE = 1500

	SNAKESKIN_SLEEVES
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{gS{x{wn{x{ga{x{wk{x{ge{x{ws{x{gk{x{wi{x{gn{x {WS{x{Dle{x{Ce{x{Dve{x{Ws{x"
		SINGLE_DISPLAY = "{gS{x{wn{x{ga{x{wk{x{ge{x{ws{x{gk{x{wi{x{gn{x {WS{x{Dle{x{Ce{x{Dve{x{Ws{x"
		MULTI_DISPLAY = "{gS{x{wn{x{ga{x{wk{x{ge{x{ws{x{gk{x{wi{x{gn{x {WS{x{Dle{x{Ce{x{Dve{x{Ws{x"
		MULTI = TRUE;
		SLOT = ARMS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 20
		BONUS_STR = 10
		BONUS_ARM = 10
		BONUS_STA = 10
		BONUS_MF = 0
		WEIGHT = 0.1
		PRICE = 1500

	KNEE_PADS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{wKnee{x {DPads{x"
		SINGLE_DISPLAY = "{wKnee{x {DPads{x"
		MULTI_DISPLAY = "{wKnee{x {DPads{x"
		MULTI = TRUE;
		SLOT = KNEES;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 20
		BONUS_STR = 10
		BONUS_ARM = 20
		BONUS_STA = 0
		BONUS_MF = 0
		WEIGHT = 3
		PRICE = 500

	HEAVY_WRISTBAND
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{WHeavy{x {wWristbands{x"
		SINGLE_DISPLAY = "{WHeavy{x {wWristbands{x"
		MULTI_DISPLAY = "{WHeavy{x {wWristbands{x"
		MULTI = TRUE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 20
		BONUS_STR = -5
		BONUS_ARM = 15
		BONUS_STA = -10
		BONUS_MF = 0
		WEIGHT = 8
		PRICE = 500

	LONG_FUSION_SASH
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{CLong{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {cS{x{Cas{x{ch{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 90
		BONUS_STR = 54
		BONUS_ARM = 61
		BONUS_STA = 137
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 7.50
		PRICE = 3500

	GOGETAS_SASH
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{CGogeta's{x {YSash{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 430
		BONUS_STR = 160
		BONUS_ARM = 150
		BONUS_STA = 80
		BONUS_MF = 450
		WEIGHT = 0.1
		DROP_CHANCE = 17.50
		PRICE = 235000
		ANNOUNCE_DROP = TRUE;
		NO_MYSTERY = TRUE;

	BLACK_SASH
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{DBlack{x {ySash{x"
		SINGLE_DISPLAY = "{DBlack{x {ySash{x"
		MULTI_DISPLAY = "{DBlack{x {ySash{x"
		MULTI = TRUE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 20
		BONUS_STR = 54
		BONUS_ARM = 37
		BONUS_STA = 17
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 7.50
		PRICE = 2500

	POTARA_FUSION_EARRINGS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{CP{x{mo{x{Ct{x{ma{x{Cr{x{ma{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {wE{x{Ya{x{wr{x{Yr{x{wi{x{Yn{x{wg{x{Ys{x"
		SINGLE_DISPLAY = "{CP{x{mo{x{Ct{x{ma{x{Cr{x{ma{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {wE{x{Ya{x{wr{x{Yr{x{wi{x{Yn{x{wg{x"
		MULTI_DISPLAY = "{CP{x{mo{x{Ct{x{ma{x{Cr{x{ma{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {wE{x{Ya{x{wr{x{Yr{x{wi{x{Yn{x{wg{x"
		MULTI = TRUE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 140
		BONUS_STR = 67
		BONUS_ARM = 47
		BONUS_STA = 170
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 1
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	CRIMSON_EARRINGS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{rCrimson{x {CEarrings{x"
		SINGLE_DISPLAY = "{rCrimson{x {CEarring{x"
		MULTI_DISPLAY = "{rCrimson{x {CEarring{x"
		MULTI = TRUE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 135
		BONUS_STR = 150
		BONUS_ARM = 45
		BONUS_STA = 80
		BONUS_MF = 800
		WEIGHT = 0.1
		DROP_CHANCE = 0.3
		ANNOUNCE_DROP = TRUE
		PRICE = 50000

	GOLD_EARRING
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{YGold{x {wEarrings{x"
		SINGLE_DISPLAY = "{YGold{x {wEarring{x"
		MULTI_DISPLAY = "{YGold{x {wEarring{x"
		MULTI = TRUE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 100
		BONUS_STR = 62
		BONUS_ARM = 30
		BONUS_STA = 21
		BONUS_MF = 310
		WEIGHT = 0.1
		PRICE = 500

	X0_JIZZ_STAINED_HAKAMA
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DX0's{x {rBlood{x-{wStained{x {bHakamas{x"
		MULTI = FALSE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 177
		BONUS_STR = 57
		BONUS_ARM = 77
		BONUS_STA = 177
		BONUS_MF = 770
		WEIGHT = 0.1
		MISC = TRUE;
		STOCK_SHOP = FALSE
		PRICE = 100000

	FEARS_VERTEBRAE
		DESC = "A brutal necklace made from the bleached vertebrae of Fears spinal cord, harvested by Numberseven."
		EQUIPABLE = TRUE;
		DISPLAY = "{DFears{x {WVe{x{wr{x{Dt{x{re{x{Db{x{wr{x{Wae{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 310
		BONUS_STR = 67
		BONUS_ARM = 41
		BONUS_STA = 180
		BONUS_MF = 850
		WEIGHT = 0.1
		MISC = FALSE;
		PRICE = 15000
		DROP_CHANCE = 0.5;
		ANNOUNCE_DROP = TRUE;

	CRIMSON_HFIL_EARRING
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{RCri{rm{x{Rson{x {RH{x{WF{x{RI{x{WL{x {wEarrings{x"
		SINGLE_DISPLAY = "{RCri{rm{x{Rson{x {RH{x{WF{x{RI{x{WL{x {wEarring{x"
		MULTI_DISPLAY = "{RCri{rm{x{Rson{x {RH{x{WF{x{RI{x{WL{x {wEarring{x"
		MULTI = TRUE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 66
		BONUS_STR = 26
		BONUS_ARM = 16
		BONUS_STA = 66
		BONUS_MF = 270
		WEIGHT = 0.1
		DROP_CHANCE = 11.00
		PRICE = 1250

	PRINCESS_SNAKE_EARRINGS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{WPr{x{Mi{x{Rnc{x{Me{x{Wss{x {gS{x{wn{x{ga{x{wk{x{ge{x{w'{x{gs{x {WEa{x{Mr{x{Rri{x{Mn{x{Wgs{x"
		SINGLE_DISPLAY = "{WPr{x{Mi{x{Rnc{x{Me{x{Wss{x {gS{x{wn{x{ga{x{wk{x{ge{x{w'{x{gs{x {WEa{x{Mr{x{Rri{x{Mn{x{Wgs{x"
		MULTI_DISPLAY = "{WPr{x{Mi{x{Rnc{x{Me{x{Wss{x {gS{x{wn{x{ga{x{wk{x{ge{x{w'{x{gs{x {WEa{x{Mr{x{Rri{x{Mn{x{Wgs{xx"
		MULTI = TRUE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 99
		BONUS_STR = 15
		BONUS_ARM = 14
		BONUS_STA = 99
		BONUS_MF = 210
		WEIGHT = 0.1
		DROP_CHANCE = 11.00
		PRICE = 1250

	PICCOLOS_WEIGHTED_CAPE
		EQUIPABLE = TRUE;
		DISPLAY = "{gPiccolo's{x {wWeighted Cape{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = -10
		BONUS_STR = -10
		BONUS_ARM = 40
		BONUS_STA = 21
		BONUS_MF = 0
		WEIGHT = 21
		DROP_CHANCE = 11.00
		PRICE = 1250

	MAJIN_WRISTBANDS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{MMajin{x {DW{x{Yr{x{Di{x{Ys{x{Dt{x{Yb{x{Da{x{Yn{x{Dd{x{Ys{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 90
		BONUS_STR = 23
		BONUS_ARM = 12
		BONUS_STA = 72
		BONUS_MF = 360
		WEIGHT = 1
		DROP_CHANCE = 3.00
		PRICE = 5000

/*kIDsET*/
	KID_MAJIN_WRISTBANDS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{W({x{MKid{x{W){x {MMajin{x {DW{x{Yr{x{Di{x{Ys{x{Dt{x{Yb{x{Da{x{Yn{x{Dd{x{Ys{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 110
		BONUS_STR = 65
		BONUS_ARM = 34
		BONUS_STA = 172
		BONUS_MF = 310
		WEIGHT = 2
		DROP_CHANCE = 1.25
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	KID_BAGGY_WHITE_PANTS
		EQUIPABLE = TRUE;
		DISPLAY = "{W({x{MKid{x{W){x {wBaggy{x {WWhite{x {wPants{x"//
		MULTI = FALSE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 140
		BONUS_STR = 67
		BONUS_ARM = 34
		BONUS_STA = 172
		BONUS_MF = 0
		WEIGHT = 2
		DROP_CHANCE = 1.25
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	BLACK_AND_GOLD_MAJIN_BELT
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{DBlack{x {wand{x {YGold{x {MMajin{x {DBelt{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 90
		BONUS_STR = 45
		BONUS_ARM = 62
		BONUS_STA = 77
		BONUS_MF = 228
		WEIGHT = 1
		DROP_CHANCE = 1.25
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	KID_BLACK_BOOTS
		EQUIPABLE = TRUE;
		DISPLAY = "{W({x{MKid{x{W){x {DBlack Boots{x"
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 120
		BONUS_STR = 47
		BONUS_ARM = 65
		BONUS_STA = 172
		BONUS_MF = 0
		WEIGHT = 2
		DROP_CHANCE = 1.25
		ANNOUNCE_DROP = TRUE
		PRICE = 10000

	BLUE_DEMON_GI
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{BBlue{x {RDe{x{Dm{x{Ron{x {DGi{x"
		MULTI = FALSE;
		SLOT =CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 27
		BONUS_STR = 33
		BONUS_ARM = 42
		BONUS_STA = 22
		BONUS_MF = 110
		WEIGHT = 3
		PRICE = 500

	WHITE_SPIRIT_GI
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{WWhite{x {CS{x{Dpi{x{Wr{x{Di{x{Ct{x {wGi{x"
		MULTI = FALSE;
		SLOT =CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 21
		BONUS_STR = 12
		BONUS_ARM = 13
		BONUS_STA = 21
		BONUS_MF = 117
		WEIGHT = 0.1
		PRICE = 500

	BLUE_DEMON_PANTS
		EQUIPABLE = TRUE;
		PREFIX = "some ";
		DISPLAY = "{BBlue{x {RDe{x{Dm{x{Ron{x {DPants{x"
		MULTI = FALSE;
		SLOT =LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 27
		BONUS_STR = 13
		BONUS_ARM = 12
		BONUS_STA = 22
		BONUS_MF = 117
		WEIGHT = 0.1
		PRICE = 500

	WHITE_SPIRIT_PANTS
		EQUIPABLE = TRUE;
		PREFIX = "some ";
		DISPLAY = "{WWhite{x {CS{x{Dpi{x{Wr{x{Di{x{Ct{x {wPants{x"
		MULTI = FALSE;
		SLOT =LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 21
		BONUS_STR = 12
		BONUS_ARM = 13
		BONUS_STA = 27
		BONUS_MF = 117
		WEIGHT = 0.1
		PRICE = 500

	SOFT_NAMEKIAN_SHOES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of "
		DISPLAY = "{wSoft{x {gNamekian{x {yShoes{x"
		SINGLE_DISPLAY = "{wSoft{x {gNamekian{x {yShoe{x"
		MULTI_DISPLAY = "{wSoft{x {gNamekian{x {yShoe{x"
		MULTI = TRUE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 11
		BONUS_STR = 15
		BONUS_ARM = 11
		BONUS_STA = 7
		BONUS_MF = 0
		WEIGHT = 4
		PRICE = 500

	HEAVY_NAMEKIAN_SCARF
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{wHeavy{x {gNamekian{x {WScarf{x"
		SINGLE_DISPLAY = "{wHeavy{x {gNamekian{x {WScarf{x"
		MULTI_DISPLAY = "{wHeavy{x {gNamekian{x {WScarf{x"
		MULTI = TRUE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = -7
		BONUS_STR = -3
		BONUS_ARM = 25
		BONUS_STA = -2
		BONUS_MF = 0
		WEIGHT = 12
		PRICE = 500

	HEAVY_RED_SASH
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{wHeavy{x {RRed{x {bSash{x"
		SINGLE_DISPLAY = "{wHeavy{x {RRed{x {bSash{x"
		MULTI_DISPLAY = "{wHeavy{x {RRed{x {bSash{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 11
		BONUS_STR = -2
		BONUS_ARM = 17
		BONUS_STA = 17
		BONUS_MF = 0
		WEIGHT = 12
		DROP_CHANCE = 8
		PRICE = 1250

	GOKUS_WEIGHTED_BOOTS
		EQUIPABLE = TRUE;
		DISPLAY = "{cGoku's{x {wWeighted{x {bBoots{x"
		MULTI = FALSE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 29
		BONUS_STR = -7
		BONUS_ARM = 15
		BONUS_STA = 10
		BONUS_MF = 0
		WEIGHT = 14
		DROP_CHANCE = 6
		PRICE = 2500

	HEAVY_SPIKED_POLEYONS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DHeavy{x {wSpiked{x {DPoleyons{x"
		SINGLE_DISPLAY = "{DHeavy{x {wSpiked{x {DPoleyons{x"
		MULTI_DISPLAY = "{DHeavy{x {wSpiked{x {DPoleyons{x"
		MULTI = TRUE;
		SLOT = KNEES;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = -10
		BONUS_STR = -12
		BONUS_ARM = 25
		BONUS_STA = -5
		BONUS_MF = 0
		WEIGHT = 8
		PRICE = 500

	BLOODIED_VAMBRACES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{RBloodied{x {cVambraces{x"
		SINGLE_DISPLAY = "{RBloodied{x {cVambraces{x"
		MULTI_DISPLAY = "{RBloodied{x {cVambraces{x"
		MULTI = TRUE;
		SLOT = ARMS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = -10
		BONUS_STR = 12
		BONUS_ARM = 14
		BONUS_STA = 0
		BONUS_MF = 0
		WEIGHT = 12
		PRICE = 500

	FINGERLESS_LEAD_LINED_GLOVES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{cFingerless{x {wLead Lined{x {DGloves{x"
		SINGLE_DISPLAY = "{cFingerless{x {wLead Lined{x {DGloves{x"
		MULTI_DISPLAY = "{cFingerless{x {wLead Lined{x {DGloves{x"
		MULTI = TRUE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 10
		BONUS_STR = 15
		BONUS_ARM = 5
		BONUS_STA = 11
		BONUS_MF = 0
		WEIGHT = 8
		PRICE = 500

	HEAVY_KUSARI_LEGGINS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{wHeavy{x {DKusari{x {wLeggings{x"
		SINGLE_DISPLAY = "{wHeavy{x {DKusari{x {wLeggings{x"
		MULTI_DISPLAY = "{wHeavy{x {DKusari{x {wLeggings{x"
		MULTI = TRUE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 10
		BONUS_STR = 5
		BONUS_ARM = 20
		BONUS_STA = 0
		BONUS_MF = 0
		WEIGHT = 12
		PRICE = 1500

/*fATsET*/
	BLACK_AND_GOLD_MAJIN_VEST
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{DBlack{x {wand{x {YGold{x {MMajin{x {YV{x{Des{x{Yt{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 90
		BONUS_STR = 63
		BONUS_ARM = 43
		BONUS_STA = 46
		BONUS_MF = 360
		WEIGHT = 1
		DROP_CHANCE = 3.00
		PRICE = 5000

	GOLD_MITTENS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of "
		DISPLAY = "{YG{x{yol{x{Yd{x {YMi{x{ytten{x{Ys{x"
		SINGLE_DISPLAY = "{YG{x{yol{x{Yd{x {YMi{x{ytten{x{Ys{x"
		MULTI_DISPLAY = "{YG{x{yol{x{Yd{x {YMi{x{ytten{x{Ys{x"
		MULTI = TRUE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 90
		BONUS_STR = 83
		BONUS_ARM = 42
		BONUS_STA = 80
		BONUS_MF = 370
		WEIGHT = 1
		DROP_CHANCE = 3.00
		PRICE = 5000

	GOLD_SHOES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of "
		DISPLAY = "{YG{x{yol{x{Yd{x {YSh{x{yoe{x{Ys{x"
		SINGLE_DISPLAY = "{YG{x{yol{x{Yd{x {YSh{x{yoe{x"
		MULTI_DISPLAY = "{YG{x{yol{x{Yd{x {YSh{x{yoe{x"
		MULTI = TRUE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 90
		BONUS_STR = 43
		BONUS_ARM = 64
		BONUS_STA = 56
		BONUS_MF = 370
		WEIGHT = 1
		DROP_CHANCE = 3.00
		PRICE = 5000

	PURPLE_MAJIN_CAPE
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{MPurple{x {MMajin{x {wCape{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "tied around"
		BONUS_KI = 110
		BONUS_STR = 29
		BONUS_ARM = 43
		BONUS_STA = 66
		BONUS_MF = 360
		WEIGHT = 1
		DROP_CHANCE = 3.00
		PRICE = 5000

/*eNDfATsET*/
/*GodSeT*/

	ARMBANDS_OF_DESTRUCTION
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{DA{x{Yrm{x{Dba{x{Ynd{x{Ds{x {wof{x {RD{x{be{x{rst{x{Dr{x{bu{x{Dc{x{rti{x{bo{x{Rn{x"
		SINGLE_DISPLAY = "{DA{x{Yrm{x{Dba{x{Ynd{x{Ds{x {wof{x {RD{x{be{x{rst{x{Dr{x{bu{x{Dc{x{rti{x{bo{x{Rn{x"
		MULTI_DISPLAY = "{DA{x{Yrm{x{Dba{x{Ynd{x{Ds{x {wof{x {RD{x{be{x{rst{x{Dr{x{bu{x{Dc{x{rti{x{bo{x{Rn{x"
		MULTI = TRUE;
		SLOT = ARMS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 130
		BONUS_STR = 80
		BONUS_ARM = 40
		BONUS_STA = 150
		BONUS_MF = 1100
		WEIGHT = 0.1
		PRICE = 15000

	MAJIN_TATTOO
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{DMajin Tattoo{x"
		SINGLE_DISPLAY = "{DMajin Tattoo{x"
		MULTI_DISPLAY = "{DMajin Tattoo{x"
		MULTI = TRUE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 120
		BONUS_STR = 24
		BONUS_ARM = 57
		BONUS_STA = 60
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 3.00
		PRICE = 5000

	SAIYAN_BRACERS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DSaiyan Bracers{x"
		SINGLE_DISPLAY = "{DSaiyan Bracers{x"
		MULTI_DISPLAY = "{DSaiyan Bracers{x"
		MULTI = TRUE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 17
		BONUS_STR = 10
		BONUS_ARM = 10
		BONUS_STA = 11
		BONUS_MF = 0
		WEIGHT = 1
		PRICE = 500

	ROSHIS_TURTLESHELL
		EQUIPABLE = TRUE;
		DISPLAY = "{yRoshi's{x {gTurtle Shell{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 21
		BONUS_STR = -5
		BONUS_ARM = 7
		BONUS_STA = -5
		BONUS_MF = 0
		WEIGHT = 3
		PRICE = 500

	YAMCHAS_DESERT_MASK
		EQUIPABLE = TRUE;
		DISPLAY = "{yYamcha's{x {YD{x{ye{x{Ys{x{ye{x{Yr{x{yt{x {RMask{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 53
		BONUS_STR = 17
		BONUS_ARM = -12
		BONUS_STA = 35
		BONUS_MF = 150
		DROP_CHANCE = 4
		PRICE = 5000

	ANDROID_ENERGY_CRYSTALS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DAndroid{x {RE{x{rn{x{Re{x{rr{x{Rg{x{ry{x {CCrystals{x"
		SINGLE_DISPLAY = "{DAndroid{x {RE{x{rn{x{Re{x{rr{x{Rg{x{ry{x {CCrystals{x"
		MULTI_DISPLAY = "{DAndroid{x {RE{x{rn{x{Re{x{rr{x{Rg{x{ry{x {CCrystals{x"
		MULTI = TRUE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 63
		BONUS_STR = 27
		BONUS_ARM = -12
		BONUS_STA = 80
		BONUS_MF = 110
		DROP_CHANCE = 4
		PRICE = 5000

	RED_RIBBON_INSIGNIA
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{RR{x{Wed{x {RR{x{Wibbon{x {DInsignia{x"
		SINGLE_DISPLAY = "{WR{x{Red{x {WR{x{Wibbon{x {DInsignia{x"
		MULTI_DISPLAY = "{WR{x{Red{x {WR{x{Wibbon{x {DInsignia{x"
		MULTI = TRUE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 77
		BONUS_STR = 25
		BONUS_ARM = 15
		BONUS_STA = 77
		BONUS_MF = 210
		DROP_CHANCE = 4
		PRICE = 5000

	DORES_HELMET
		EQUIPABLE = TRUE;
		DISPLAY = "Dore's {WHe{x{ylm{x{Wet{x"
		MULTI = FALSE;
		SLOT = HEAD ;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 111
		BONUS_STR = 26
		BONUS_ARM = 36
		BONUS_STA = -36
		BONUS_MF = 0
		WEIGHT = 10
		DROP_CHANCE = 4
		PRICE = 5000

/* Jewelry/Rings */

	NOVICE_RING
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "Novice Ring"
		SINGLE_DISPLAY = "Novice Ring"
		MULTI_DISPLAY = "Novice Ring"
		MULTI = TRUE;
		SLOT = FINGERS;
		DROP_CHANCE = 13.00;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 15
		BONUS_STR = 15
		BONUS_ARM = 15
		BONUS_STA = 15
		BONUS_MF = 15
		WEIGHT = 0.1
		PRICE = 500

	ISA_SHINY_DIAMOND_RING_OF_FURY
		EQUIPABLE = TRUE;
		DISPLAY = "{WIsa's{x {YShiny{x {WDiamond{x {YRing{x {Dof{x {RFury{x"
		MULTI = FALSE;
		SLOT = FINGERS;
		DROP_CHANCE = 0.00;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 300;
		BONUS_STR = 80;
		BONUS_ARM = 80;
		BONUS_STA = 150;
		BONUS_MF = 850;
		WEIGHT = 10.0;
		PRICE = 0;
		MISC = TRUE;
		CAN_DROP = FALSE;
		CAN_SELL = FALSE;

	SAPPHIRE_GRAVITY_RING
		//DESC = "A great ring for training but also increases stamina usage by 1% and eliminates the passive 1% regen.";
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{BS{x{ba{x{Bp{x{bp{x{Bh{x{bi{x{Br{x{be{x {mGravity{x {BR{x{Yin{x{Bg{x"
		SINGLE_DISPLAY = "{BS{x{ba{x{Bp{x{bp{x{Bh{x{bi{x{Br{x{be{x {mGravity{x {BR{x{Yin{x{Bg{x"
		MULTI_DISPLAY = "{BS{x{ba{x{Bp{x{bp{x{Bh{x{bi{x{Br{x{be{x {mGravity{x {BR{x{Yin{x{Bg{x"
		MULTI = TRUE;
		SLOT = FINGERS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = -50
		BONUS_STR = 50
		BONUS_ARM = 50
		BONUS_STA = 100
		BONUS_MF = 0
		WEIGHT = 50
		PRICE = 50000

	RUBY_RING_OF_BLOODSHED
		//DESC = "An extremely powerful ring that has a 25% chance to cause hemmoraging but also weakens the wearers defenses.";
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{RR{x{ru{x{Rb{x{Ry{x {RR{x{Yin{x{Rg{x {Dof{x {RBloodshed{x"
		SINGLE_DISPLAY = "{RR{x{ru{x{Rb{x{Ry{x {RR{x{Yin{x{Rg{x {Dof{x {RBloodshed{x"
		MULTI_DISPLAY = "{RR{x{ru{x{Rb{x{Ry{x {RR{x{Yin{x{Rg{x {Dof{x {RBloodshed{x"
		MULTI = TRUE;
		SLOT = FINGERS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 40
		BONUS_STR = 300
		BONUS_ARM = -50
		BONUS_STA = -40
		BONUS_MF = 0
		WEIGHT = 0.1
		PRICE = 50000


	GOLDEN_RING_OF_AVARICE
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{YGolden Ring{x {cof{x {WA{x{Dva{Yr{x{Dic{x{We{x"
		SINGLE_DISPLAY = "{YGolden Ring{x {cof{x {WA{x{Dva{Yr{x{Dic{x{We{x"
		MULTI_DISPLAY = "{YGolden Ring{x {cof{x {WA{x{Dva{Yr{x{Dic{x{We{x"
		MULTI = TRUE;
		SLOT = FINGERS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = -40
		BONUS_STR = -20
		BONUS_ARM = -20
		BONUS_STA = -30
		BONUS_MF = 3500
		WEIGHT = 0.1
		PRICE = 50000

	STALWART_DIAMOND_RING
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{rStalwart{x {WD{x{Ci{x{Wa{x{Cm{x{Wo{x{Cn{x{Wd{x {WR{x{Yin{Wg{x"
		SINGLE_DISPLAY = "{rStalwart{x {WD{x{Ci{x{Wa{x{Cm{x{Wo{x{Cn{x{Wd{x {WR{x{Yin{Wg{x"
		MULTI_DISPLAY = "{rStalwart{x {WD{x{Ci{x{Wa{x{Cm{x{Wo{x{Cn{x{Wd{x {WR{x{Yin{Wg{x"
		MULTI = TRUE;
		SLOT = FINGERS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 30
		BONUS_STR = -50
		BONUS_ARM = 300
		BONUS_STA = 30
		BONUS_MF = 0
		WEIGHT = 2
		PRICE = 50000


	EMERALD_VITALITY_RING
		EQUIPABLE = TRUE;
		PREFIX = "an ";
		DISPLAY = "{GE{x{gm{x{Ge{x{gr{x{Ga{x{gl{x{Gd{x {rVitality{x {GR{x{Yin{x{Gg{x"
		SINGLE_DISPLAY = "{GE{x{gm{x{Ge{x{gr{x{Ga{x{gl{x{Gd{x {rVitality{x {GR{x{Yin{x{Gg{x"
		MULTI_DISPLAY = "{GE{x{gm{x{Ge{x{gr{x{Ga{x{gl{x{Gd{x {rVitality{x {GR{x{Yin{x{Gg{x"
		MULTI = TRUE;
		SLOT = FINGERS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 500
		BONUS_STR = -20
		BONUS_ARM = -20
		BONUS_STA = 20
		BONUS_MF = 0
		WEIGHT = 0.1
		PRICE = 50000

	OPAL_RING_OF_SPIRIT
		EQUIPABLE = TRUE;
		PREFIX = "an ";
		DISPLAY = "{WO{x{rp{x{ba{x{Cl{x {WR{x{Yin{x{Wg{x {cof{x {CS{x{Dpi{x{Wr{x{Di{x{Ct{x"
		SINGLE_DISPLAY = "{WO{x{rp{x{ba{x{Cl{x {WR{x{Yin{x{Wg{x {cof{x {CS{x{Dpi{x{Wr{x{Di{x{Ct{x"
		MULTI_DISPLAY = "{WO{x{rp{x{ba{x{Cl{x {WR{x{Yin{x{Wg{x {cof{x {CS{x{Dpi{x{Wr{x{Di{x{Ct{x"
		MULTI = TRUE;
		SLOT = FINGERS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = -100
		BONUS_STR = 0
		BONUS_ARM = 0
		BONUS_STA = 500
		BONUS_MF = 0
		WEIGHT = 0.1
		PRICE = 50000


	MYSTERY_BOX
		PREFIX = "a ";
		DISPLAY = "{GMystery Box{x"
		SINGLE_DISPLAY = "{GMystery Box{x"
		MULTI_DISPLAY = "{GMystery Box{x"
		CONTAINER = TRUE;
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = FALSE;
		DROP_CHANCE = 0.95;
		ANNOUNCE_DROP = TRUE;
		MISC = TRUE;
		PRICE = 50000

		_open(mob/Player/m){
			if(..(m)){
				if(decimal_prob(10) && m.maxpl < MAX_PL){
					m.gainPL_EVENT(ret_percent(MYSTERY_BOX_GAIN,m.maxpl),m,TRUE);
				}else if(decimal_prob(35)){
					var/zenniValue = 5000;
					send("You obtain {G[commafy(zenniValue)]{x {YZenni{x from [DISPLAY].",m)
					send("[m.raceColor(m.name)] obtains {G[commafy(zenniValue)]{x {YZenni{x from [DISPLAY].",_ohearers(0,m))
					m.zenni += zenniValue;
				}else{
					var/obj/item/itemx = NULL;

					while(!itemx){
						for(var/i in game.mysteryList){
							var/obj/item/x = new i;

							if(decimal_prob(0.05)){
								itemx = x;
							}else{ del(x); }
						}
					}

					m.addInv(itemx);
					send("You obtain [itemx.PREFIX][itemx.DISPLAY] from [PREFIX][DISPLAY].",m)
					send("[m.raceColor(m.name)] obtains [itemx.PREFIX][itemx.DISPLAY] from [PREFIX][DISPLAY].",_ohearers(0,m))
					if(itemx.ANNOUNCE_DROP){ send("{R\[{x{YWORLD{x{R\]{x [itemx.PREFIX][itemx.DISPLAY] dropped from [PREFIX][DISPLAY] opened by [m.raceColor(m.name)]!",game.players); }
				}
				return TRUE;
			}
			return FALSE;
		}

	EVENT_BOX
		PREFIX = "a ";
		DISPLAY = "{REvent{x {WBox{x"
		SINGLE_DISPLAY = "{REvent{x {WBox{x"
		MULTI_DISPLAY = "{REvent{x {WBox{x"
		CONTAINER = TRUE;
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = FALSE;
		DROP_CHANCE = 100.00;
		ANNOUNCE_DROP = TRUE;
		STOCK_SHOP = FALSE
		MISC = TRUE;
		PRICE = 70000;

		_open(mob/Player/m){
			if(..(m)){
				if(decimal_prob(5) && m.maxpl < MAX_PL){
					m.gainPL_EVENT(ret_percent(MYSTERY_BOX_GAIN*2,m.maxpl),m,TRUE);
				}else if(decimal_prob(35)){
					var/zenniValue = 5000*3;
					send("You obtain {G[commafy(zenniValue)]{x {YZenni{x from [DISPLAY].",m)
					send("[m.raceColor(m.name)] obtains {G[commafy(zenniValue)]{x {YZenni{x from [DISPLAY].",_ohearers(0,m))
					m.zenni += zenniValue;
				}else{
					for(var/v=0,v<3,v++){
						var/obj/item/itemx = NULL;

						while(!itemx){
							for(var/i in game.eventList){
								var/obj/item/x = new i;

								if(decimal_prob(0.05)){
									itemx = x;
								}else{ del(x); }
							}
						}

						m.addInv(itemx);
						send("You obtain [itemx.PREFIX][itemx.DISPLAY] from [PREFIX][DISPLAY].",m)
						send("[m.raceColor(m.name)] obtains [itemx.PREFIX][itemx.DISPLAY] from [PREFIX][DISPLAY].",_ohearers(0,m))
						if(itemx.ANNOUNCE_DROP){ send("{R\[{x{YWORLD{x{R\]{x [itemx.PREFIX][itemx.DISPLAY] dropped from [PREFIX][DISPLAY] opened by [m.raceColor(m.name)]!",game.players); }
					}
				}
				return TRUE;
			}
			return FALSE;
		}

	LSD
		PREFIX = "a piece of ";
		DISPLAY = "{ML{x{GS{x{RD{x"
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = TRUE;
		DROP_CHANCE = 0.00;
		ANNOUNCE_DROP = TRUE;
		MISC = TRUE;
		PRICE = 10000

		_eat(mob/Player/m){
			if(..(m)){
				m._lsd();
				send("You feel funny...",m,TRUE);

				return TRUE;
			}
			return FALSE;
		}

	rock
		PREFIX = "a large ";
		DISPLAY = "{WRock{x"
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = TRUE;
		DROP_CHANCE = 0.00;
		WEIGHT = 100.00;
		ANNOUNCE_DROP = TRUE;
		MISC = TRUE;
		PRICE = 0
		CAN_SELL = FALSE

		_eat(mob/Player/m){
			if(..(m)){
				m._lsd();
				send("You feel funny...",m,TRUE);

				return TRUE;
			}
			return FALSE;
		}

	COMPRESSED_METAL
		PREFIX = "a ";
		DISPLAY = "{DCompressed {WShiny {wMetal {DBoulder{x"
		SINGLE_DISPLAY = "{DCompressed {WShiny {wMetal {DBoulder{x"
		MULTI_DISPLAY = "{DCompressed {WShiny {wMetal {DBoulder{x"
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = FALSE;
		DROP_CHANCE = 5.0;
		ANNOUNCE_DROP = TRUE;
		PRICE = 1
		WEIGHT = 250.00;
		NO_MYSTERY = TRUE;

	DRAGON_RADAR
		PREFIX = "a ";
		DISPLAY = "{YDrag({x{R*{x{Y)nBall{x {RRadar{x"
		SINGLE_DISPLAY = "{YDrag({x{R*{x{Y)nBall{x {RRadar{x"
		MULTI_DISPLAY = "{YDrag({x{R*{x{Y)nBall{x {RRadar{x"
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = FALSE;
		DROP_CHANCE = 0.2;
		ANNOUNCE_DROP = TRUE;
		PRICE = 100000

		proc/closestDragonball(mob/m){
			var/list/DragonBallZ = list();

			if(m.getArea() == get_area("earth")){
				for(var/obj/item/DRAGONBALLS/d in m.getArea()){
					DragonBallZ.Add(d);
				}

				for(var/obj/item/DRAGONBALLS/d in m.contents){
					DragonBallZ.Remove(d);
				}
			}else{
				for(var/obj/item/NAMEK_DRAGONBALLS/d in m.getArea()){
					DragonBallZ.Add(d);
				}

				for(var/obj/item/NAMEK_DRAGONBALLS/d in m.contents){
					DragonBallZ.Remove(d);
				}
			}

			return distance_order(m,DragonBallZ);
		}

	SENZU_BEAN
		PREFIX = "a ";
		DISPLAY = "{ySenzu Bean{x"
		SINGLE_DISPLAY = "{ySenzu Bean{x"
		MULTI_DISPLAY = "{ySenzu Bean{x"
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = TRUE;
		DROP_CHANCE = 1.25;
		ANNOUNCE_DROP = TRUE;
		PRICE = 10000

		_eat(mob/m){
			if(..(m)){
				m.currpl = m.getMaxPL()
				m.curreng = m.getMaxEN()
				return TRUE;
			}
			return FALSE;
		}

	CANDY
		PREFIX = "a piece of ";
		DISPLAY = "{MCandy{x"
		SINGLE_DISPLAY = "{MCandy{x"
		MULTI_DISPLAY = "{MCandy{x"
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = TRUE;
		DROP_CHANCE = 8.00;
		ANNOUNCE_DROP = FALSE;
		MISC = TRUE;
		PRICE = 1250

		_eat(mob/m){
			if(..(m)){
				m._doDamage(ret_percent(30,m.getMaxPL()));
				m._doEnergy(30);
				return TRUE;
			}
			return FALSE;
		}

	GOLD_BAR
		DESC = "Looks valuable maybe we can sell it to a shop?"
		PREFIX = "a ";
		DISPLAY = "{YGold Bar{x"
		SINGLE_DISPLAY = "{YGold Bar{x"
		MULTI_DISPLAY = "{YGold Bar{x"
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = FALSE;
		DROP_CHANCE = 0.75;
		ANNOUNCE_DROP = TRUE;
		PRICE = 20000;
		STOCK_SHOP = FALSE;
		OR_PRICE = TRUE;

	SILVER_BAR
		DESC = "Looks valuable maybe we can sell it to a shop?"
		PREFIX = "a ";
		DISPLAY = "{wSilver Bar{x"
		SINGLE_DISPLAY = "{wSilver Bar{x"
		MULTI_DISPLAY = "{wSilver Bar{x"
		STACKABLE = TRUE;
		MULTI = TRUE;
		SLOT = NULL;
		EDIBLE = FALSE;
		DROP_CHANCE = 1.00;
		ANNOUNCE_DROP = TRUE;
		PRICE = 5000;
		STOCK_SHOP = FALSE;
		OR_PRICE = TRUE;

	/*KorinKami*/
	GARLIC_JR_CAPE
		EQUIPABLE = TRUE
		DISPLAY = "{cGarlic{x {GJr's{x {WC{x{Rap{x{We{x"
		MULTI = FALSE
		SLOT = SHOULDERS
		STACKABLE = TRUE
		EQ_MSG = "over"
		BONUS_KI = 72
		BONUS_STR = 23
		BONUS_ARM = 15
		BONUS_STA = 135
		BONUS_MF = 312
		WEIGHT = 1
		DROP_CHANCE = 0.50;
		ANNOUNCE_DROP = TRUE
		PRICE = 55000

	HORNED_HELMET
		EQUIPABLE = TRUE;
		DISPLAY = "{wHorned{x {yHelmet{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 145
		BONUS_STR = 21
		BONUS_ARM = 33
		BONUS_STA = 123
		BONUS_MF = 370
		WEIGHT = 14
		DROP_CHANCE = 2.50
		PRICE = 5000

	PINK_BRACERS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{MPink Bracers{x"
		SINGLE_DISPLAY = "{MPink Bracers{x"
		MULTI_DISPLAY = "{MPink Bracers{x"
		MULTI = TRUE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 71
		BONUS_STR = 22
		BONUS_ARM = 18
		BONUS_STA = 30
		BONUS_MF = 270
		WEIGHT = 0.1
		DROP_CHANCE = 5.50
		PRICE = 2500

	PURPLE_COLLAR
		EQUIPABLE = TRUE;
		DISPLAY = "{mPurple{x {DC{x{molla{x{Dr{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 70
		BONUS_STR = 24
		BONUS_ARM = 18
		BONUS_STA = 70
		BONUS_MF = 410
		WEIGHT = 0.1
		DROP_CHANCE = 0.50
		ANNOUNCE_DROP = TRUE
		PRICE = 55000

	PINK_BOOTS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{MPink Boo{x{Wts{x"
		SINGLE_DISPLAY = "{MPink Boo{x{Wts{x"
		MULTI_DISPLAY = "{MPink Boo{x{Wts{x"
		MULTI = TRUE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 42
		BONUS_STR = 18
		BONUS_ARM = 23
		BONUS_STA = 27
		BONUS_MF = 310
		WEIGHT = 0.1
		DROP_CHANCE = 5.50
		PRICE = 2500


	/* WISH GEAR */

	/*SHENRONS GEAR*/
	SHENRONS_DRAGON_EYE  //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {gD{xr{ga{xg{go{xn{x {GE{x{Ry{x{Ge{x"
		MULTI = FALSE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "in";
		BONUS_KI = 140
		BONUS_STR = 40
		BONUS_ARM = 20
		BONUS_STA = 170
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_ANTLERS  //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {yAntlers{x"
		MULTI = FALSE;
		SLOT = HEAD ;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 140
		BONUS_STR = 41
		BONUS_ARM = 21
		BONUS_STA = 110
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SCOUTER/SHENRONS_LENSES_OF_WISDOM
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {GL{x{Ce{Rns{x{Ce{x{Gs{x {cof{x {WW{x{Di{Csd{x{Do{x{Wm{x"
		MULTI = FALSE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 170
		BONUS_STR = 40
		BONUS_ARM = 20
		BONUS_STA = 170
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_HOOPS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {WH{x{Do{x{Wo{x{Dp{x{Ws{x"
		MULTI = FALSE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "in";
		BONUS_KI = 170
		BONUS_STR = 71
		BONUS_ARM = 40
		BONUS_STA = 140
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_SILVER_MANE //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {WS{xi{Wl{xv{We{xr {WM{xan{We{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_KI = 210
		BONUS_STR = 20
		BONUS_ARM = 30
		BONUS_STA = 210
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_FUR_MANTLE //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {WF{xu{Wr{x {WM{x{Ca{xnt{Cl{x{We{x"
		MULTI = FALSE;
		SLOT = SHOULDERS ;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_KI = 170
		BONUS_STR = 20
		BONUS_ARM = 50
		BONUS_STA = 110
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_GLOWING_INSIGNIA //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {WG{x{Cl{x{Wo{x{Cw{Wi{x{Cn{x{Wg{x {CI{x{mn{x{Cs{x{mi{x{Cg{x{mn{x{Ci{x{ma{x"
		MULTI = FALSE;
		SLOT = BACK ;
		STACKABLE = TRUE;
		EQ_MSG = "in";
		BONUS_KI = 170
		BONUS_STR = 51
		BONUS_ARM = 31
		BONUS_STA = 110
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_DRAGON_SCALE_KIMONO //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {gD{xr{ga{xg{go{xn {gS{xc{ga{xl{ge{x {WK{x{mi{x{Cmo{x{mn{Wo{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_KI = 170
		BONUS_STR = 53
		BONUS_ARM = 47
		BONUS_STA = 110
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_FLOWING_SASH //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {WF{x{Cl{x{Wo{x{Cw{x{Wi{x{Cn{x{Wg{x {CS{x{mas{x{Ch{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_KI = 110
		BONUS_STR = 48
		BONUS_ARM = 20
		BONUS_STA = 110
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_SKIN_TIGHT_SLEEVES //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {mS{x{Ck{x{mi{x{Cn{x Tight {mS{x{Cl{x{me{Ce{x{mv{x{Ce{x{ms{x"
		MULTI = FALSE;
		SLOT = ARMS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 140
		BONUS_STR = 45
		BONUS_ARM = 21
		BONUS_STA = 170
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_WOVEN_BANDS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {CW{x{mo{x{Cv{x{me{x{Cn{x {WB{x{ma{x{Cn{x{md{x{Ws{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_KI = 170
		BONUS_STR = 46
		BONUS_ARM = 20
		BONUS_STA = 170
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_CLOTH_HANDWRAPS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {WC{x{Dl{x{Co{x{Dt{x{Wh{x {CH{x{ma{x{Cn{x{md{x{Cw{x{mr{x{Ca{x{mp{x{Cs{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_KI = 210
		BONUS_STR = 44
		BONUS_ARM = 21
		BONUS_STA = 210
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_HAKAME_OF_VIRTUE //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {CH{x{ma{x{Ck{ma{x{Cm{x{me{x of {WV{x{Di{x{Crt{x{Du{x{We{x"
		MULTI = FALSE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 170
		BONUS_STR = 45
		BONUS_ARM = 21
		BONUS_STA = 210
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_CLOTH_KNEEWRAP//
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {WC{x{Dl{x{Co{x{Dt{x{Wh{x {CK{x{mn{x{Ce{x{me{x{Cw{x{mr{x{Ca{x{mp{x{Cs{x"
		MULTI = FALSE;
		SLOT = KNEES;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_KI = 170
		BONUS_STR = 45
		BONUS_ARM = 21
		BONUS_STA = 170
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE

	SHENRONS_CLOTH_FOOTWRAPS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GS{x{Ch{x{Ge{x{Cn{x{Gr{x{Co{x{Gn{x{C's{x {WC{x{Dl{x{Co{x{Dt{x{Wh{x {CF{x{mo{x{Co{x{mt{x{Cw{x{mr{x{Ca{x{mp{x{Cs{x"
		MULTI = FALSE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 140
		BONUS_STR = 41
		BONUS_ARM = 31
		BONUS_STA = 170
		BONUS_MF = 100
		WEIGHT = 0.1
		MISC = TRUE
		CAN_SELL = FALSE
	/*END SHENRONS GEAR*/
	/* PORUNGA GEAR*/
	PORUNGAS_DRAGON_EYE  //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {gD{xr{ga{xg{go{xn{x {GE{x{Ry{x{Ge{x"
		MULTI = FALSE;
		SLOT =SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "in";
		BONUS_KI = 240
		BONUS_STR = 65
		BONUS_ARM = 47
		BONUS_STA = 150
		BONUS_MF = 250
		WEIGHT = 3
		MISC = TRUE
		CAN_SELL = FALSE

	PORUNGAS_HORNS  //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {DH{x{Wo{x{Dr{x{Wn{x{Ds{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 140
		BONUS_KI = 220
		BONUS_STR = 65
		WEIGHT = 3
		BONUS_ARM = 35
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	SCOUTER/PORUNGAS_LENSES_OF_DEFIANCE
		EQUIPABLE = TRUE;
		PREFIX = "";
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {GL{x{Re{x{Yns{x{Re{x{Gs{x {cof{x {DDe{x{Bf{x{Wia{x{Bn{x{Dce{x"
		MULTI = FALSE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 170
		BONUS_KI = 240
		BONUS_STR = 65
		WEIGHT = 3
		BONUS_ARM = 35
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_GAUGES //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {gG{xa{Dug{xe{gs{x"
		MULTI = FALSE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "in";
		BONUS_STA = 150
		BONUS_KI = 230
		BONUS_STR = 110
		WEIGHT = 3
		BONUS_ARM = 55
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_DRAGON_BONE_BEVOR //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {gD{xr{ga{xg{go{xn {WB{x{yo{x{Wn{x{ye{x {DB{x{We{x{Dv{x{Wo{x{Dr{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 150
		BONUS_KI = 230
		BONUS_STR = 65
		WEIGHT = 3
		BONUS_ARM = 35
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_SPIKED_PAULDRONS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {DS{x{Wp{x{gik{x{We{x{Dd{x {DP{x{ra{x{Ru{x{rl{xd{rr{x{Ro{x{rn{x{Ds{x"
		MULTI = FALSE;
		SLOT = SHOULDERS ;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 170
		BONUS_KI = 220
		BONUS_STR = 67
		WEIGHT = 3
		BONUS_ARM = 38
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_DORSAL_FIN //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {gD{xo{gr{xs{ga{xl {yF{x{gi{x{yn{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 160
		BONUS_KI = 220
		BONUS_STR = 62
		WEIGHT = 3
		BONUS_ARM = 36
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_INDOMINABLE_CUIRASS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {DI{xn{rd{x{Ro{x{rm{xi{rn{x{Ra{x{rb{xl{De{x {DCu{xi{Wr{xa{Dss{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 150
		BONUS_KI = 230
		BONUS_STR = 60
		WEIGHT = 3
		BONUS_ARM = 31
		BONUS_MF = 500
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_DRAGON_BONE_FAULDS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {gD{xr{ga{xg{go{xn {WB{x{yo{x{Wn{x{ye{x {DF{x{Wa{xul{Wd{x{Ds{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 150
		BONUS_KI = 225
		BONUS_STR = 60
		WEIGHT = 3
		BONUS_ARM = 36
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_DRAGON_SCALE_VAMBRACES //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {gD{xr{ga{xg{go{xn {gS{xc{ga{xl{ge{x {DV{x{ra{x{Rm{x{rb{xr{ra{x{Rc{x{re{Ds{x"
		MULTI = FALSE;
		SLOT =ARMS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 140
		BONUS_KI = 210
		BONUS_STR = 61
		WEIGHT = 3
		BONUS_ARM = 37
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_PADDED_WRISTGUARDS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {WP{x{ya{xdd{ye{x{Wd{x {DW{xr{ri{x{Rs{x{rt{x{Wg{x{ru{x{Ra{x{rr{x{xd{Ds{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_STA = 160
		BONUS_KI = 220
		BONUS_STR = 62
		WEIGHT = 3
		BONUS_ARM = 39
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_HARDENED_GAUNTLETS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {bH{x{Ba{x{Dr{xde{Dn{x{Be{x{bd{x {DG{x{ra{x{Ru{x{rn{xt{rl{x{Re{x{rt{x{Ds{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 150
		BONUS_KI = 220
		BONUS_STR = 62
		WEIGHT = 3
		BONUS_ARM = 37
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_DRAGON_SCALE_CHAUSSES //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {gD{xr{ga{xg{go{xn {gS{xc{ga{xl{ge{x {DC{x{rh{x{Ra{xus{Rs{x{re{x{Ds{x"
		MULTI = FALSE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 170
		BONUS_KI = 240
		BONUS_STR = 50
		WEIGHT = 3
		BONUS_ARM = 38
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_JOINTED_BRACE //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {DJ{x{Ro{x{ri{xn{rt{x{Re{x{Dd{x {WB{x{Dr{xa{Dc{x{We{x"
		MULTI = FALSE;
		SLOT = KNEES;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 170
		BONUS_KI = 230
		BONUS_STR = 60
		WEIGHT = 3
		BONUS_ARM = 35
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE

	PORUNGAS_TEMPERED_SABATONS //
		EQUIPABLE = TRUE;
		DISPLAY = "{GP{x{go{x{Rr{x{Yun{x{Rg{x{ga{x{G's{x {bT{x{Be{x{Dm{xpe{Dr{x{Be{x{bd{x {DS{x{ra{x{Rb{x{Wat{x{Ro{x{rn{x{Ds{x"
		MULTI = FALSE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 190
		BONUS_KI = 220
		BONUS_STR = 65
		WEIGHT = 3
		BONUS_ARM = 37
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE
	/*END PORUNGA GEAR*/

	BLACK_STAR_DRAGONS_EYE //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {gD{xr{ga{xg{xo{gn{x {WE{x{Dy{x{We{x"
		MULTI = FALSE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "in";
		BONUS_STA = 270
		BONUS_KI = 300
		BONUS_STR = 70
		WEIGHT = 1
		BONUS_ARM = 40
		BONUS_MF = 500
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_CROWN  //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {DC{x{br{x{Bo{x{bw{x{Dn{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 270
		BONUS_KI = 300
		BONUS_STR = 70
		WEIGHT = 1
		BONUS_ARM = 40
		BONUS_MF = 1100
		MISC = TRUE;
		CAN_SELL = FALSE

	SCOUTER/BLACK_STAR_LENSES_OF_MALICE //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {DL{x{be{x{rns{x{be{x{Ds{x {cof{x {DM{x{Wa{rli{x{Wc{x{De{x"
		MULTI = FALSE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 210
		BONUS_KI = 300
		BONUS_STR = 50
		WEIGHT = 1
		BONUS_ARM = 40
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE
		SCOUTER_LEVEL = 2

	BLACK_STAR_CHAINS //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {WC{x{Dh{x{bai{x{Dn{x{Ws{x"
		MULTI = FALSE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "in";
		BONUS_STA = 170
		BONUS_KI = 350
		BONUS_STR = 70
		WEIGHT = 2
		BONUS_ARM = 45
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_DRAGON_CLAWS //
		EQUIPABLE = TRUE;
		PREFIX = "some ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {gD{xr{ga{xg{go{xn{x {DC{x{rl{x{ba{x{rw{x{Ds{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "around ";
		BONUS_STA = 200
		BONUS_KI = 300
		BONUS_STR = 60
		WEIGHT = 1
		BONUS_ARM = 45
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_SHROUD_OF_SHADOW //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {WS{x{Dh{x{rro{x{Du{x{Wd{x of {DS{x{Wh{xad{Wo{x{Dw{x"
		MULTI = FALSE;
		SLOT = SHOULDERS ;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_STA = 200
		BONUS_KI = 300
		BONUS_STR = 70
		WEIGHT = 1
		BONUS_ARM = 55
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_INSIGNIA //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {gD{xr{ga{xg{D({x{b*{x{D){x{gn{x {DEm{x{bbl{x{Dem{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 200
		BONUS_KI = 340
		BONUS_STR = 70
		WEIGHT = 0.1
		BONUS_ARM = 45
		BONUS_MF = 1100
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_LEATHER_HIDE//
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {DL{x{be{x{ya{x{rt{x{yh{x{be{x{Dr{x {DHide{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 170
		BONUS_KI = 370
		BONUS_STR = 50
		WEIGHT = 1
		BONUS_ARM = 42
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_CHAIN_CYNCH //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {WC{x{Dh{x{ba{x{Di{x{Wn{x {DC{xy{rn{xc{Dh{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_STA = 230
		BONUS_KI = 310
		BONUS_STR = 70
		WEIGHT = 2
		BONUS_ARM = 45
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_TRIBAL_TATTOOS //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {DTr{x{bib{x{Dal{x {DTa{x{rtt{x{Doo{x{x{rs{x"
		MULTI = FALSE;
		SLOT = ARMS;
		STACKABLE = TRUE;
		EQ_MSG = "in";
		BONUS_STA = 250
		BONUS_KI = 300
		BONUS_STR = 70
		WEIGHT = 2
		BONUS_ARM = 45
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_CHAIN_BRACELET //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {WC{x{Dh{x{ba{x{Di{x{Wn{x {DB{x{rr{x{Wa{x{Dce{x{Wl{x{re{x{Dt{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "around";
		BONUS_STA = 170
		BONUS_KI = 310
		BONUS_STR = 70
		WEIGHT = 1
		BONUS_ARM = 45
		BONUS_MF = 1100
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_OBSIDIAN_KNUCKLES //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {DO{x{bb{x{Bs{Did{x{Bi{x{ba{x{Dn{x {DK{x{rn{xu{rck{xl{re{x{Ds{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 250
		BONUS_KI = 370
		BONUS_STR = 70
		WEIGHT = 1.5
		BONUS_ARM = 45
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_HAKAME_OF_HATE //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {DH{x{ba{x{Dka{x{bm{x{De{x of {DH{x{ra{x{Dt{x{re{x"
		MULTI = FALSE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 310
		BONUS_KI = 70
		BONUS_STR = 60
		WEIGHT = 1.5
		BONUS_ARM = 40
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_LEATHER_BRACE //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {DL{x{be{x{ya{x{rt{x{yh{x{be{x{Dr{x {DBr{x{ra{x{Dce{x"
		MULTI = FALSE;
		SLOT = KNEES;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 200
		BONUS_KI = 370
		BONUS_STR = 70
		WEIGHT = 1.5
		BONUS_ARM = 40
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	BLACK_STAR_LEATHER_BOOTS //
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DBl{x{ba{x{Dck{x {WS{x{Dta{x{Wr{x {DL{x{be{x{ya{x{rt{x{yh{x{be{x{Dr{x {DB{ro{xo{x{rt{x{Ds{x"
		MULTI = FALSE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 200
		BONUS_KI = 355
		BONUS_STR = 50
		WEIGHT = 1.5
		BONUS_ARM = 40
		BONUS_MF = 0
		MISC = TRUE;
		CAN_SELL = FALSE

	GOKUS_ORANGE_GI //
		EQUIPABLE = TRUE;
		DISPLAY = "{cGoku's{x {oOrange{x {BGi{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 100
		BONUS_KI = 150
		BONUS_STR = 65
		WEIGHT = 0.1;
		BONUS_ARM = 35
		BONUS_MF = 250
		MISC = TRUE;
		CAN_SELL = FALSE
		PRICE = 500

	GOKUS_BLUE_GI //
		EQUIPABLE = TRUE;
		DISPLAY = "{cGoku's{x {BBlue{x {BGi{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 200
		BONUS_KI = 450
		BONUS_STR = 90
		WEIGHT = 0.2;
		BONUS_ARM = 55
		BONUS_MF = 800
		MISC = TRUE;
		CAN_SELL = FALSE
		NO_MYSTERY = TRUE;
		PRICE = 500

	ZAMASUS_TIME_RING
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{WZamasu's{x {WTime{x {YRing{x"
		SINGLE_DISPLAY = "{WZamasu's{x {WTime{x {YRing{x"
		MULTI_DISPLAY = "{WZamasu's{x {WTime{x {YRing{x"
		MULTI = TRUE;
		SLOT = FINGERS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_KI = 500
		BONUS_STR = 200
		BONUS_ARM = 180
		BONUS_STA = 100
		BONUS_MF = 1000
		WEIGHT = 0.1
		DROP_CHANCE = 20.00;
		NO_MYSTERY = TRUE;
		PRICE = 500000
		ANNOUNCE_DROP = TRUE

	SCOUTER/GOLDEN_SCOUTER
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{YGolden Scouter{x"
		SINGLE_DISPLAY = "{YGolden Scouter{x"
		MULTI_DISPLAY = "{YGolden Scouter{x"
		MULTI = TRUE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 800
		BONUS_STR = 300
		BONUS_ARM = 300
		BONUS_STA = 200
		BONUS_MF = 1250
		WEIGHT = 2.0
		DROP_CHANCE = 10.00
		PRICE = 300000
		ANNOUNCE_DROP = TRUE
		NO_MYSTERY = TRUE

	NEO_TECH_BLINDFOLD
		EQUIPABLE = TRUE;
		PREFIX = "a ";
		DISPLAY = "{cNeo{C-{cTech {WBli{wndf{Dold{x"
		SINGLE_DISPLAY = "{cNeo{C-{cTech {WBli{wndf{Dold{x"
		MULTI_DISPLAY = "{cNeo{C-{cTech {WBli{wndf{Dold{x"
		MULTI = TRUE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 600
		BONUS_STR = 250
		BONUS_ARM = 250
		BONUS_STA = 250
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 0.1
		PRICE = 500000
		ANNOUNCE_DROP = TRUE
		NO_MYSTERY = TRUE;

	JIRENS_GLOVES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{bJiren's{x {DGloves{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 450
		BONUS_STR = 175
		BONUS_ARM = 115
		BONUS_STA = 150
		BONUS_MF = 500
		WEIGHT = 0.5
		DROP_CHANCE = 1.00
		ANNOUNCE_DROP = TRUE

		NO_MYSTERY = TRUE;
		PRICE = 350000

	JIRENS_BOOTS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{bJiren's{x {DBoots{x"
		MULTI = FALSE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "over"
		BONUS_KI = 450
		BONUS_STR = 135
		BONUS_ARM = 115
		BONUS_STA = 80
		BONUS_MF = 850
		WEIGHT = 0.5
		DROP_CHANCE = 1.00
		ANNOUNCE_DROP = TRUE
		NO_MYSTERY = TRUE;
		PRICE = 350000

	SHADOW_EARRINGS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DShadow{x {REarrings{x"
		SINGLE_DISPLAY = "{DShadow{x {REarring{x"
		MULTI_DISPLAY = "{DShadow{x {REarring{x"
		MULTI = TRUE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 600
		BONUS_STR = 200
		BONUS_ARM = 95
		BONUS_STA = 130
		BONUS_MF = 120
		WEIGHT = 0.1
		DROP_CHANCE = 0.3
		ANNOUNCE_DROP = TRUE
		PRICE = 350000
		NO_MYSTERY = TRUE;


	SHADOW_GLOVES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DShadow{x {WGloves{x"
		SINGLE_DISPLAY = "{DShadow{x {WGloves{x"
		MULTI_DISPLAY = "{DShadow{x {WGloves{x"
		MULTI = TRUE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 400
		BONUS_STR = 120
		BONUS_ARM = 115
		BONUS_STA = 100
		BONUS_MF = 190
		WEIGHT = 0.1
		DROP_CHANCE = 0.3
		ANNOUNCE_DROP = TRUE
		PRICE = 200000
		NO_MYSTERY = TRUE;


	SHADOW_PAULDRONS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{DShadow{x {DPauldrons{x"
		SINGLE_DISPLAY = "{DShadow{x {DPauldrons{x"
		MULTI_DISPLAY = "{DShadow{x {DPauldrons{x"
		MULTI = TRUE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 700
		BONUS_STR = 320
		BONUS_ARM = 315
		BONUS_STA = 150
		BONUS_MF = 3190
		WEIGHT = 0.1
		DROP_CHANCE = 0.1
		ANNOUNCE_DROP = TRUE
		PRICE = 300000
		NO_MYSTERY = TRUE;

	FEARS_PAULDRONS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{WF{x{Re{x{Wars{x {DPauldrons{x"
		SINGLE_DISPLAY = "{WF{x{Re{x{Wars{x {DPauldrons{x"
		MULTI_DISPLAY = "{WF{x{Re{x{Wars{x {DPauldrons{x"
		MULTI = TRUE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 600
		BONUS_STR = 270
		BONUS_ARM = 215
		BONUS_STA = 150
		BONUS_MF = 1190
		WEIGHT = 0.1
		DROP_CHANCE = 0.3
		ANNOUNCE_DROP = TRUE
		PRICE = 400000
		MISC = TRUE;
		STOCK_SHOP = FALSE

	SAIYAN_POWER_KNEE_PADS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{cSaiyan{x {RPOWER{x {WKnee-pads{x"
		SINGLE_DISPLAY = "{cSaiyan{x {RPOWER{x {WKnee-pads{x"
		MULTI_DISPLAY = "{cSaiyan{x {RPOWER{x {WKnee-pads{x"
		MULTI = TRUE;
		SLOT = KNEES;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 600
		BONUS_STR = 200
		BONUS_ARM = 145
		BONUS_STA = 120
		BONUS_MF = 560
		WEIGHT = 0.1
		DROP_CHANCE = 0.3
		ANNOUNCE_DROP = TRUE
		PRICE = 350000
		NO_MYSTERY = TRUE;

	SAIYAN_POWER_CAPE
		EQUIPABLE = TRUE;
		DISPLAY = "{cSaiyan{x {RPOWER{x {WCape{x"
		SINGLE_DISPLAY = "{cSaiyan{x {RPOWER{x {WCape{x"
		MULTI_DISPLAY = "{cSaiyan{x {RPOWER{x {WCape{x"
		MULTI = TRUE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 800
		BONUS_STR = 300
		BONUS_ARM = 165
		BONUS_STA = 220
		BONUS_MF = 860
		WEIGHT = 0.1
		DROP_CHANCE = 0.3
		ANNOUNCE_DROP = TRUE
		PRICE = 350000
		NO_MYSTERY = TRUE;

	EVENT_WINNER_HAT
		EQUIPABLE = TRUE;
		PREFIX = "an ";
		DISPLAY = "{GEvent{x {YWinner{x {RHat{x"
		SINGLE_DISPLAY = "{GEvent{x {YWinner{x {RHat{x"
		MULTI_DISPLAY = "{GEvent{x {YWinner{x {RHat{x"
		MULTI = TRUE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 500
		BONUS_STR = 130
		BONUS_ARM = 145
		BONUS_STA = 150
		BONUS_MF = 1190
		WEIGHT = 0.1
		DROP_CHANCE = 0;
		ANNOUNCE_DROP = FALSE;
		MISC = TRUE;
		PRICE = 350000
		STOCK_SHOP = FALSE
	SHADOW_BARRIER
		EQUIPABLE = TRUE;
		PREFIX = "an ";
		DISPLAY = "{DShadow{x {mBarrier{x"
		SINGLE_DISPLAY = "{DShadow{x {mBarrier{x"
		MULTI_DISPLAY = "{DShadow{x {mBarrier{x"
		MULTI = TRUE;
		SLOT = BODY;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 800
		BONUS_STR = 400
		BONUS_ARM = 400
		BONUS_STA = 250
		BONUS_MF = 300
		WEIGHT = 0.00
		DROP_CHANCE = 0.1;
		ANNOUNCE_DROP = TRUE;
		PRICE = 100000
	BASIC_SPACESUIT
		EQUIPABLE = TRUE;
		PREFIX = "an ";
		DISPLAY = "{WLow quality Spacesuit{x"
		SINGLE_DISPLAY = "{WLow quality Spacesuit{x"
		MULTI_DISPLAY = "{WLow quality Spacesuit{x"
		MULTI = TRUE;
		SLOT = BODY;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 0
		BONUS_STR = 0
		BONUS_ARM = 0
		BONUS_STA = 0
		BONUS_MF = 0
		WEIGHT = 50.00
		DROP_CHANCE = 0;
		ANNOUNCE_DROP = FALSE;
		PRICE = 100000
	SHROUD_OF_WITHERING
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{WShr{wou{Dd of {DWi{wth{Wer{win{Dg{x"
		SINGLE_DISPLAY = "{WShr{wou{Dd of {DWi{wth{Wer{win{Dg{x"
		MULTI_DISPLAY = "{WShr{wou{Dd of {DWi{wth{Wer{win{Dg{x"
		MULTI = TRUE;
		SLOT = BODY;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI =  200
		BONUS_STR = 200
		BONUS_ARM = 200
		BONUS_STA = 200
		BONUS_MF = 500
		WEIGHT = 50.00
		DROP_CHANCE = 0.4;
		ANNOUNCE_DROP = TRUE;
		NO_MYSTERY = TRUE;
		PRICE = 300000
	CORRUPTED_SIGIL
		EQUIPABLE = TRUE;
		PREFIX = "the ";
		DISPLAY = "{DCo{wrr{Wup{wte{Dd {RSigil{x"
		SINGLE_DISPLAY = "{DCo{wrr{Wup{wte{Dd {RSigil{x"
		MULTI_DISPLAY = "{DCo{wrr{Wup{wte{Dd {RSigil{x"
		MULTI = TRUE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI =  300
		BONUS_STR = 100
		BONUS_ARM = 100
		BONUS_STA = 300
		BONUS_MF = 500
		WEIGHT = 1.00
		DROP_CHANCE = 0.4;
		ANNOUNCE_DROP = TRUE;
		NO_MYSTERY = TRUE;
		PRICE = 400000

	DR_MYUU_INSIGNIA
		EQUIPABLE = TRUE;
		DISPLAY = "{cDr. {WMyuu's {WIn{wsi{Cgn{cia{x"
		SINGLE_DISPLAY = "{cDr. {WMyuu's {WIn{wsi{Cgn{cia{x"
		MULTI_DISPLAY = "{cDr. {WMyuu's {WIn{wsi{Cgn{cia{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 250
		BONUS_KI = 400
		BONUS_STR = 150
		BONUS_ARM = 150
		BONUS_MF = 500
		WEIGHT = 5.00
		DROP_CHANCE = 0.4;
		ANNOUNCE_DROP = TRUE;
		NO_MYSTERY = TRUE;
		PRICE = 500000


	LEVIATHAN_LEGGINGS
		EQUIPABLE = TRUE;
		DISPLAY = "{WLeg{wgin{Dgs {xof the {CLev{cia{Bth{ban{x"
		SINGLE_DISPLAY = "{WLeg{wgin{Dgs {xof the {CLev{cia{Bth{ban{x"
		MULTI_DISPLAY = "{WLeg{wgin{Dgs {xof the {CLev{cia{Bth{ban{x"
		MULTI = FALSE;
		SLOT = LEGS;
		STACKABLE = TRUE;
		EQ_MSG = "on";
		BONUS_STA = 200
		BONUS_KI = 250
		BONUS_STR = 150
		BONUS_ARM = 150
		BONUS_MF = 400
		WEIGHT = 15.00
		DROP_CHANCE = 0.6;
		ANNOUNCE_DROP = TRUE;
		NO_MYSTERY = TRUE;
		PRICE = 300000

	ANDROID_PART
		ANDROID_ARM
			DISPLAY = "{rripped-off{x android arm"
			SINGLE_DISPLAY = "{rripped-off{x android arm"
			MULTI_DISPLAY = "{rripped-off{x android arms"
			CAN_PICKUP = TRUE
			DECAY = TRUE
			MISC = TRUE
			CONTAINER = FALSE
			SHOW_ITEMDB = TRUE
			PRICE = 30000
			WEIGHT = 2
			STACKABLE = TRUE
			MULTI = TRUE
			DROP_CHANCE = 5

		ANDROID_LEG
			DISPLAY = "{rbroken{x android leg"
			SINGLE_DISPLAY = "{rbroken{x android leg"
			MULTI_DISPLAY = "{rbroken{x android legs"
			CAN_PICKUP = TRUE
			DECAY = TRUE
			MISC = TRUE
			CONTAINER = FALSE
			SHOW_ITEMDB = TRUE
			PRICE = 30000
			WEIGHT = 3
			STACKABLE = TRUE
			MULTI = TRUE
			DROP_CHANCE = 5

		ANDROID_EYE
			DISPLAY = "{rcracked{x android eye"
			SINGLE_DISPLAY = "{rcracked{x android eye"
			MULTI_DISPLAY = "{rcracked{x android eyes"
			CAN_PICKUP = TRUE
			DECAY = TRUE
			MISC = TRUE
			CONTAINER = FALSE
			SHOW_ITEMDB = TRUE
			PRICE = 30000
			WEIGHT = 2
			STACKABLE = TRUE
			MULTI = TRUE
			DROP_CHANCE = 5

		ANDROID_SERVO
			DISPLAY = "{rburnt{x android servo motor"
			SINGLE_DISPLAY = "{rburnt{x android servo motor"
			MULTI_DISPLAY = "{rburnt{x android servo motors"
			CAN_PICKUP = TRUE
			DECAY = TRUE
			MISC = TRUE
			CONTAINER = FALSE
			SHOW_ITEMDB = TRUE
			PRICE = 30000
			WEIGHT = 2
			STACKABLE = TRUE
			MULTI = TRUE
			DROP_CHANCE = 5

		ANDROID_ACTUATOR
			DISPLAY = "{oflaming{x actuator"
			SINGLE_DISPLAY = "{oflaming{x actuator"
			MULTI_DISPLAY = "{oFlaming{x actuators"
			CAN_PICKUP = TRUE
			DECAY = TRUE
			MISC = TRUE
			CONTAINER = FALSE
			SHOW_ITEMDB = TRUE
			PRICE = 30000
			WEIGHT = 2
			STACKABLE = TRUE
			MULTI = TRUE
			DROP_CHANCE = 5
/* Dragon Ball Z/Super Themed Items - Missing Definitions */

	TIENS_THIRD_EYE_HEADBAND
		EQUIPABLE = TRUE;
		DISPLAY = "{yTien's{x {YThird{x {RE{x{gy{x{Re{x {YH{x{re{x{Ya{x{rd{x{Yb{x{ra{x{Yn{x{rd{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 35
		BONUS_STR = 20
		BONUS_ARM = 15
		BONUS_STA = 20
		BONUS_MF = 150
		WEIGHT = 0.1
		DROP_CHANCE = 2.00
		PRICE = 4500

	YAMCHAS_WOLF_FANG_GAUNTLETS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{yYamcha's{x {YWolf{x {CFang{x {DGauntlets{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 30
		BONUS_STR = 25
		BONUS_ARM = 15
		BONUS_STA = 15
		BONUS_MF = 0
		WEIGHT = 0.8
		DROP_CHANCE = 2.50
		PRICE = 3500

	ANDROID_16S_BIRD_LOVING_INSIGNIA
		EQUIPABLE = TRUE;
		DISPLAY = "{DAndroid{x {c16's{x {gBird{x {CLo{x{gvi{x{Cn{x{gg{x {DI{x{cn{x{Ds{x{ci{x{Dg{x{cn{x{Di{x{ca{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 40
		BONUS_STR = 15
		BONUS_ARM = 20
		BONUS_STA = 25
		BONUS_MF = 200
		WEIGHT = 0.1
		DROP_CHANCE = 2.00
		PRICE = 5000

	CELLS_PERFECT_FORM_EXOSKELETON
		EQUIPABLE = TRUE;
		DISPLAY = "{GCell's{x {mPerfect{x {GF{x{mo{x{Gr{x{mm{x {GE{x{mx{x{Go{x{ms{x{Gk{x{me{x{Gl{x{me{x{Gt{x{mo{x{Gn{x"
		MULTI = FALSE;
		SLOT = BODY;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 120
		BONUS_STR = 45
		BONUS_ARM = 65
		BONUS_STA = 50
		BONUS_MF = 0
		WEIGHT = 2.5
		DROP_CHANCE = 1.50
		PRICE = 15000

	VEGITO_POTARA_FUSION_BOOTS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{cVegito's{x {YPotara{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {yBoots{x"
		MULTI = FALSE;
		SLOT = FEET;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 300
		BONUS_STR = 65
		BONUS_ARM = 45
		BONUS_STA = 85
		BONUS_MF = 0
		WEIGHT = 0.5
		DROP_CHANCE = 0.50
		ANNOUNCE_DROP = TRUE
		PRICE = 75000

	BEERUS_DESTRUCTOR_EARRINGS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{mBeerus'{x {RDestructor{x {YEarrings{x"
		MULTI = FALSE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 450
		BONUS_STR = 80
		BONUS_ARM = 60
		BONUS_STA = 120
		BONUS_MF = 750
		WEIGHT = 0.1
		DROP_CHANCE = 0.10
		ANNOUNCE_DROP = TRUE
		PRICE = 150000

	ULTRA_INSTINCT_AURA_CLOAK
		EQUIPABLE = TRUE;
		DISPLAY = "{WUltra{x {CInstinct{x {WAura{x {wCloak{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 500
		BONUS_STR = 75
		BONUS_ARM = 85
		BONUS_STA = 150
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 0.10
		ANNOUNCE_DROP = TRUE
		PRICE = 200000

	WHIS_ANGEL_STAFF_REPLICA
		EQUIPABLE = TRUE;
		DISPLAY = "{CWhis'{x {WAngel{x {CStaff{x {WReplica{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 480
		BONUS_STR = 90
		BONUS_ARM = 70
		BONUS_STA = 100
		BONUS_MF = 800
		WEIGHT = 2.0
		DROP_CHANCE = 0.05
		ANNOUNCE_DROP = TRUE
		PRICE = 250000

	VADOS_ANGEL_RING
		EQUIPABLE = TRUE;
		DISPLAY = "{CVados'{x {WAngel{x {YRing{x"
		MULTI = FALSE;
		SLOT = FINGERS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 500
		BONUS_STR = 85
		BONUS_ARM = 75
		BONUS_STA = 90
		BONUS_MF = 900
		WEIGHT = 0.1
		DROP_CHANCE = 0.05
		ANNOUNCE_DROP = TRUE
		PRICE = 300000

	GRAND_PRIEST_DIVINE_ROBES
		EQUIPABLE = TRUE;
		DISPLAY = "{WGrand{x {CPriest's{x {YDivine{x {WRobes{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 550
		BONUS_STR = 100
		BONUS_ARM = 120
		BONUS_STA = 180
		BONUS_MF = 1000
		WEIGHT = 0.5
		DROP_CHANCE = 0.01
		ANNOUNCE_DROP = TRUE
		PRICE = 500000

	HIT_TIME_SKIP_GAUNTLETS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{mHit's{x {WTime{x {YSkip{x {DGauntlets{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 220
		BONUS_STR = 80
		BONUS_ARM = 55
		BONUS_STA = 95
		BONUS_MF = 300
		WEIGHT = 1.2
		DROP_CHANCE = 0.25
		ANNOUNCE_DROP = TRUE
		PRICE = 80000

	FRIEZAS_BATTLE_ARMOR_FRAGMENTS
		EQUIPABLE = TRUE;
		DISPLAY = "{WFrieza's{x {gBattle{x {YArmor{x {DFragments{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 280
		BONUS_STR = 70
		BONUS_ARM = 90
		BONUS_STA = 65
		BONUS_MF = 0
		WEIGHT = 1.5
		DROP_CHANCE = 0.75
		PRICE = 45000

	SUPREME_KAIS_POTARA_EARRINGS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{YSupreme{x {CKai's{x {YPotara{x {YEarrings{x"
		MULTI = FALSE;
		SLOT = EARS;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 480
		BONUS_STR = 85
		BONUS_ARM = 70
		BONUS_STA = 130
		BONUS_MF = 850
		WEIGHT = 0.1
		DROP_CHANCE = 0.10
		ANNOUNCE_DROP = TRUE
		PRICE = 200000

	KING_KAIS_ANTENNA_HEADBAND
		EQUIPABLE = TRUE;
		DISPLAY = "{CKing{x {CKai's{x {CAntenna{x {yHeadband{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 55
		BONUS_STR = 25
		BONUS_ARM = 30
		BONUS_STA = 30
		BONUS_MF = 200
		WEIGHT = 0.1
		DROP_CHANCE = 3.00
		PRICE = 6000

	NAMEKIAN_ELDER_ROBES
		EQUIPABLE = TRUE;
		DISPLAY = "{gNamekian{x {YElder{x {WRobes{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 35
		BONUS_STR = 15
		BONUS_ARM = 20
		BONUS_STA = 30
		BONUS_MF = 100
		WEIGHT = 0.8
		DROP_CHANCE = 4.00
		PRICE = 3500

	KRILLINS_DESTRUCTO_DISC_BRACERS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{yKrillin's{x {YDestructo{x {CDisc{x {DBracers{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 30
		BONUS_STR = 20
		BONUS_ARM = 15
		BONUS_STA = 10
		BONUS_MF = 0
		WEIGHT = 0.5
		DROP_CHANCE = 5.00
		PRICE = 2500

	DENDE_HEALING_STAFF
		EQUIPABLE = TRUE;
		DISPLAY = "{gDende's{x {gHealing{x {YStaff{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 25
		BONUS_STR = 5
		BONUS_ARM = 15
		BONUS_STA = 25
		BONUS_MF = 150
		WEIGHT = 1.0
		DROP_CHANCE = 8.00
		PRICE = 3000

	PICCOLOS_WEIGHTED_TRAINING_GI
		EQUIPABLE = TRUE;
		DISPLAY = "{gPiccolo's{x {DWeighted{x {gTraining{x {yGi{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 65
		BONUS_STR = 40
		BONUS_ARM = 30
		BONUS_STA = 25
		BONUS_MF = 0
		WEIGHT = 15.0
		DROP_CHANCE = 1.00
		PRICE = 8000

	VEGETAS_SAIYAN_PRIDE_ARMOR
		EQUIPABLE = TRUE;
		DISPLAY = "{cVegeta's{x {cSaiyan{x {RPride{x {YArmor{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 35
		BONUS_STR = 20
		BONUS_ARM = 25
		BONUS_STA = 15
		BONUS_MF = 0
		WEIGHT = 2.0
		DROP_CHANCE = 6.00
		PRICE = 3500

	SAIYAN_TAIL_BELT
		EQUIPABLE = TRUE;
		DISPLAY = "{cSaiyan{x {yTail{x {yBelt{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 60
		BONUS_STR = 20
		BONUS_ARM = 10
		BONUS_STA = 25
		BONUS_MF = 100
		WEIGHT = 0.3
		DROP_CHANCE = 8.00
		PRICE = 3000

	SUPER_SAIYAN_4_WRISTBANDS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{RSuper{x {cSaiyan{x {R4{x {DWristbands{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 380
		BONUS_STR = 85
		BONUS_ARM = 55
		BONUS_STA = 90
		BONUS_MF = 0
		WEIGHT = 0.5
		DROP_CHANCE = 0.20
		ANNOUNCE_DROP = TRUE
		PRICE = 120000

	BARDOCKS_BATTLE_WORN_HEADBAND
		EQUIPABLE = TRUE;
		DISPLAY = "{cBardock's{x {RBattle{x {DWorn{x {RHeadband{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 350
		BONUS_STR = 75
		BONUS_ARM = 45
		BONUS_STA = 80
		BONUS_MF = 600
		WEIGHT = 0.2
		DROP_CHANCE = 0.30
		ANNOUNCE_DROP = TRUE
		PRICE = 100000
/* Missing Dragon Ball Items - Classic DB/Z */

	NAPPAS_BATTLE_GAUNTLETS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{cNappa's{x {gBattle{x {DGauntlets{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 55 // MEDIUM tier (Nappa)
		BONUS_STR = 35
		BONUS_ARM = 25
		BONUS_STA = 30
		BONUS_MF = 0
		WEIGHT = 1.2
		DROP_CHANCE = 3.00
		PRICE = 6000

	SCOUTER/RADITZS_SCOUTER_HEADPIECE
		EQUIPABLE = TRUE;
		DISPLAY = "{cRaditz's{x {gScouter{x {yHeadpiece{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 25 // EASY tier (Raditz)
		BONUS_STR = 15
		BONUS_ARM = 12
		BONUS_STA = 18
		BONUS_MF = 250
		WEIGHT = 0.5
		DROP_CHANCE = 4.00
		PRICE = 2500

	TURTLE_HERMIT_SHELL
		EQUIPABLE = TRUE;
		DISPLAY = "{gTurtle{x {cHermit{x {yShell{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 40 // MEDIUM tier (Master Roshi)
		BONUS_STR = 15
		BONUS_ARM = 30
		BONUS_STA = 25
		BONUS_MF = 150
		WEIGHT = 8.0
		DROP_CHANCE = 6.00
		PRICE = 4500

	CAPTAIN_GINYUS_BODY_CHANGING_MEDALLION
		EQUIPABLE = TRUE;
		DISPLAY = "{mCaptain{x {mGinyu's{x {YBody{x {CChanging{x {YMedallion{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 85 // HARD tier (Ginyu Force)
		BONUS_STR = 50
		BONUS_ARM = 35
		BONUS_STA = 45
		BONUS_MF = 200
		WEIGHT = 0.3
		DROP_CHANCE = 1.50
		PRICE = 12000

	GOHAN_SCHOLAR_SPECTACLES
		EQUIPABLE = TRUE;
		DISPLAY = "{yGohan's{x {CScholar{x {WSpectacles{x"
		MULTI = FALSE;
		SLOT = EYE;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 50 // MEDIUM tier (Gohan on Namek)
		BONUS_STR = 20
		BONUS_ARM = 15
		BONUS_STA = 25
		BONUS_MF = 300
		WEIGHT = 0.1
		DROP_CHANCE = 4.00
		PRICE = 5500

	BULMAS_CAPSULE_CORP_JACKET
		EQUIPABLE = TRUE;
		DISPLAY = "{CBulma's{x {YCapsule{x {WCorp{x {CJacket{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 20 // VERY_EASY tier (civilian item)
		BONUS_STR = 8
		BONUS_ARM = 12
		BONUS_STA = 25
		BONUS_MF = 200
		WEIGHT = 0.8
		DROP_CHANCE = 8.00
		PRICE = 1500

	CHAIOTZU_EMPEROR_HAT
		EQUIPABLE = TRUE;
		DISPLAY = "{WChiaotzu's{x {YEmperor{x {yHat{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 45 // MEDIUM tier (Chiaotzu)
		BONUS_STR = 20
		BONUS_ARM = 15
		BONUS_STA = 25
		BONUS_MF = 180
		WEIGHT = 0.3
		DROP_CHANCE = 4.50
		PRICE = 4200

	VIDELS_FIGHTING_GLOVES
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{cVidel's{x {RFighting{x {DGloves{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 30 // EASY tier (Videl)
		BONUS_STR = 20
		BONUS_ARM = 10
		BONUS_STA = 15
		BONUS_MF = 0
		WEIGHT = 0.5
		DROP_CHANCE = 5.00
		PRICE = 2800

	GREAT_SAIYAMANS_CAPE
		EQUIPABLE = TRUE;
		DISPLAY = "{WGreat{x {cSaiyaman's{x {gCape{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 60 // MEDIUM tier (Gohan as Great Saiyaman)
		BONUS_STR = 30
		BONUS_ARM = 20
		BONUS_STA = 35
		BONUS_MF = 150
		WEIGHT = 1.0
		DROP_CHANCE = 3.00
		PRICE = 6500

	BABIDIS_MAJIN_EMBLEM
		EQUIPABLE = TRUE;
		DISPLAY = "{mBabidi's{x {MMajin{x {DEmblem{x"
		MULTI = FALSE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 120 // VERY_HARD tier (Babidi)
		BONUS_STR = 70
		BONUS_ARM = 50
		BONUS_STA = 60
		BONUS_MF = 0
		WEIGHT = 0.1
		DROP_CHANCE = 2.00
		PRICE = 18000

	DABURAS_DEMONIC_CROWN
		EQUIPABLE = TRUE;
		DISPLAY = "{RDabura's{x {RDemonic{x {yCrown{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 90 // HARD tier (Dabura)
		BONUS_STR = 55
		BONUS_ARM = 40
		BONUS_STA = 45
		BONUS_MF = 100
		WEIGHT = 2.0
		DROP_CHANCE = 1.50
		PRICE = 13000

	SAIYAN_POWER_CAPE
		EQUIPABLE = TRUE;
		DISPLAY = "{cSaiyan{x {RPower{x {rCape{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 480 // GOD tier (Ancient Saiyan)
		BONUS_STR = 140
		BONUS_ARM = 100
		BONUS_STA = 120
		BONUS_MF = 0
		WEIGHT = 2.0
		DROP_CHANCE = 0.30
		ANNOUNCE_DROP = TRUE
		PRICE = 120000

	SENZU_BEAN_POUCH
		EQUIPABLE = TRUE;
		DISPLAY = "{gSenzu{x {yBean{x {yPouch{x"
		MULTI = FALSE;
		SLOT = WAIST;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 35 // MEDIUM tier (Korin's utility item)
		BONUS_STR = 10
		BONUS_ARM = 15
		BONUS_STA = 45
		BONUS_MF = 200
		WEIGHT = 0.5
		DROP_CHANCE = 6.00
		PRICE = 4500

/* Dragon Ball Super Items */

	GOKU_BLACK_ROSE_SCYTHE
		EQUIPABLE = TRUE;
		DISPLAY = "{DGoku{x {RBlack{x {mRose{x {DScythe{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 550 // GOD tier (Goku Black)
		BONUS_STR = 180
		BONUS_ARM = 120
		BONUS_STA = 140
		BONUS_MF = 0
		WEIGHT = 3.0
		DROP_CHANCE = 0.15
		ANNOUNCE_DROP = TRUE
		PRICE = 200000

	ZAMASU_IMMORTAL_HALO
		EQUIPABLE = TRUE;
		DISPLAY = "{WZamasu's{x {YImmortal{x {YHalo{x"
		MULTI = FALSE;
		SLOT = SPECIAL_HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "above"
		BONUS_KI = 580 // GOD tier (Zamasu)
		BONUS_STR = 150
		BONUS_ARM = 140
		BONUS_STA = 180
		BONUS_MF = 800
		WEIGHT = 0.1
		DROP_CHANCE = 0.10
		ANNOUNCE_DROP = TRUE
		PRICE = 250000

	JIREN_PRIDE_TROOPER_UNIFORM
		EQUIPABLE = TRUE;
		DISPLAY = "{bJiren's{x {RPride{x {WTrooper{x {DUniform{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 520 // GOD tier (Jiren)
		BONUS_STR = 170
		BONUS_ARM = 150
		BONUS_STA = 160
		BONUS_MF = 0
		WEIGHT = 1.5
		DROP_CHANCE = 0.20
		ANNOUNCE_DROP = TRUE
		PRICE = 220000

	CABBA_SAIYAN_CADET_ARMOR
		EQUIPABLE = TRUE;
		DISPLAY = "{cCabba's{x {cSaiyan{x {yCadet{x {gArmor{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 80 // HARD tier (Cabba)
		BONUS_STR = 45
		BONUS_ARM = 40
		BONUS_STA = 35
		BONUS_MF = 0
		WEIGHT = 2.5
		DROP_CHANCE = 1.00
		PRICE = 11000

	KALE_BERSERKER_BANDS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{gKale's{x {RBerserker{x {DBands{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 140 // VERY_HARD tier (Berserker Kale)
		BONUS_STR = 85
		BONUS_ARM = 60
		BONUS_STA = 70
		BONUS_MF = 0
		WEIGHT = 1.0
		DROP_CHANCE = 0.75
		PRICE = 25000

	CAULIFLA_SPIKY_HAIR_CLIP
		EQUIPABLE = TRUE;
		DISPLAY = "{cCaulifla's{x {YSpiky{x {yHair{x {YClip{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 75 // HARD tier (Caulifla)
		BONUS_STR = 40
		BONUS_ARM = 30
		BONUS_STA = 35
		BONUS_MF = 150
		WEIGHT = 0.1
		DROP_CHANCE = 1.25
		PRICE = 10000

	TOPPO_JUSTICE_CAPE
		EQUIPABLE = TRUE;
		DISPLAY = "{WToppo's{x {YJustice{x {WCape{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 500 // GOD tier (Toppo)
		BONUS_STR = 160
		BONUS_ARM = 130
		BONUS_STA = 150
		BONUS_MF = 0
		WEIGHT = 1.8
		DROP_CHANCE = 0.25
		ANNOUNCE_DROP = TRUE
		PRICE = 190000

	RIBRIANNE_LOVE_HEART_NECKLACE
		EQUIPABLE = TRUE;
		DISPLAY = "{mRibrianne's{x {RLove{x {MHeart{x {YNecklace{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 65 // HARD tier (Ribrianne)
		BONUS_STR = 35
		BONUS_ARM = 25
		BONUS_STA = 40
		BONUS_MF = 250
		WEIGHT = 0.2
		DROP_CHANCE = 1.00
		PRICE = 8500

	FROST_POISON_NEEDLE_BRACER
		EQUIPABLE = TRUE;
		DISPLAY = "{CFrost's{x {gPoison{x {yNeedle{x {DBracer{x"
		MULTI = FALSE;
		SLOT = WRISTS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 70 // HARD tier (Frost)
		BONUS_STR = 40
		BONUS_ARM = 30
		BONUS_STA = 35
		BONUS_MF = 0
		WEIGHT = 0.8
		DROP_CHANCE = 1.25
		PRICE = 9500

	ZENO_OMNIPOTENT_BUTTON
		EQUIPABLE = TRUE;
		DISPLAY = "{WZeno's{x {YOmnipotent{x {WButton{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 800 // EVENT_MOB tier (Zeno)
		BONUS_STR = 250
		BONUS_ARM = 200
		BONUS_STA = 300
		BONUS_MF = 1500
		WEIGHT = 0.1
		DROP_CHANCE = 0.01
		ANNOUNCE_DROP = TRUE
		PRICE = 500000

	MASTER_ROSHI_TURTLE_SHELL
		EQUIPABLE = TRUE;
		DISPLAY = "{yMaster{x {yRoshi's{x {gTurtle{x {yShell{x"
		MULTI = FALSE;
		SLOT = BACK;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 45 // MEDIUM tier (Master Roshi)
		BONUS_STR = 15
		BONUS_ARM = 35
		BONUS_STA = 20
		BONUS_MF = 120
		WEIGHT = 12.0
		DROP_CHANCE = 5.00
		PRICE = 4800

	KAMI_GUARDIAN_TURBAN
		EQUIPABLE = TRUE;
		DISPLAY = "{WKami's{x {CGuardian{x {yTurban{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 55 // MEDIUM tier (Kami)
		BONUS_STR = 25
		BONUS_ARM = 20
		BONUS_STA = 30
		BONUS_MF = 180
		WEIGHT = 0.5
		DROP_CHANCE = 3.50
		PRICE = 5500

	GARLIC_JR_IMMORTALITY_CROWN
		EQUIPABLE = TRUE;
		DISPLAY = "{gGarlic{x {gJr's{x {YImmortality{x {yCrown{x"
		MULTI = FALSE;
		SLOT = HEAD;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 110 // VERY_HARD tier (Garlic Jr)
		BONUS_STR = 65
		BONUS_ARM = 50
		BONUS_STA = 60
		BONUS_MF = 200
		WEIGHT = 1.5
		DROP_CHANCE = 0.80
		PRICE = 18000

	COOLER_MECHA_SHOULDER_PADS
		EQUIPABLE = TRUE;
		PREFIX = "a pair of ";
		DISPLAY = "{CCooler's{x {DMecha{x {WShoulder{x {DPads{x"
		MULTI = FALSE;
		SLOT = SHOULDERS;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 160 // VERY_HARD tier (Cooler)
		BONUS_STR = 90
		BONUS_ARM = 70
		BONUS_STA = 80
		BONUS_MF = 0
		WEIGHT = 4.0
		DROP_CHANCE = 0.50
		ANNOUNCE_DROP = TRUE
		PRICE = 35000

	JANEMBA_REALITY_SWORD
		EQUIPABLE = TRUE;
		DISPLAY = "{mJanemba's{x {RReality{x {WSword{x"
		MULTI = FALSE;
		SLOT = HANDS;
		STACKABLE = TRUE;
		EQ_MSG = "in"
		BONUS_KI = 320 // FUSION tier (Janemba)
		BONUS_STR = 120
		BONUS_ARM = 80
		BONUS_STA = 100
		BONUS_MF = 0
		WEIGHT = 2.5
		DROP_CHANCE = 0.30
		ANNOUNCE_DROP = TRUE
		PRICE = 85000

	HIRUDEGARN_MUSIC_BOX_CHARM
		EQUIPABLE = TRUE;
		DISPLAY = "{yHirudegarn's{x {CMusic{x {YBox{x {yCharm{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 280 // FUSION tier (Hirudegarn)
		BONUS_STR = 90
		BONUS_ARM = 70
		BONUS_STA = 110
		BONUS_MF = 500
		WEIGHT = 0.3
		DROP_CHANCE = 0.40
		ANNOUNCE_DROP = TRUE
		PRICE = 75000

	BROLY_LEGENDARY_SAIYAN_COLLAR
		EQUIPABLE = TRUE;
		DISPLAY = "{gBroly's{x {cLegendary{x {cSaiyan{x {yCollar{x"
		MULTI = FALSE;
		SLOT = NECK;
		STACKABLE = TRUE;
		EQ_MSG = "around"
		BONUS_KI = 600 // EVENT_MOB tier (Legendary Broly)
		BONUS_STR = 200
		BONUS_ARM = 150
		BONUS_STA = 180
		BONUS_MF = 0
		WEIGHT = 2.0
		DROP_CHANCE = 0.05
		ANNOUNCE_DROP = TRUE
		PRICE = 300000

	GOGETA_FUSION_VEST
		EQUIPABLE = TRUE;
		DISPLAY = "{cGogeta's{x {DF{x{Yu{x{Ds{x{Yi{x{Do{x{Yn{x {yVest{x"
		MULTI = FALSE;
		SLOT = CHEST;
		STACKABLE = TRUE;
		EQ_MSG = "on"
		BONUS_KI = 350 // FUSION tier (Gogeta)
		BONUS_STR = 130
		BONUS_ARM = 100
		BONUS_STA = 120
		BONUS_MF = 0
		WEIGHT = 1.2
		DROP_CHANCE = 0.25
		ANNOUNCE_DROP = TRUE
		PRICE = 95000

	consecrated_ground
		text = "{c*{x"
		DISPLAY = "{CConsecrated Pool{x"
		SINGLE_DISPLAY = "{CConsecrated Pool{x"
		MULTI_DISPLAY = "{CConsecrated Pool{x"
		CAN_PICKUP = FALSE;
		DROP_CHANCE = 0;
		DECAY = FALSE;
		MISC = TRUE;
		CONTAINER = FALSE;
		SHOW_ITEMDB = FALSE;

		proc
			decayConsecratedGround() {
				set waitfor = FALSE;
				var/time_to_vanish = (world.time + 65 SECONDS);
				while(src) {
					if(world.time >= time_to_vanish){
						if(SINGLE_DISPLAY){
							send("[SINGLE_DISPLAY] disappears into the void.",oview(0,src))
						}else{
							send("[DISPLAY] disappates into the void.",oview(0,src))
						}

						DISPLAY = NULL;
						clean() // del replace
						break;

					}
					sleep(world.tick_lag)
				}
			}

		New(mob/m) {
			..()
			decayConsecratedGround();
		}

	corpse
		text = "{c*{x"
		display = "{c*{x"
		CAN_PICKUP = FALSE;
		DECAY = FALSE;
		MISC = TRUE;
		CONTAINER = TRUE

		var
			isPlayerCORPSE = FALSE;
			playerName = NULL;
			zenniValue = 0;
			killer = NULL;
			owner = NULL;

		proc
			decayCorpse(){
				set waitfor = FALSE;

				var/decayTime = (world.time + 5 MINUTES);

				while(src){
					if(world.time >= decayTime){
						if(SINGLE_DISPLAY){
							send("[SINGLE_DISPLAY] decomposes.",oview(0,src))
						}else{
							send("[DISPLAY] decomposes.",oview(0,src))
						}

						if(playerName && game.checkOnline(playerName) && contents.len > 0){
							var/mob/Player/M = game.checkOnline(playerName)
							for(var/obj/item/i in contents){
								send("You obtain [i.PREFIX][i.DISPLAY]!",M,TRUE)
								i.loc = NULL;
								M.addInv(i);
							}
						}else if(playerName && !game.checkOnline(playerName) && contents.len > 0){
							for(var/obj/item/i in contents){
								_query("INSERT INTO `corpses` (name, item) VALUES ('[playerName]', '[i.type]');")
							}
						}

						DISPLAY = NULL;
						playerName = NULL;
						clean() // del replace
						break;
					}
					sleep(world.tick_lag)
				}
			}

		New(mob/m, mob/killer, zenniVal=0){
			..()

			insideBuilding = m.insideBuilding;
			name = "[m.name]'s corpse"
			DISPLAY = "[m.raceColor(m.name)]'s corpse"

			if(zenniVal>0){
				zenniValue = zenniVal;
			}

			if(isnpc(m)){
				if(m:MULTI){
					SINGLE_DISPLAY = "[m.raceColor("a [m:single_name]")]'s corpse"
					MULTI_DISPLAY = "[m.raceColor(m:multi_name)] corpse"
					MULTI = TRUE;
				}
				src.killer = killer.name;
				src.owner = m.name;
				for(var/i in m:dropList){
					var/dropChance = getDropChance(i); // Initial item drop chance;
					var/totalDrop = (dropChance + ret_percent_notrunx(killer.calcBonusMF(),dropChance)); // Item drop chance after killers drop mod taken into account;

					if(decimal_prob(totalDrop)){
						var/obj/item/x = new i;
						contents += x;
						if(x.ANNOUNCE_DROP){ send("{R\[{x{YWORLD{x{R\]{x [x.PREFIX][x.DISPLAY] dropped from [m.raceColor(m.name)] killed by [killer.raceColor(killer.name)]!",game.players); }
					}
				}
			}else if(isplayer(m)){
				playerName = m.name
				isPlayerCORPSE = TRUE;
				src.killer = killer.name;
				src.owner = m.name;
				for(var/obj/item/i in m.contents){
					if(i.CAN_DROP){
						m.remInv(i)
						contents += i;
					}
				}
			}

			loc=m.loc
			decayCorpse()
		}

		Del(){
			if(loc){
				if(playerName && game.checkOnline(playerName) && contents.len > 0){
					var/mob/Player/M = game.checkOnline(playerName)
					for(var/obj/item/i in contents){
						send("You obtain [i.PREFIX][i.DISPLAY]!",M,TRUE)
						i.loc = NULL;
						M.addInv(i);
					}
				}else if(playerName && !game.checkOnline(playerName) && contents.len > 0){
					for(var/obj/item/i in contents){
						_query("INSERT INTO `corpses` (name, item) VALUES ('[playerName]', '[i.type]');")
					}
				}
			}
			..()
		}