Command/Public
	liststore
		name = "list"
		format = "list;";
		canUseWhileRESTING = FALSE;
		priority=2
		helpCategory = "NPC Shops"
		helpDescription = "Display the list of items that a NPC in the room currently has for sale."

		command(mob/user) {
			var/list/mobiles = user.getRoom()

			for(var/mob/NPA/M in mobiles){
				if(M.isStore)
				{
					M.listStore(user);
				}else{
					send("{WNo one here is selling anything...{x",user)
				}
			}
		}

	appraise
		name = "appraise"
		format = "~appraise; num|~!searc(obj@inventory)";
		syntax = list("item id | item in inventory")
		canUseWhileRESTING = TRUE;
		priority=2
		helpCategory = "NPC Shops"
		helpDescription = "Look at the details of an item that is on sale in a NPC shop. When this is used with an item in the inventory, the NPC will notify for how much he would buy the item."

		command(mob/user, itemId) {
			if (itemId && istype(itemId,/obj/item)){
				var/mob/NPA/M = user.checkStoreInRoom()
				if (M)
				{
					alaparser.parse(M,"say I'll give you [commafy(sellValue(itemId:type,FALSE))] Zenni for your [itemId:DISPLAY].",list())
					return
				}else{
					send("There is no shop here to appraise this time!",user,TRUE)
					return
				}
			}else if(itemId){
				var/mob/NPA/M = user.checkStoreInRoom()

				if (M)
				{
					{
						M.examineStore(user, itemId)
					}
				}
				return
			}

			syntax(user, getSyntax())
		}

	buy
		name = "buy"
		format = "~buy; !num; ?num";
		syntax = list("item id", "quantity")
		canUseWhileRESTING = TRUE;
		priority=2
		helpCategory = "NPC Shops"
		helpDescription = "Buy a specific item from an NPC shop."

		command(mob/user, var/itemId, var/quantity=1) {
			var/mob/NPA/M = user.checkStoreInRoom()

			if(M && M.buyStore(user, itemId, quantity)){
				return FALSE;
			}

			syntax(user,getSyntax())
		}

	sell
		name = "sell"
		format = "~sell; !~searc(obj@inventory)";
		syntax = list("item")
		canUseWhileRESTING = TRUE;
		priority=2
		helpCategory = "NPC Shops"
		helpDescription = "Sell an item on your inventory to an NPC shop."

		command(mob/user, obj/item/I) {
			if (I)
			{
				if (!I.CAN_SELL) {
					send("You cannot sell this item.", user)
					return
				}

				var/mob/NPA/M = user.checkStoreInRoom()

				if (M)
				{
					M.sellStore(user, I)
				}

				return
			}

			send("You don't have that item.", user)
			syntax(user, getSyntax())
		}