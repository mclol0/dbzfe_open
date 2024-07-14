var/newbieTIPS/tips = new();

newbieTIPS

	var
		tips = list(
			"If you type 'scan' you can see the mobs in your area. Alternatively, you can also 'sense north' to see all mobs north of you.",
			"In order to get to other planets, you need to defeat Vegeta on earth to learn how to summon your spacepod.",
			"Looting corpses and grabbing tons of loot & zenni? Don't forget to head to Bulma's at 86.122 sell your loot!",
			"When finishing a monster with snap, don't forget to loot corpse! You get zenni and potentially some equipment.",
			"Have 2 pieces of equipment that have the same spot? compare them by 'compare \[item\]' to see the different benefits.",
			"If you tech block with parry high/low when defending against incoming attacks, there is a chance for you to gain some powerlevel.",
			"If you gather all 7 dragon balls you get to make a wish! Careful though, having them in your inventory lets anyone PVP you!",
			"Event mobs such as Golden Frieza or Zamasu are quite the challenge. They will go way above your max PL and they hit hard.",
			"You can turn tips off by typing 'channel tips'. You can turn them back on by typing the same thing again.",
			"Some enemies require you to make them transform in order to get a skill from them.",
			"To chat with players on the MUD, type OOC and then your message. OOC = Out of Character chat.",
			"If you know you want to attack Roshi, you can 'fly roshi' and you'll fly directly to him.",
			"Type 'skills' to see your skill list. If you want to learn how to get blast, type 'help blast'.",
			"Dr. Briefs sells housing materials which lets you build a private house wherever you'd like!"
			);

	New(){
		..()
	

		spawn(){
			var/goTime = (world.time + 15 SECONDS);

			while(src){
				if(world.time >= goTime) {
					for(var/mob/Player/m in game.players){
						if(m.channels.Find("TIPS") && !m.in_npc_menu){
							send("{m\[{MTIP{m\]{W: {w[pick(tips)]{x\n",m);
						}
					}

					goTime = (world.time + 15 MINUTES);
				}

				sleep(world.tick_lag);
			}
		}
	}
