Command/Technique/Form
	form_4
		name = "form4"
		internal_name = "form 4"
		format = "~form4";
		priority = 3
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "FORM 4"
		helpDescription = "Icer's third transformation condenses their muscles and armor into fibers of pure strength. They are even stronger than their previous forms but at the cost of less armor."

		command(mob/user) {
			if(user){
				if(user.form != "FORM 2" && user.form != "FORM 3" && user.form != "FORM 1"){
					send("You are already in the [user.form] form!",user)
				}else{
					user.locked=TRUE;
					send("{MYou curl into a ball as your armor becomes a cocoon{x",user)
					send("{W*{x {M[user.raceColor(user.name)]{x{M curls into a ball as, [user.determineSex(1)] spiked armor encases [user.determineSex(2)]..." ,_ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "FORM 3"){ user.checkForm = FALSE; } else { user._doEnergy(-20); }
					user.form = "FORM 4"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{MYour armored cocoon begins to crack and glow!{x",user);
					send("{W*{x {M[user.raceColor(user.name)]{x{M 's armored cocoon begins to crack and glow!{x",_ohearers(0,user))
					send("{W*{x {M[user.raceColor(user.name)]{x{M 's cocoon explodes as [user.determineSex(3)] emerges in [user.determineSex(1)] fourth form!{x",_ohearers(0,user))
					send("{MYou emerge from the shattered remains of your cocoon in your fourth form!{x",user)
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE
				}
			}
			else{
				syntax(user,syntax);
			}
		}
