proc/displayMenu(msg, list/l, border="default", width=40, mob/m=usr) {
	var/MBborder/Border = MUDbase.borders[border]
	if(!Border) Border = MUDbase.borders["default"]
	var/top = Border.upper_left
	var/c
	while(c < width)
		top += Border.upper_center
		c += length(Border.upper_center)
	top += Border.upper_right
	var/low = Border.lower_left
	c = 0
	while(c < width)
		low += Border.lower_center
		c += length(Border.lower_center)
	low += Border.lower_right
	var/list/buffer = list()
	buffer += "[format_text(top)]\n"
	buffer += "[format_text("[Border.center_left]<ac[(width+(length(msg) - length(rStrip_Escapes(msg))))]>[msg]</a>[Border.center_right]")]\n"
	c = 0
	for(var/i in l)
		c++
		buffer += "[format_text("[Border.center_left]<al4>[c]) </a><al[(width+(length(i) - length(rStrip_Escapes(i))))-4]>[i]</a>[Border.center_right]")]\n"
	buffer += "[format_text(low)]"

	return implodetext(buffer, "")
}

mob
	NPA
		proc
			listStore(mob/Player/user)
			examineStore(mob/Player/user, itemIndex){
				if (!validateIndex(user, itemIndex))
					return

				var/obj/item/I = _createItemFromStoreInventory(itemIndex)

				var/Sl = I.SLOT

				if(I.SLOT == FINGERS){
					if(!user.equipment[LEFT_FINGER]){
						Sl = LEFT_FINGER;
					}else if(!user.equipment[RIGHT_FINGER]){
						Sl = RIGHT_FINGER;
					}else{
						Sl=pick(LEFT_FINGER,RIGHT_FINGER);
					}
				}

				var/obj/item/E = user.equipment[Sl]

				I:showDetails(user, E)
			}

			sellStore(mob/Player/user, obj/item/saleItem){
				var/salePrice = sellValue(saleItem.type, saleItem.OR_PRICE)
				if (src.zenni < salePrice) {
					alaparser.parse(src, "say I don't have enough money to buy that from you.", list())
					return
				}

				send("You sell [saleItem.PREFIX][saleItem.DISPLAY] for {G[commafy(salePrice, 999)]{x {YZenni{x.", user)
				user.zenni += salePrice
				src.zenni -= salePrice
				if (saleItem.STOCK_SHOP) {
					changeStock(saleItem.type, 1)
				}
				user.destroyItem(saleItem)
			}

			displayStore(mob/Player/user, msg, list/items, border, width){
				send(displayMenu(msg, items, border, width, user), user)
			}

			buyStore(mob/Player/user, itemIndex, quantity){
				if (!validateIndex(user, itemIndex))
					return FALSE

				if (quantity <= 0)
				{
					send("Please enter a valid quantity", user)
					return FALSE
				}

				var/obj/item/I = _createItemFromStoreInventory(itemIndex)
				if (!_checkStock(I.type, quantity)) {
					send("There are not enough [I.DISPLAY] for you to purchase.", user)
					del I
					return FALSE
				}

				I.PRICE = I.PRICE ? I.PRICE : 0
				if (user.zenni >= I.PRICE * quantity)
				{
					//Item bought, deduct zenni and create item
					var/x
					for(x = 1; x <= quantity; x++)
					{
						var/obj/item/tempItem = _createItemFromStoreInventory(itemIndex)
						user.addInv(tempItem)
					}
					user.zenni -= I.PRICE * quantity
					src.zenni += I.PRICE * quantity
					changeStock(I.type, -1)
					send("You have bought [quantity] [I.DISPLAY] for {G[commafy(I.PRICE * quantity, 999)]{x {YZenni{x.", user)
					del I
					return TRUE
				}

				//Not enough money
				send("You do not have enough money to buy that.", user)
				return FALSE
			}

			changeStock(var/itemType, quantity) {
				if (itemType in src:storeInventory) {
					var/numText = src:storeInventory[itemType]

					if (numText && numText == "#INF") {
						return
					} else {
						src:storeInventory[itemType] = text2num(src:storeInventory[itemType]) + quantity
					}

					if (storeInventory[itemType] < 1) {
						src:storeInventory.Remove(itemType)
					}

					return
				}

				// Item is not in inventory. Add it.
				if (quantity > 0)
					src:storeInventory[itemType] = quantity
			}

			_checkStock(var/itemType, quantity) {
				var/numStock = text2num(storeInventory[itemType])
				if (!numStock || storeInventory[itemType] == "#INF") {
					return TRUE
				}

				if (numStock >= quantity) {
					return TRUE
				}

				return FALSE
			}

			_createItemFromStoreInventory(itemIndex)
			{
				var/itemPath = src:storeInventory[itemIndex]
				var/obj/item/I = new itemPath
				return I
			}

			validateIndex(mob/user, itemIndex)
			{
				if (itemIndex <= 0 || itemIndex > src:storeInventory.len)
				{
					send("The given Item ID does not seem to exist. Please use a valid ID from the {clist{x", user)
					return FALSE
				}

				return TRUE
			}

mob
	proc
		checkStoreInRoom() {
			var/list/mobiles = src.getRoom()

			for(var/mob/NPA/M in mobiles){
				if(M.isStore)
					return M
			}

			return NULL
		}