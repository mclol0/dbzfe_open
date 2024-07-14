Command/Public
	unalias
		name = "unalias"
		format = "~unalias; any";
		syntax = list("\"command\"")
		canAlwaysUSE = TRUE
		canUseWhileRESTING = TRUE;
		helpDescription = "Remove a specific alias that you have previously defined."

		command(mob/Player/user, input) {
			if(user && input){

				var
					pos1
					pos2
					command

				for(var/i=length(input),i>0,i--){
					var/c = copytext(input,i,i+1)
					if(c=="\"" && !pos1){
						pos1=i
					}else if(c=="\"" && pos1){
						pos2=i
					}
				}

				if(!pos1 || !pos2){
					syntax(user,src);
					return
				}else{
					command = copytext(input,pos2+1,pos1)
				}

				if(!ASCII_Filter(command,"048-057&065-090&097-122&032")){
					send("Your alias may contain only letters and numbers.",user)
					return
				}

				var/rowCount = _rowCount("FROM `aliases` WHERE `owner`='[user.name]' AND `command`='[command]';");

				if(rowCount > 0){
					if(_query("DELETE FROM `aliases` WHERE `owner`='[user.name]' AND `command`='[command]';")){
						send("Alias [command] deleted!",user)
						user.loadAliases()
					}else{
						send("There was a problem deleting your alias!",user)
					}
				}else{
					send("You have no function for \"[command]\"!",user)
				}
			}else{
				syntax(user,src);
			}
		}