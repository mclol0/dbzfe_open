Command/Wiz
	ban_player
		name = "ban player";
		immCommand = 1
		immReq = 2
		format = "banplayer; any";
		syntax = "{cban{x{cplayer{x {c<{x{Cname{x{c>{x"

		command(mob/user, name) {
			if(name){
				if(lowertext(name) in game.banned_players){
					send("[name] is already banned!",user)
				}
				else{
					send("[name] has been banned!",user)
					game.logger.warn("[name] has been banned by [user.name]")
					game.banPlayer(lowertext(name))
					var/mob/Player/M = game.findPlayer(name);
					if(M){ M.disconnect(); }
				}
			}
			else{
				syntax(user,syntax);
			}
		}

	unban_player
		name = "unban player";
		immCommand = 1
		immReq = 2
		format = "unbanplayer; any";
		syntax = "{cunban{x{cplayer{x {c<{x{Cname{x{c>{x"

		command(mob/user, name) {
			if(name){
				if(lowertext(name) in game.banned_players){
					send("[name] has been unbanned!",user)
					game.logger.warn("[name] has been unbanned by [user.name].")
					game.unbanPlayer(lowertext(name))
				}
				else{
					send("[name] is not banned!",user)
				}
			}
			else{
				syntax(user,syntax);
			}
		}

	ban_ip
		name = "ban ip";
		immCommand = 1
		immReq = 2
		format = "banip; any";
		syntax = "{cban{x{cip{x {c<{x{Cip{x{c>{x"

		command(mob/user, ip) {
			if(ip){
				if(ip in game.banned_ips){
					send("[ip] is already banned!",user)
				}
				else{
					send("[ip] has been banned!",user)
					game.logger.warn("[ip] has been banned by [user.name].")
					game.banIp(ip)
				}
			}
			else{
				syntax(user,syntax);
			}
		}

	unban_ip
		name = "unban ip";
		immCommand = 1
		immReq = 2
		format = "unbanip; any";
		syntax = "{cunban{x{cip{x {c<{x{Cip{x{c>{x"

		command(mob/user, ip) {
			if(ip){
				if(ip in game.banned_ips){
					send("[ip] has been unbanned!",user)
					game.logger.warn("[ip] has been unbanned by [user.name].")
					game.unbanIp(ip)
				}
				else{
					send("[ip] is not banned!",user)
				}
			}
			else{
				syntax(user,syntax);
			}
		}