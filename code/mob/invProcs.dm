mob
	proc
		listInv(){
			return view_list(stackItems(contents.Copy(), list("type")),"inventory",src);
		}

		addInv(obj/item/o){
			if (istype(src, /mob/Player)) {
				if(!o.dBID){o.dBID = (getLastID() + 1);}
				_query("INSERT INTO `inventory` (`ID`,`type`,`owner`) VALUES ('[o.dBID]','[o.type]','[name]');");
			}
			o.Move(src)
			qFac.checkItem(src)
		}

		remInv(obj/item/o){
			// Don't SQL for mobs
			if (istype(src, /mob/NPA)) {
				return
			}
			_query("DELETE FROM `inventory` WHERE `ID`='[o.dBID]';");
		}

		destroyItem(obj/item/o){
			remInv(o)
			o.clean()
		}

		dropItem(obj/item/o){
			remInv(o)
			o.dBID = NULL;
			o.loc=locate(x,y,z)
			if(o.DECAY) o.decayItem(o.loc)
		}

		giveItem(obj/item/O, mob/m){
			send("You give [m.raceColor(m.name)] [O:PREFIX][O:DISPLAY].",src)
			send("[src.raceColor(src.name)] gives you [O:PREFIX][O:DISPLAY].", m)
			send("[src.raceColor(src.name)] gives [m.raceColor(m.name)] [O:PREFIX][O:DISPLAY].",a_oview_extra(0,src,m))
			remInv(O)
			m.addInv(O)
			if (istype(m, /mob/NPA)) {
				m.receive_item(O, src)
			}
		}

		equipItem(obj/item/o,mob/Player/m){
			o._equip(m)
		}

		removeItem(obj/item/o,mob/Player/m, var/mute=FALSE){
			o._unequip(m, mute)
		}

		Eat(obj/item/o){
			if(o._eat(src)){
				destroyItem(o)
				}
		}

		Smoke(obj/item/o){
			if(o._smoke(src)){
				destroyItem(o)
				}
		}

		Open(obj/item/o){
			if(o._open(src)){
				destroyItem(o)
			}
		}