Command/Public
	simultaneous
		name = "simultaneous"
		format = "~simultaneous";
		canUseWhileRESTING = TRUE;
		helpDescription = "{Ctoggle between {Ysingle {Cand {Ysimultaneous {Cfighting style. While active, allows you to block/dodge without interrupting attacks. Missing a block will stop any current attack as a penalty. Taking hits will not interrupt attacks. If you have simultaneous mode active against an opponent who does not, you will suffer a 15% DMG reduction.\n\n{YNote: All npc's will automatically match your simultaneous on/off toggle.{x"
		helpCategory = "Advanced Combat"

		command(mob/user) {
			if(user.fCombat._hostiles()){
				send("You can't change your fighting style mid fight!",user,TRUE);
				return;
			}

			switch(user.simultaneous){
				if(TRUE){
					send("Simultaneous combat is now disabled.",user);
					user.simultaneous = FALSE;
				}

				if(FALSE){
					send("Simultaneous combat is now enabled.",user);
					user.simultaneous = TRUE;
				}
			}
		}