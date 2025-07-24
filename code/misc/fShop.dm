Shop
	proc
		getShopItems(shop){
			var
				database/query/q = _query("SELECT * FROM `shop_items` WHERE `NPC`='[shop]';")
				list/RowData
				list/items[0];

			while(q.NextRow()){
				RowData = q.GetRowData();

				var/value = RowData["ItemPath"]

				var/itemPath = text2path(value)
				if (!itemPath) {
					itemPath = migrateOldPath(value)
				}

				var/obj/item/I = new itemPath

				if (!I || I.SKIP_SHOP) {
					del I
					continue
				}

				if(text2num(RowData["Infinite"])){
					items.Add(list(itemPath:type = "#INF"));
					del I
					continue
				}

				if (!I.STOCK_SHOP) 
				{
					del I
					continue
				}

				del I
				items.Add(list(itemPath:type = "[RowData["Quantity"]]"));
			}

			return items;
		}

		updateItem(shop, itemPath, amount, startItem=FALSE, STOCK_SHOP=TRUE){
			if(!STOCK_SHOP){ return FALSE; }

			if(startItem){
				var/rowCount = _rowCount("FROM `shop_items` WHERE `NPC`='[shop]' AND `ItemPath`='[itemPath]';")

				if(!rowCount){
					_query("INSERT INTO `shop_items` (`NPC`, `ItemPath`, `Quantity`, `Infinite`) VALUES ('[shop]', '[itemPath]', '[amount]', '[startItem]');");
				}else{ return FALSE; }

				return TRUE;
			}

			var/rowCount = _rowCount("FROM `shop_items` WHERE `NPC`='[shop]' AND `ItemPath`='[itemPath]';")

			if(rowCount > 0){
				var/itemQuantity = itemQuantity(shop, itemPath);
				var/newValue = (itemQuantity + amount);

				if(newValue < 1){
					_query("DELETE FROM `shop_items` WHERE `NPC`='[shop]' AND `ItemPath`='[itemPath]' AND `Infinite`='[FALSE]';")
					return
				}

				_query("UPDATE `shop_items` SET `Quantity`='[itemQuantity + amount]' WHERE `ItemPath`='[itemPath]' AND `Infinite`='[FALSE]';");
			}else{
				_query("INSERT INTO `shop_items` (`NPC`, `ItemPath`, `Quantity`, `Infinite`) VALUES ('[shop]', '[itemPath]', '[amount]', '[startItem]');");
			}
		}

		itemQuantity(mob/NPA/shop, itemPath){
			var
				rowCount = _rowCount("FROM `shop_items` WHERE `NPC`='[shop]' AND `ItemPath`='[itemPath]';")

			if(rowCount > 0){
				var
					database/query/q = _query("SELECT `Quantity` FROM `shop_items` WHERE `NPC`='[shop]' AND `ItemPath`='[itemPath]';");
					list/row;

				q.NextRow()

				row = q.GetRowData();

				if(text2num(row["Quantity"]) > 0){
					return text2num(row["Quantity"]);
				}
			}

			return 0;
		}