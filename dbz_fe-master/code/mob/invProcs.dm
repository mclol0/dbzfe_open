mob
	proc
		listInv(){
			return view_list(stackItems(contents.Copy(), list("type")),"inventory",src);
		}

		addInv(obj/item/o){
			if(!o.dBID){o.dBID = (getLastID() + 1);}
			_query("INSERT INTO `inventory` (`ID`,`type`,`owner`) VALUES ('[o.dBID]','[o.type]','[name]');");
			o.Move(src)
			qFac.checkItem(src)
		}

		remInv(obj/item/o){
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

		giveItem(obj/item/o, mob/Player/m){
			remInv(o)
			m.addInv(o)
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