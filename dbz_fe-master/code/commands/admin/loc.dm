Command/Wiz
	loc
		name = "loc";
		format = "~loc; !searc(mob@mobiles)|~searc(mob@mobiles);";
		syntax = "{cloc{x {c\[{x{Ctarget{x{c\]"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 1

		command(mob/user, mob/m) {
			if(m) {
				send("{Y[m]'s' Location is X: [m.x], Y: [m.y], Z: [m.z]{x", user);
			} else {
				send("{YYour Location is X: [user.x], Y: [user.y], Z: [user.z]{x", user);
			}
		}
