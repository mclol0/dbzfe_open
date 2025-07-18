Command/Technique/Form
	phaseshift
		name = "phase-shift"
		internal_name = "phase-shift"
		format = "~phase-shift";
		priority = 1
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Phase-Shift"
		helpDescription = "Your body flickers between dimensions, destabilizing your presence and amplifying your potential."

		command(mob/user) {
			if(user){
				if(user.form != "Normal"){
					send("You are already in [user.form] form!",user)
				}else{
					user.locked=TRUE;
					send("{mYour body begins to blur at the edges, vibrating between two phases...{x", user)
					send("{W*{x [user.raceColor(user.name)] {Wbegins to shimmer, their form phasing in and out of visibility!{x", _ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl, user.getMaxPL())
					user.form = formName
					user.currpl = clamp(ret_percent(c, user.getMaxPL()), 5, user.getMaxPL())
					send("{MYour skin pulses with light as you start flickering between dimensions.{x", user)
					send("{W*{x [user.raceColor(user.name)]{W's outline shifts and jitters, eyes glowing with a{x {Mpurple hue{x{W.{x", _ohearers(0,user))
					send("{W*{x [user.raceColor(user.name)]{W enters the{x {MPhase-Shift{x {Wform, his body flicking in and out of existence!{x", _ohearers(0,user))
					send("{mYou enter the{x {MPhase-Shift{x {mform.{x", user)
					user.visuals["eye_color"] = "{MPurple{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("a wave of flickering spatial distortion", user, ov_out(1,12,user))
					user.locked = FALSE
				}
			}
		}