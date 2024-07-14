Command/Technique/Form
	form_5
		name = "form5"
		internal_name = "form 5"
		format = "~form5";
		priority = 3
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "FORM 5"
		helpDescription = "Icer's final transformation makes them one of the most feared races in the galaxy. Stronger armor and new unlocked potential provides the Icer a significant boost in the strength, armor and overall raw power to destroy their enemies."

		command(mob/user) {
			if(user){
				if(user.form != "GOLDEN FORM 4" && user.form != "FORM 4" && user.form != "FORM 3" && user.form != "FORM 2" && user.form != "FORM 1"){
					send("You are already in the [user.form] form!",user)
				}else{
					if(user.form == "GOLDEN FORM 4"){
						user.locked=TRUE;
						send("{YYou grin evily as your body begins to emit an intense golden light.{x",user)
						send("{W*{x {M[user.raceColor(user.name)]{x{M grins evily as their body begins to emit an intense golden light..." ,_ohearers(0,user))
						sleep(10)
						var/c = percent(user.currpl,user.getMaxPL())
						user.checkForm = FALSE;
						user._doEnergy(-10);

						user.form = "GOLDEN FORM 5";

						user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
						alaparser.parse(user, "yell TIME TO WITNESS TRUE POWER!!!", list());
						send("{YYou transform into your ultimate form!{x",user);
						send("{W*{x {M[user.raceColor(user.name)]{x{Y transforms into their ultimate form!{x",_ohearers(0,user))
						user._doEnergy(-10)
						user.CheckForm()
						mOuter("a sudden surge of energy",user,ov_out(1,12,user));
						user.locked=FALSE
					}else{
						user.locked=TRUE;
						send("{MYou grin evily as amorphous armor begins to wrap around your body{x",user)
						send("{W*{x {M[user.raceColor(user.name)]{x{M grins evily as amorphous armor begins to wrap around, [user.determineSex(1)] body..." ,_ohearers(0,user))
						sleep(10)
						var/c = percent(user.currpl,user.getMaxPL())
						if(user.form == "FORM 4"){ user.checkForm = FALSE; } else { user._doEnergy(-20); }
						user.form = "FORM 5"
						user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
						send("{MYour armor hardens and spikes grow from your head as your pupils vanish!{x",user);
						send("{W*{x {M[user.raceColor(user.name)]{x{M 's pupils vanish as spikes grow from [user.determineSex(1)] head... {x",_ohearers(0,user))
						send("{W*{x {M[user.raceColor(user.name)]{x{M folds [user.determineSex(1)] arms across [user.determineSex(1)] chest as a visor slides across [user.determineSex(1)] mouth!{x",_ohearers(0,user))
						send("{MYou fold your arms across your chest as a visor slides over your mouth!{x",user)
						user._doEnergy(-10)
						user.CheckForm()
						mOuter("a sudden surge of energy",user,ov_out(1,12,user));
						user.locked=FALSE
					}
				}
			}
			else{
				syntax(user,syntax);
			}
		}