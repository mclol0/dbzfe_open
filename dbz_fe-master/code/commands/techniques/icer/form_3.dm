Command/Technique/Form
	form_3
		name = "form3"
		internal_name = "form 3"
		format = "~form3";
		priority = 3
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "FORM 3"
		helpDescription = "Icer's second transformation makes them even stronger as they grow in size, but it also makes them more resistance as they create natural spiked armor in their body."

		command(mob/user) {
			if(user){
				if(user.form != "FORM 2" && user.form != "FORM 1"){
					send("You are already in the [user.form] form!",user)
				}else{
					user.locked=TRUE;
					send("{MYou hunch over as your head elongates and armor begins to cover your body{x",user)
					send("{W*{x {M[user.raceColor(user.name)]{x{M hunches over as armor begins to cover, [user.determineSex(1)] body with spikes..." ,_ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					if(user.form == "FORM 2"){ user.checkForm = FALSE; } else { user._doEnergy(-10); }
					user.form = "FORM 3"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{MSpikes erupt from your body!{x",user);
					send("{W*{x {M[user.raceColor(user.name)]{x{M 's head elongates as [user.determineSex(1)] armor hardens!{x",_ohearers(0,user))
					send("{W*{x {M[user.raceColor(user.name)]{x{M has reached [user.determineSex(1)] monstrous third form!{x",_ohearers(0,user))
					send("{MYou devolve into your monstrous third form!{x",user)
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
