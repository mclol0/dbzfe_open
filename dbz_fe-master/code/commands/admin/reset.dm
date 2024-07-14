Command/Wiz
	reset
		name = "reset";
		immCommand = 1
		immReq = 3
		format = "reset; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{creset{x {c<{x{Cmobile{x{c>{x";

		command(mob/user, mob/Player/m) {
			if(m && isplayer(m)){
				send("SOMETHING WEIRD IS HAPPENING!",m);
				m.techniques = list();
				m.startingSkills();
				send("YOU SUDDENLY FORGET ANY ABILITIES YOU HAVE OBTAINED!",m);
				m.form = "Normal";
				m.maxpl = getMinPL(m.race);
				m.currpl = m.maxpl;
				send("YOU FEEL A LOT WEAKER...",m);
				for(var/obj/item/i in m.equipment){m.removeItem(i,m);}
				m.contents = NULL;
				_query("DELETE FROM `inventory` WHERE `owner`='[m.name]';");
				_query("DELETE FROM `corpses` WHERE `name`='[m.name]';");
				send("SOME ASSHOLE JUST TOOK ALL YOUR INVENTORY!",m);
				m.saveSQLCharacter();
				send("YOU SUDDENLY FEEL HAPPY THAT THIS HAS HAPPENED!",m);
				send("[m.name] has been reset..",user);
			}
			else{
				syntax(user,syntax);
			}
		}