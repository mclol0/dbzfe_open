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
					send("{WYou begin to concentrate...{x",user);
					send("{W*{x [user.raceColor(user.name)] {Wbegins to concentrate...{x",_ohearers(0,user))
					sleep(10);
					send("{B*{x {WA white aura bursts around you!{x",user);
					send("{W*{x {WA white aura bursts around{x [user.raceColor(user.name)]{W!{x",_ohearers(0,user))
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.form = formName;
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					user._doEnergy(-10)
					user.CheckForm()
					user.locked=FALSE;
				}

			}
			else{
				send("Syntax: [syntax] {c\[{x{CRange: [user.calcMeleeRange(_maxDistance)] rooms{x{c\]{x",user)
			}
		}