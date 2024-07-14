Command/Technique/Form
	form_2
		name = "form2"
		internal_name = "form 2"
		format = "~form2";
		priority = 3
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "FORM 2"
		helpDescription = "Young Icer's first transformation makes them bigger, bulkier and produce a pair of horns from their head making them stronger."

		command(mob/user) {
			if(user){
				if(user.form != "FORM 1"){
					send("You are already in the [user.form] form!",user)
				}else{
					user.locked=TRUE;
					send("{MYour skin begins to crawl as your muscles ripple with power...{x",user)
					send("{W*{x {M[user.raceColor(user.name)]{x{M's muscles begin to ripple with power as, [user.determineSex(1)] horns elongate..." ,_ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "FORM 2"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{MYour muscles buldge as you grow in height!{x",user);
					send("{W*{x {M[user.raceColor(user.name)]{x{M gains in muscle mass, and becomes much taller!{x",_ohearers(0,user))
					send("{W*{x {M[user.raceColor(user.name)]{x{M has reached [user.determineSex(1)] second form!{x",_ohearers(0,user))
					send("{MYou ascend into your second form!{x",user)
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
