Command/Technique/Form
	icer_goldform
		name = "goldform"
		internal_name = "goldform"
		format = "~goldform";
		priority = 3
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "FORM 5"
		helpDescription = "Icer's final transformation makes them one of the most feared races in the galaxy. Stronger armor and new unlocked potential provides the Icer a significant boost in the strength, armor and overall raw power to destroy their enemies."

		command(mob/user) {
			if(user){
				if(user.form == "FORM 4" || user.form == "FORM 5"){

					user.locked=TRUE;
					send("{YYou grin evily as your body begins to emit an intense golden light.{x",user)
					send("{W*{x {M[user.raceColor(user.name)]{x{M grins evily as their body begins to emit an intense golden light..." ,_ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user._doEnergy(-10);
					user.checkForm = FALSE;

					if(user.form == "FORM 4"){
						user.form = "GOLDEN FORM 4";
					}else if(user.form == "FORM 5"){
						user.form = "GOLDEN FORM 5";
					}

					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					alaparser.parse(user, "yell TIME TO WITNESS TRUE POWER!!!", list());
					send("{YYou transform into your ultimate form!{x",user);
					send("{W*{x {M[user.raceColor(user.name)]{x{Y transforms into their ultimate form!{x",_ohearers(0,user))
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a sudden surge of energy",user,ov_out(1,12,user));
					user.locked=FALSE
				}else{
					send("You can't do this right now!\n",user);
				}
			}
			else{
				syntax(user,syntax);
			}
		}