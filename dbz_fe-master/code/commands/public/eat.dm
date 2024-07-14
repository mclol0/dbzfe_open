Command/Public
	eat
		name = "eat"
		format = "~eat; ?!searc(obj@inventory)|?~searc(obj@inventory)";
		internal_name = "eat";
		syntax = list("item name")
		canUseWhileRESTING = TRUE;
		priority = 1
		helpDescription = "Consume an edible item from your inventory to trigger its effects."

		command(mob/user, obj/item/o) {
			if(..(user)){
				return;
			}

			if(o){
				user.Eat(o);
				game.addCooldown(user.name,internal_name,60 SECONDS);
			}
			else{
				syntax(user,src);
			}

		}