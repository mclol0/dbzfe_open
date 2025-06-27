Command/Public
	password
		name = "passwd"
		format = "passwd; any";
		syntax = list("old password", "new password")
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "Change your current password for a new one."

		command(mob/Player/user, input) {
			var/list/token = text2list(input);

			if(token.len == 2){
				var/database/query/q = _query("SELECT `password` FROM `characters` WHERE `name`='[user.name]';");

				q.NextRow()

				var/list/vlist = q.GetRowData();

				if(md5(crypto_salt+token[1]) == vlist["password"]){
					if(!user.Review_Password(token[2])){
						token += input_password("\nConfirm Password: ",user)

						if(token[2] == token[3]){
							if(_query("UPDATE `characters` SET `password`='[md5(crypto_salt+token[2])]' WHERE `name`='[user.name]';")){
								send("{GSUCCESS: {WPassword updated.{x",user);
							}else{
								send("{RERROR: {WThere was a problem updating your password.{x",user);
							}
						}else{
							send("{RERROR: {WNew password mismatch.{x",user)
						}
					}
				}else{
					send("{RERROR: {WOld password was wrong.{x",user)
				}
			}else{
				syntax(user,src);
			}
		}