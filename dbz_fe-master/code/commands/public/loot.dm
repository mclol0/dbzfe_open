Command/Public
	loot
		name = "loot"
		format = "~loot; !searc(obj@corpse)|~searc(obj@corpse)|!searc(obj@container)|~searc(obj@container); ?any";
		syntax = list("corpse | container", "item name")
		priority=1
		helpDescription = "Grab one or all the contents of the specified corpse or container. If used in a player corpse, the first item of his inventory will be looted and then the corpse will disappear."

		command(mob/user, obj/item/o, item) {
			if(o && user.loc == o.loc){
				o:loot(user, item)
			}
			else{
				syntax(user, src);
			}
		}