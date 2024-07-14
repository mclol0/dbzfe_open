Command/Technique/Form
	ultrainstinctomen
		name = "ultrainstinctomen"
		internal_name = "ultrainstinctomen"
		format = "~omen";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Ultra Instinct Omen"

		getDescription() {
			return ..("Breaking into the power deep within a fighter's soul and tapping into glimpses of divine power, a character is able to enter into a special transformation that allows him to see signs of the future, thus enabling him to effectively dodge their way in battle. While not as powerful as other known transformations in the universe, it still provides a slight boost to strength and resistance, but it's real benefits come from the insights into the future.\n\n{YThis form can only be triggered during combat when in dire circumstances.{x")
		}

		getSyntax() {
			return NULL
		}

		command(mob/user) {
			if(user){
				if(user.form != "Normal"){
					send("You are already in the [user.form] form!",user)
				}else if(!locate(/Command/Technique/Form/ultrainstinct) in user.techniques){
					send("You can't do that!",user)
				}else{
					user.locked = TRUE;
					send("{WYou close your eyes as a faint {Bblue{W and {wsilver{W aura outlines your body...{x",user)
					send("{W* [user.raceColor(user.name)] closes [user.determineSex(1)] eyes as a faint {Bblue{W and {wsilver{W aura outlines [user.determineSex(1)] body...{x",_ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.activatedUI = TRUE;
					user.form = "Ultra Instinct Omen"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())

					send("{WA {Rhot {Bblue{W and {wsilver{W aura explodes around you as you open your {wsilver{W eyes.{x",user)
					send("{WYou have achieved an {Romen{W of the divine power known as {BUltra Instinct{W!{x",user)
					send("{W* A {Rhot{W {Bblue{W and {wsilver{W aura explodes around [user.raceColor(user.name)] as [user.determineSex(3)] opens [user.determineSex(1)] {wsilver{W eyes.{x",_ohearers(0,user))
					send("{W* [user.raceColor(user.name)] has achieved an {Romen{W of the divine power known as {BUltra Instinct{W!",_ohearers(0,user))
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{wSilver{x"
					user.CheckForm()
					mOuter("an unbelievable surge of energy",user,ov_out(1,12,user));
					user.locked = FALSE;
				}
			}
			else{
				syntax(user,syntax);
			}
		}

	ultrainstinct
		name = "ultrainstinct"
		internal_name = "ultrainstinct"
		format = "~ultrainstinct";
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		formName = "Ultra Instinct"

		getDescription () {
			return ..("Reaching the final state of the transformation. The character is now able to take this form whenever he pleases, allowing him to constantly tap into their divine power gaing a substantial increase in their power while also keeping their benefits of seeing into the future.")
		}

		command(mob/user) {
			if(user){
				if(user.form != "Ultra Instinct Omen"){
					send("You cannot attain the godliness of Ultra Instinct without first tapping into Ultra Instinct Omen!",user)
				}else{
					user.locked = TRUE;
					send("{WYour hair spikes up and a bright light envelopes you! The {Rhot{W aura around you expands rapidly!{x",user)
					send("{W*{x [user.raceColor(user.name)]{W's hair spikes up as they are enveloped in a blinding bright light!  The {Rhot{W aura around them expands rapidly!{x",_ohearers(0,user))
					sleep(10)
					var/c = percent(user.currpl,user.getMaxPL())
					user.form = "Ultra Instinct"
					user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
					send("{WThe light breaks away and the enormous, sparkling hot aura around you suddenly absorbs into you!{x",user)
					send("{WYour hair turns {wsilver{W and you are enveloped in a {Rhot{W, surreal {Bblue{W and {wsilver{W aura!{x",user)
					send("{WYou have completed the {RFULL POWER{W of {BULTRA INSTINCT{W!{x",user)
					send("{W*{x {WThe blinding light breaks away and the enormous, sparkling hot aura around [user.raceColor(user.name)]{W suddenly disappears!{x",_ohearers(0,user))
					send("{W*{x {W[user.raceColor(user.name)]{W's hair has turned {wsilver{W, and they're enveloped in a {Rhot{W, surreal {Bblue{W and {wsilver{W aura!{x",_ohearers(0,user))
					if(user.visuals["hair_style"] != "Bald"){
						user.visuals["hair_color"] = "{wSilver{x"
						user.visuals["hair_style"] = "Spiked"
					}
					user.visuals["eye_color"] = "{wSilver{x"
					user._doEnergy(-10)
					user.CheckForm()
					mOuter("an unimaginably massive surge of energy",user,ov_out(1,12,user));
					emitMessage(user,ov_out(16,256,user),"{WA blinding light in the distance lights up the sky...{x",2.5 MINUTES);
					user.locked = FALSE;
				}
			}
			else{
				syntax(user,syntax);
			}
		}