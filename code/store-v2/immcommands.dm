Command/Wiz
	checkstoreinv
		name = "checkstoreinv"
		format = "checkstoreinv; !~searc(mob@all_mob_loc)";
		internal_name = "checkstoreinv";
		immCommand = 1
		immReq = 1
		syntax = "{checkstoreinv{x {c<{xMobile{c>{x"

		command(mob/Player/user, mob/m) {
			for(var/V in m:storeInventory) {
				send("[V]: [m:storeInventory[V]]", user)
			}
		}