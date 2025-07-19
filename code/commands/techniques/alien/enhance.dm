Command/Technique/Form
	enhance
		name = "enhance"
		internal_name = "enhance"
		format = "~enhance";
		priority = 1
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Enhanced"
		helpDescription = "Break over your limits by focusing your inner strength, allowing you to raise your ki to new heights."

		command(mob/user) {

			if(user){
				if(user.form != "Normal"){
					send("You are already in the [user.form] form!",user)
				}else{
					var/c = percent(user.currpl,user.getMaxPL())
					user.locked=TRUE;
					// Begin enhanced transformation sequence
					send("{DYou close your eyes, focusing your energy...{x", user)
					send("{W*{x [user.raceColor(user.name)] {Dcloses their eyes, focusing intensely...{x", _ohearers(0, user))
					sleep(7)
					send("{DThe air around you begins to shimmer with {Bcrackling energy{D!{x", user)
					send("{W*{x [user.raceColor(user.name)] {Dis surrounded by {Bcrackling energy{D!{x", _ohearers(0, user))
					sleep(7)
					send("{DYour veins glow with {Ygolden light{D as your power surges!{x", user)
					send("{W*{x [user.raceColor(user.name)] {Dis outlined in {Ygolden light{D as their power surges!{x", _ohearers(0, user))
					sleep(7)
					send("{DThe ground trembles beneath you, and a {Bstorm of energy{D swirls around your body!{x", user)
					send("{W*{x [user.raceColor(user.name)] {Dstands at the center of a {Bstorm of energy{D!{x", _ohearers(0, user))
					sleep(7)
					send("{DA blinding {Wwhite{D aura explodes outward!{x", user)
					send("{W*{x [user.raceColor(user.name)] {Dis engulfed in a blinding {Wwhite{D aura!{x", _ohearers(0, user))
					send("{DYou are now{x {WEnhanced{x{D.{x", user)
					mOuter("a cataclysmic surge of energy", user, ov_out(1, 12, user));
					user.form = formName;
					user.currpl = clamp(ret_percent(c, user.getMaxPL()), 5, user.getMaxPL())
					user._doEnergy(-10)
					user.CheckForm()
					user.locked=FALSE;
				}

			}
			else{
				send("Syntax: [syntax] {c\[{x{CRange: [user.calcMeleeRange(_maxDistance)] rooms{x{c\]{x",user)
			}
		}