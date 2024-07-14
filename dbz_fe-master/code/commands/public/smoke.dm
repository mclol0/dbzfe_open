Command/Public
	smoke
		name = "smoke"
		format = "~smoke; ?!searc(obj@inventory)|?~searc(obj@inventory)";
		internal_name = "eat";
		syntax = list("item name")
		canUseWhileRESTING = TRUE;
		priority = 1
		helpDescription = "Consume a smokable item from your inventory to trigger its effects."

		command(mob/user, obj/item/o) {
			if(o){
				user.Smoke(o);
				game.addCooldown(user.name,internal_name,600 SECONDS);
			}
			else{
				syntax(user,src);
			}

		}