var
	list/itemPrices = list();

proc
	//*Storage Procs*//

	getStorageItems(shop,var/mob/Player/m){
		var
			database/query/q = _query("SELECT * FROM `player_storage` WHERE `NPC`='[shop]' AND `PLAYER`='[m.name]';")
			list/RowData
			list/items = list();

		while(q.NextRow()){
			RowData = q.GetRowData();

			var/item = text2path(RowData["ITEM"])
			if (!item) {
				item = migrateOldPath(RowData["ITEM"])
			}

			items.Add(list(item = "x[RowData["QUANTITY"]]"));
		}

		return items;
	}

	getItemQuantity(var/shop,var/item,var/mob/Player/m){
		var/rowCount = _rowCount("FROM `player_storage` WHERE `NPC`='[shop]' AND `PLAYER`='[m.name]' AND `ITEM`='[item]';")

		if(rowCount > 0){
			var
				database/query/q = _query("SELECT * FROM `player_storage` WHERE `NPC`='[shop]' AND `PLAYER`='[m.name]' AND `ITEM`='[item]';")
				list/RowData

			q.NextRow()
			RowData = q.GetRowData();

			return text2num(RowData["QUANTITY"]);
		}

		return -1;
	}

	depositItem(var/shop,obj/item,var/mob/Player/m){
		if(getItemQuantity(shop,item.type,m) > 0){
			m.destroyItem(item);
			_query("UPDATE `player_storage` SET `QUANTITY`='[getItemQuantity(shop,item.type,m) + 1]' WHERE `NPC`='[shop]' AND `ITEM`='[item.type]' AND `PLAYER`='[m.name]';");
		}else{
			m.destroyItem(item);
			_query("INSERT INTO `player_storage` (`NPC`, `PLAYER`, `ITEM`, `QUANTITY`) VALUES ('[shop]', '[m.name]', '[item.type]', '1');");
		}
	}

	withdrawItem(var/shop,var/item,var/mob/Player/m){
		var/itemQuantity = getItemQuantity(shop,item,m);

		if(itemQuantity > 0){
			if((itemQuantity - 1) <= 0){
				_query("DELETE FROM `player_storage` WHERE `PLAYER`='[m.name]' AND `NPC`='[shop]' AND `ITEM`='[item]';")
			}else{
				_query("UPDATE `player_storage` SET `QUANTITY`='[(itemQuantity - 1)]' WHERE `NPC`='[shop]' AND `ITEM`='[item]' AND `PLAYER`='[m.name]';");
			}
		}
	}

	//*Storage Procs*//

	sellValue(var/item=NULL, OR=FALSE){
		if(item && OR){
			return itemPrices["[item]"];
		}else if(item){
			return round(itemPrices["[item]"] / 3);
		}

		return 0;
	}

	buildShop_Items(list/shop, addExit=TRUE, shopSale=FALSE){
		var
			list/shopItems[] = list()

		if (addExit)
			shopItems += "{RExit{x"

		for(var/x in shop){
			var/obj/item/I = new x //Workaround for an issue I was having and was to lazy to try to figure out. Ask Thunder later
			var/qMsg = shop[x] == "#INF" ? "[shop[x]]" : "x[shop[x]]"
			if (I.STOCK_SHOP || qMsg == "#INF") {
				if(shopSale){
					shopItems += "{D[I.DISPLAY]{x ~ {Y[commafy(itemPrices["[x]"]*0.85)] Zenni{x - Quantity: [qMsg]"
				} else {
					shopItems += "{D[I.DISPLAY]{x ~ {Y[commafy(itemPrices["[x]"])] Zenni{x - Quantity: [qMsg]"
				}
			}
			del I
		}

		return shopItems;
	}

	buildStorage_Options(list/storage){
		var
			list/Options[] = list()

		Options += "{RExit{x"

		if(storage.len < 1){
			Options += "{DStorage empty.{x"
		}else{
			//Options += "{GWithdraw All{x"

			for(var/x in storage){
				Options += list("{D[game.itemNames[x]]{x ~ Quantity: [storage[x]]" = x);
			}
		}

		return Options;
	}

	buildDepositOptions(list/inventory){
		var
			list/Options[] = list()

		Options += "{RExit{x"

		if(inventory.len < 1){
			Options += "{DInventory empty.{x"
		}else{
			Options += "{GDeposit All{x"

			for(var/obj/item/x in inventory){
				Options += list("[game.itemNames[x.type]]" = x);
			}
		}

		return Options;
	}

	getSellMenu(mob/Player/m){
		var
			list/shopItems[] = list()

		shopItems += "{RExit{x"

		if(m.contents.len < 1){
			shopItems += "{DInventory empty.{x"
		}else{
			shopItems += "{GSell All{x"

			for(var/obj/item/x in m.contents){
				if(!x.MISC){
					if(x.OR_PRICE){
						shopItems += list("{D[game.itemNames[x.type]]{x ~ {Y[commafy(itemPrices["[x.type]"])] Zenni{x" = x);
					}else{
						shopItems += list("{D[game.itemNames[x.type]]{x ~ {Y[commafy(itemPrices["[x.type]"] / 2)] Zenni{x" = x);
					}
				}
			}

		}

		return shopItems;
	}

	getKorinSellMenu(mob/Player/m){
		var
			list/shopItems[] = list()

		shopItems += "{RExit{x"

		for(var/obj/item/x in m.contents){
			if(!x.MISC && x.type == /obj/item/SENZU_BEAN){
				if(x.OR_PRICE){
					shopItems += list("{D[game.itemNames[x.type]]{x ~ {Y[commafy(itemPrices["[x.type]"])] Zenni{x" = x);
				}else{
					shopItems += list("{D[game.itemNames[x.type]]{x ~ {Y[commafy(itemPrices["[x.type]"] / 2)] Zenni{x" = x);
				}
			}
		}

		shopItems += "{GSell All{x"

		return shopItems;
	}
