mob
	var
		tmp
			checkForm = FALSE

	proc
		CheckForm(){
			set waitfor = FALSE;

			if(checkForm){ return; }

			switch(form){
				if("Oozaru"){
					OOZARU();
				}

				if("Super Saiyan"){
					SSJ_1();
				}

				if("Legendary SSJ"){
					LSSJ();
				}

				if("Super Saiyan 2"){
					SSJ_2();
				}

				if("Legendary SSJ2"){
					LSSJ2();
				}

				if("Legendary SSJ3"){
					LSSJ3();
				}

				if("Legendary SSJ4"){
					LSSJ4();
				}

				if("Super Saiyan 3"){
					SSJ_3();
				}

				if("Super Saiyan 4"){
					SSJ_4();
				}

				if("Super Saiyan God"){
					SSJ_GOD();
				}

				if("Super Saiyan Blue"){
					SSJ_B();
				}

				if("Super Saiyan Rose"){
					SSJ_R();
				}

				if("FORM 2"){
					FORM_2();
				}

				if("FORM 3"){
					FORM_3();
				}

				if("FORM 4"){
					FORM_4();
				}

				if("FORM 5"){
					FORM_5();
				}

				if("GOLDEN FORM 4"){
					GOLDEN_FORM_4();
				}

				if("GOLDEN FORM 5"){
					GOLDEN_FORM_5();
				}

				if("Spirit Burst"){
					SPIRIT_BURST();
				}

				if("Kaioken"){
					KAIO_KEN();
				}

				if("Kaioken x2"){
					KAIOKEN(2);
				}

				if("Kaioken x3"){
					KAIOKEN(3);
				}

				if("Kaioken x4"){
					KAIOKEN(4);
				}

				if("Super Kaioken"){
					SUPER_KAIOKEN();
				}

				if("Unlocked"){
					UNLOCKED();
				}

				if("Mystic"){
					MYSTIC();
				}

				if("Ultra Instinct"){
					ULTRA_INSTINCT();
				}

				if("Ultra Instinct Omen"){
					ULTRA_INSTINCT_OMEN();
				}

				if("Enhanced"){
					ENHANCED();
				}

				if("Overclocked") {
					OVERCLOCKED();
				}
			}
		}

		getKLevel(){
			switch(form){
				if("Kaioken x2") return 2
				if("Kaioken x3") return 3
				if("Kaioken x4") return 4
			}
		}

		KAIOKEN(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 30 SECONDS);
				drainTime = (world.time + 20 SECONDS);

			while(src && !unconscious && (form in list("Kaioken x2", "Kaioken x3", "Kaioken x4"))){
				if(world.time >= drainTime){
					_doEnergy(-2*getKLevel())
					drainTime = (world.time + 20 SECONDS);
				}

				if(world.time >= goTime){
					send("[pick("{R[name]'s red aura ripples.{x","{RA bolt of energy streaks around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 30 SECONDS);
				}
				sleep(world.tick_lag)
			}

			if(src && (form in list("Kaioken x2", "Kaioken x3", "Kaioken x4")) && unconscious){
				form = "Normal";
				send("{RYour red aura fades.{x",src,TRUE);
				send("[raceColor(name)]{R's red aura fades.{x",_ohearers(0,src));
				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("{RYour red aura fades.{x",src,TRUE);
				send("[raceColor(name)]{R's red aura fades.{x",_ohearers(0,src));
				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		SUPER_KAIOKEN(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 30 SECONDS);
				drainTime = (world.time + 20 SECONDS);

			while(src && !unconscious && (form in list("Super Kaioken"))){
				if(world.time >= drainTime){
					_doEnergy(-12)
					drainTime = (world.time + 20 SECONDS);
				}

				if(world.time >= goTime){
					send("[pick("{R[name]'s red aura ripples.{x","{RA bolt of energy streaks around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 30 SECONDS);
				}
				sleep(world.tick_lag)
			}

			if(src && (form in list("Super Kaioken")) && unconscious){
				form = "Normal";
				send("{RYour red aura fades.{x",src,TRUE);
				send("[raceColor(name)]{R's red aura fades.{x",_ohearers(0,src));
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("{RYour red aura fades.{x",src,TRUE);
				send("[raceColor(name)]{R's red aura fades.{x",_ohearers(0,src));
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				checkForm = FALSE;
			}else{
				send("{RYour red aura fades.{x",src,TRUE);
				send("[raceColor(name)]{R's red aura fades.{x",_ohearers(0,src));
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				checkForm = FALSE;
			}
		}

		SPIRIT_BURST(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Spirit Burst"){
				if(world.time >= drainTime){
					_doEnergy(-2)
					drainTime = (world.time + 30 SECONDS);
				}

				if(world.time >= goTime){
					send("[pick("{W[name] glows with a white aura.{x","{WA bolt of energy streaks around [name].{x","{WElectricity arcs violently around [name].{x","{WA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Spirit Burst" && unconscious){
				form = "Normal";
				send("{WYour white aura fades.{x",src,TRUE);
				send("[raceColor(name)]{W's white aura fades.{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("{WYour white aura fades.{x",src,TRUE);
				send("[raceColor(name)]{W's white aura fades.{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		OOZARU(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 60 SECONDS);
				revertTime = (world.time + 5 MINUTES);

			while(src && !unconscious && form == "Oozaru"){
				if(world.time >= drainTime){
					_doEnergy(-2)
					drainTime = (world.time + 60 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{R[name] crushes the ground beneath.{x","{R[name] growls and roars!{x","{R[name] beats on their own chest violently!{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}

				if(world.time >= revertTime || !hasTail){
					var/c = percent(currpl,getMaxPL())
					form = "Normal";
					currpl = clamp(ret_percent(c,getMaxPL()), 5, getMaxPL())
				}

				sleep(world.tick_lag)
			}

			if(src && form == "Oozaru" && unconscious){
				form = "Normal";
				send("You shrink and return to your normal size.",src,TRUE);
				send("[raceColor(name)] shrinks and returns to [determineSex(1)] normal size.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("You shrink and return to your normal size.",src,TRUE);
				send("[raceColor(name)] shrinks and returns to [determineSex(1)] normal size.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		SSJ_1(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Super Saiyan"){
				if(world.time >= drainTime){
					_doEnergy(-2)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{Y[name] glows with a golden aura.{x","{YA bolt of energy streaks around [name].{x","{YElectricity arcs violently around [name].{x","{YA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Super Saiyan" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		SSJ_B(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Super Saiyan Blue"){
				if(world.time >= drainTime){
					_doEnergy(-2)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{C[name] glows with a cyan aura.{x","{CA bolt of energy streaks around [name].{x","{CElectricity arcs violently around [name].{x","{CA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Super Saiyan Blue" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}


		SSJ_R(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Super Saiyan Rose"){
				if(world.time >= drainTime){
					_doEnergy(-2)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{M[name] glows with a pink aura.{x","{MA bolt of energy streaks around [name].{x","{MElectricity arcs violently around [name].{x","{MA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Super Saiyan Rose" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		LSSJ(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 15 SECONDS);

			while(src && !unconscious && form == "Legendary SSJ"){
				if(world.time >= drainTime){
					_doEnergy(-8)
					drainTime = (world.time + 15 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{Y[name] glows with a {x{Ggreen{x{Y and gold aura.{x","{YA bolt of {x{Genergy{x{Y streaks around [name].{x","{GElectricity{x{Y arcs violently around [name].{x","{Y[name]'s muscles bulge and contract.{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Legendary SSJ" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		LSSJ2(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 20 SECONDS);

			while(src && !unconscious && form == "Legendary SSJ2"){
				if(world.time >= drainTime){
					_doEnergy(-12)
					drainTime = (world.time + 20 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{Y[name] glows with a {x{Ggreen{x{Y and gold aura.{x","{YA bolt of {x{Genergy{x{Y streaks around [name].{x","{GElectricity{x{Y arcs violently around [name].{x","{Y[name]'s muscles bulge and contract.{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Legendary SSJ2" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		LSSJ3(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 15 SECONDS);

			while(src && !unconscious && form == "Legendary SSJ3"){
				if(world.time >= drainTime){
					_doEnergy(-20)
					drainTime = (world.time + 20 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{Y[name] glows with a {x{Ggreen{x{Y and gold aura.{x","{YA bolt of {x{Genergy{x{Y streaks around [name].{x","{GElectricity{x{Y arcs violently around [name].{x","{Y[name]'s muscles bulge and contract.{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Legendary SSJ3" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}


		LSSJ4(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 15 SECONDS);

			while(src && !unconscious && form == "Legendary SSJ4"){
				if(world.time >= drainTime){
					_doEnergy(-20)
					drainTime = (world.time + 20 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{r[name] glows with a {x{Rred{x{Y and gold aura.{x","{rA bolt of {x{Renergy{x{Y streaks around [name].{x","{rElectricity{x{Y arcs violently around [name].{x","{r[name]'s muscles bulge and contract.{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Legendary SSJ4" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				visuals["height"] = visuals["original_height"]
				visuals["build"] = visuals["original_build"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		KAIO_KEN(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Kaioken"){
				if(world.time >= drainTime){
					_doEnergy(-2)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{R[name] glows with a fiery aura.{x","{RA bolt of energy streaks around [name].{x","{RElectricity arcs violently around [name].{x","{RA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Kaioken" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		UNLOCKED(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);

			while(src && !unconscious && form == "Unlocked"){
				if(world.time >= goTime){
					send("[pick("{W[name] glows with a silver aura.{x","{WA bolt of energy streaks around [name].{x","{WElectricity arcs violently around [name].{x","{WA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Unlocked" && unconscious){
				form = "Normal";
				send("Your silver aura dissipates as your hair falls into place and your eyes lose their sharpness.",src,TRUE);
				send("[raceColor(name)]'s silver aura dissipates as [determineSex(1)] hair falls into place and [determineSex(1)] eyes lose their sharpness.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_style"] = visuals["original_hair_style"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your silver aura dissipates as your hair falls into place and your eyes lose their sharpness.",src,TRUE);
				send("[raceColor(name)]'s silver aura dissipates as [determineSex(1)] hair falls into place and [determineSex(1)] eyes lose their sharpness.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		MYSTIC(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);

			while(src && !unconscious && form == "Mystic"){
				if(world.time >= goTime){
					send("[pick("{W[name] glows with a silver aura.{x","{WA bolt of energy streaks around [name].{x","{WElectricity arcs violently around [name].{x","{WA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Mystic" && unconscious){
				form = "Normal";
				send("Your silver aura dissipates as your hair falls into place and your eyes lose their sharpness.",src,TRUE);
				send("[raceColor(name)]'s silver aura dissipates as [determineSex(1)] hair falls into place and [determineSex(1)] eyes lose their sharpness.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_style"] = visuals["original_hair_style"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your silver aura dissipates as your hair falls into place and your eyes lose their sharpness.",src,TRUE);
				send("[raceColor(name)]'s silver aura dissipates as [determineSex(1)] hair falls into place and [determineSex(1)] eyes lose their sharpness.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		SSJ_2(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Super Saiyan 2"){
				if(world.time >= drainTime){
					_doEnergy(-2)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{Y[name] glows with a golden aura.{x","{YA bolt of energy streaks around [name].{x","{YElectricity arcs violently around [name].{x","{YA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Super Saiyan 2" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		SSJ_3(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);

				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Super Saiyan 3"){
				if(world.time >= drainTime){
					_doEnergy(-3)
					drainTime = (world.time + 30 SECONDS);
				}

				if(world.time >= goTime){
					send("[pick("{Y[name] glows with a golden aura.{x","{YA bolt of energy streaks around [name].{x","{YElectricity arcs violently around [name].{x","{YA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Super Saiyan 3" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		SSJ_4(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);

				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Super Saiyan 4"){
				if(world.time >= drainTime){
					_doEnergy(-3)
					drainTime = (world.time + 30 SECONDS);
				}

				if(world.time >= goTime){
					send("[pick("{RA bolt of energy streaks around [name].{x","{RElectricity arcs violently around [name].{x","{RA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Super Saiyan 4" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		SSJ_GOD(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);

			while(src && !unconscious && form == "Super Saiyan God"){
				if(world.time >= goTime){
					send("[pick("{R[name] glows with a {x{rfiery{x{R red aura.{x","{RA bolt of energy streaks around [name].{x","{RElectricity arcs violently around [name].{x","{RA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					_doEnergy(-3)
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Super Saiyan God" && unconscious){
				form = "Normal";
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("Your hair falls into place, and your eyes return to their natural color.",src,TRUE);
				send("[raceColor(name)]'s hair falls into place, and [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		FORM_2(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "FORM 2"){
				if(world.time >= drainTime){
					_doEnergy(-1)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{MA bolt of energy streaks around [name].{x","{MElectricity arcs violently around [name].{x","{MA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "FORM 2" && unconscious){
				form = "FORM 1";
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "FORM 1"){
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		FORM_3(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "FORM 3"){
				if(world.time >= drainTime){
					_doEnergy(-1)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{MA bolt of energy streaks around [name].{x","{MElectricity arcs violently around [name].{x","{MA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "FORM 3" && unconscious){
				form = "FORM 1";
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "FORM 1"){
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		FORM_4(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "FORM 4"){
				if(world.time >= drainTime){
					_doEnergy(-2)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{MA bolt of energy streaks around [name].{x","{MElectricity arcs violently around [name].{x","{MA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "FORM 4" && unconscious){
				form = "FORM 1";
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "FORM 1"){
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		FORM_5(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "FORM 5"){
				if(world.time >= drainTime){
					_doEnergy(-3)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{MA bolt of energy streaks around [name].{x","{MElectricity arcs violently around [name].{x","{MA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "FORM 5" && unconscious){
				form = "FORM 1";
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "FORM 1"){
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		GOLDEN_FORM_4(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "GOLDEN FORM 4"){
				if(world.time >= drainTime){
					_doEnergy(-3)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{YA bolt of energy streaks around [name].{x","{YElectricity arcs violently around [name].{x","{YA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "GOLDEN FORM 4" && unconscious){
				form = "FORM 1";
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "FORM 1"){
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		GOLDEN_FORM_5(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "GOLDEN FORM 5"){
				if(world.time >= drainTime){
					_doEnergy(-3)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{YA bolt of energy streaks around [name].{x","{YElectricity arcs violently around [name].{x","{YA bolt of energy arcs around [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "GOLDEN FORM 5" && unconscious){
				form = "FORM 1";
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "FORM 1"){
				send("{MYou revert!{x",src,TRUE);
				send("[raceColor(name)]{M reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		ULTRA_INSTINCT_OMEN(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 600);
				drainTime = (world.time + 20 SECONDS);

			while(src && !unconscious && form == "Ultra Instinct Omen"){
				if(world.time >= drainTime){
					_doEnergy(-8)
					drainTime = (world.time + 20 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{W[name] glows with a surreal {Bblue{W and {wsilver{W aura.{x","{WAn intense {Cbolt{W of energy streaks around [name].{x","{BElectricity{W violently arcs around [name].{x","{WThe {Rheat{W around [name] distorts their visage.{x","{WWaves of {rpressure{W and {Rheat{W roll away from [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 600);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Ultra Instinct Omen" && unconscious){
				form = "Normal";
				send("The heat around you dissipates and your aura flares away as your eyes return to their natural color.",src,TRUE);
				send("The heat around [raceColor(name)] dissipates and [determineSex(1)] aura flares away as [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("The heat around you dissipates and your aura flares away as your eyes return to their natural color.",src,TRUE);
				send("The heat around [raceColor(name)] dissipates and [determineSex(1)] aura flares away as [determineSex(1)] eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		ULTRA_INSTINCT(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 600);
				drainTime = (world.time + 20 SECONDS);

			while(src && !unconscious && form == "Ultra Instinct"){
				if(world.time >= drainTime){
					_doEnergy(-8)
					drainTime = (world.time + 20 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{W[name] glows with a surreal {Bblue{W and {wsilver{W aura.{x","{WAn intense {Cbolt{W of energy streaks around [name].{x","{BElectricity{W violently arcs around [name].{x","{WThe {Rheat{W around [name] distorts their visage.{x","{WWaves of {rpressure{W and {Rheat{W roll away from [name].{x")]",_ohearers(0,src))
					goTime = (world.time + 600);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Ultra Instinct" && unconscious){
				form = "Normal";
				send("The heat around you dissipates and your aura flares away as your hair and eyes return to their natural color.",src,TRUE);
				send("The heat around [raceColor(name)] dissipates and [determineSex(1)] aura flares away as [determineSex(1)] hair and eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("The heat around you dissipates and your aura flares away as your hair and eyes return to their natural color.",src,TRUE);
				send("The heat around [raceColor(name)] dissipates and [determineSex(1)] aura flares away as [determineSex(1)] hair and eyes return to their natural color.",_ohearers(0,src));

				/*
				RESTORE APPERANCE
				*/
				visuals["hair_length"] = visuals["original_hair_length"]
				visuals["hair_color"] = visuals["original_hair_color"]
				visuals["hair_style"] = visuals["original_hair_style"]
				visuals["eye_color"] = visuals["original_eye_color"]
				/*
				END RESTORE APPEARANCE
				*/

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		ENHANCED(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 1200);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Enhanced"){
				if(world.time >= drainTime){
					_doEnergy(-3)
					drainTime = (world.time + 30 SECONDS);
				}
				if(world.time >= goTime){
					send("[pick("{WA bolt of energy streaks around [name].{x","{WElectricity arcs violently around [name].{x","{WA bolt of energy arcs around [name].{x","{W[name] glows.{x")]",_ohearers(0,src))
					goTime = (world.time + 1200);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Enhanced" && unconscious){
				form = "Normal";
				send("{WYou revert!{x",src,TRUE);
				send("[raceColor(name)]{W reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "Normal"){
				send("{WYou revert!{x",src,TRUE);
				send("[raceColor(name)]{W reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}

		OVERCLOCKED(){
			set waitfor = FALSE;
			set background = TRUE;

			checkForm = TRUE;

			var/
				goTime = (world.time + 60 SECONDS);
				drainTime = (world.time + 30 SECONDS);

			while(src && !unconscious && form == "Overclocked"){
				if(world.time >= drainTime){
					_doEnergy(-6)
					drainTime = (world.time + 30 SECONDS);

					// Extra Damage
					var randExtraDamage = rand(1,100);
					if(randExtraDamage > 95) {
						var damageAmount = pick(-2,-5,-10,-20,-30);
						_doEnergy(damageAmount);
						send("{r[src.name] body begins {Roverheating{r. [determineSex(2)] attempt to compensate",_ohearers(0,src));
						send("{rYou feel your body {Roverheating{r. You attempt to compensate.{x",src);
					}
				}
				if(world.time >= goTime){
					var randArea = pick("chest", "left arm", "right arm", "body", "back", "shoulders");
					var randSize = pick("tiny", "small", "large", "huge");
					var randType = pick("spews", "shoots", "launches");
					send("{yA [randSize] spark [randType] from {Y[name]'s{y [randArea].{x",_ohearers(0,src));
					send("{yA [randSize] spark [randType] from your [randArea].{x",src);

					goTime = (world.time + 600 SECONDS);
				}
				sleep(world.tick_lag)
			}

			if(src && form == "Overclocked" && unconscious){
				form = "NeoMachine";
				send("{WYou revert!{x",src,TRUE);
				send("[raceColor(name)]{W reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else if(src && form == "NeoMachine"){
				send("{WYou revert!{x",src,TRUE);
				send("[raceColor(name)]{W reverts!{x",_ohearers(0,src));

				checkForm = FALSE;
			}else{
				checkForm = FALSE;
			}
		}
