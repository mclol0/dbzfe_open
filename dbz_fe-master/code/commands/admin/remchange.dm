Command/Wiz
	remove_change
		name = "remchange";
		immCommand = 1
		immReq = 4
		format = "remchange; num";
		syntax = "{cremchange{x {c<{x{CCID{x{c>{x"

		command(mob/user, CID) {
			if(user && isnum(CID)){
				var/rowCount = _rowCount("FROM `changes` WHERE `CID`='[CID]';")
				if(rowCount>0){
					send("Change [CID] deleted.\n",user);
					_query("DELETE FROM `changes` WHERE `CID`=\"[CID]\";")
				}else{
					send("Change not found.\n",user);
				}
			}
			else{
				syntax(user,syntax);
			}
		}