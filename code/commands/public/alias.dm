Command/Public
	alias
		name = "alias"
		format = "~alias; any";
		syntax = list("\"alias name\"", "command")
		canAlwaysUSE = TRUE
		canUseWhileRESTING = TRUE;
		priority = 2;
		helpDescription = "This command can be used to create an alias for a specific function.\nExample: alias \"pr\" punch right, this example will alias pr as an alias of punch right so for example if you were to type pr Master Roshi you would do the command \"punch right Master Roshi\" do not forget the quotation marks are needed for the alias when creating an alias (alias \"pr\" punch right)."
		cancelsPushups = FALSE;

		command(mob/Player/user, input) {
			if(user && input){
				if(TextMatch("list", input, 1, 1)){
					var/rowCount = _rowCount("FROM `aliases` WHERE `owner`='[user.name]';");

					if(rowCount > 0){
						var/database/query/q = _query("SELECT * FROM `aliases` WHERE `owner`='[user.name]';");

						send("ALIAS ~ FUNCTION",user,TRUE);

						while(q.NextRow()){
							var/list/row = q.GetRowData();

							send("[row["command"]] ~ [row["function"]]",user,TRUE);
						}

					}else{
						send("You have created no aliases!",user,TRUE);
					}
				}else{
					var
						pos1
						pos2
						function
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
						command = sanit(copytext(input,pos2+1,pos1))
						function = sanit(copytext(input,(pos2+1 + pos1),length(input)+1))
					}

					if(!ASCII_Filter(command,"048-057&065-090&097-122&032") || !ASCII_Filter(function,"048-057&065-090&097-122&032")){
						send("Your alias may contain only letters and numbers.",user)
						return
					}

					var/rowCount = _rowCount("FROM `aliases` WHERE `owner`='[user.name]' AND `command`='[command]';");

					if(!rowCount){
						var/database/query/q = _query("INSERT INTO `aliases` (owner, command, function) VALUES ('[user.name]', '[command]', '[function]');");
						if(q){
							send("Alias added!",user)
							send("[command] now performs the function [function]!",user)
							user.loadAliases()
						}else{
							send("There was a problem inserting your alias!",user)
						}
					}else{
						send("You already have a function for \"[command]\"!",user)
					}
				}
			}else{
				syntax(user,src);
			}
		}