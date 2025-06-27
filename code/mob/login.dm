
#define timeOut 3 MINUTES

proc/defaultAlias(playerName){
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'ph', 'parry high');")
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'pl', 'parry low');")
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'rp', 'punch right');")
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'lp', 'punch left');")
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'lk', 'kick left');")
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'rk', 'kick right');")
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'rh', 'roundhouse');")
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'dr', 'dodge right');")
	_query("INSERT INTO `aliases` (owner, command, function) VALUES ('[playerName]', 'dl', 'dodge left');")
}

proc/newCopyOverCheck(client/c){
	if(fexists("copyover/players/[rot13("[c]")]")){
		var
			X = file("copyover/players/[rot13("[c]")]");
			savefile/F = new(X);
			playerName = F["mob"];

		c.mob:loadCharacter(playerName,TRUE);

		fdel(X);

		del(F);

		return TRUE;
	}

	return FALSE;
}

proc/copyOverCheck(client/c){
	if(fexists("copyover/players/[rot13("[c]")]")){
		var
			X = file("copyover/players/[rot13("[c]")]");
			savefile/F = new(X);
			mob/Player/m = F["mob"];
			Sx = text2num(F["x"]);
			Sy = text2num(F["y"]);
			Sz = text2num(F["z"]);

		m.lifeTick = world.time;

		m.loc=locate(Sx,Sy,Sz);

		m.loadAliases();

		c.mob = m;

		fdel(X);

		del(F);

		return TRUE;
	}

	return FALSE;
}

mob
	cClient

		New(){
			..()
			idleTimer()
		}

		var
			mob/Player/mobRef = NULL; // Used to reference our character we are creating.


		proc/idleTimer(){
			set waitfor=FALSE;

			while(src){

				if(get_life() > timeOut){
					send("\n\nYou have idled out...",src,TRUE);
					game.logger.info("[name] idled out...");
					if(mobRef){ mobRef.clean(); } // Delete our character in the progress of creation if we have one.
					sleep(1 TICKS);
					del(src);
				}

				sleep(world.tick_lag)
			}
		}

		cColor = 1

		Login(){
			if(newCopyOverCheck(client)){
				return;
			}else{
				new /outputBuffer(src);

				send(readFile("login"),src)

				if(client.address in game.banned_ips){
					send("You are banned from [game.name]!",src)
					sleep(1)
					del(src)
				}

				name:

				client.state = STATE_LOGIN;

				lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

				name = input_text("Name:",src)

				name = replacetext(name,"Ore.Supports.Set \[]","") // temp fix for mudlet hakky bro

				if(game.banned_players.Find(lowertext(name))){
					send("You are banned from [game.name]!",src)
					sleep(1)
					del(src)
				}

				if(game.locked && !game.immCheck(name)){
					send("[game.name] is Wizlocked!",src)
					sleep(1)
					del(src)
				}

				name = capFirstL(name)

				var
					rowCount = _rowCount("FROM `characters` WHERE `name`='[sanit(name)]' COLLATE NOCASE;")

				sleep(1)

				if(rowCount > 0){
					var
						database/query/q = _query("SELECT `password` FROM `characters` WHERE `name`='[sanit(name)]' COLLATE NOCASE;")
						list/rowData

					q.NextRow()
					rowData = q.GetRowData()

					lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

					//world << md5("LOL")
					//send(md5(crypto_salt+"[client.ctype==BYOND?input_text("Password:",src):input_password("Password:",src)]"),src,TRUE);
					if(md5(crypto_salt+"[client.ctype==BYOND?input_text("Password:",src):input_password("Password:",src)]") == rowData["password"]){
						if(!game.multiplay && game.checkClient(client, name)){
							send("Multiplay disabled.",src,TRUE)
							sleep(1)
							goto name:
						}else{
							if(!game.checkOnline(name)){
								loadCharacter(name)
							}
							else{
								lifeTick = world.time; // Update our life tick to the current time so we don't idle out.
								if(input_confirm("[name] is currently connected do you wish to connect anyways?",src)){
									game._connectPlayer(src.client,name)
									return
								}
								else{
									sleep(1)
									goto name:
								}
							}
						}
					}else{
						game.logger.warn("Failed login attempt for [name] @ [client.address]")
						send(api_response,src)
						send("Bad password!",src)
						sleep(1)
						goto name:
					}
				}else{

					if(!Review_Name(name) && input_confirm(name,src)){
						if(!game.multiplay && game.checkClient(client, name)){
							send("Multiplay disabled.",src,TRUE)
							sleep(1)
							goto name:
						}

						client.state = STATE_CREATION;

						var
							password
							confirmPassword

						password:

						lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

						if(client.ctype==BYOND){
							password = input_text("\nPassword: ",src)
						}else{
							password = input_password("\nPassword: ",src)
						}

						if(Review_Password(password)) goto password:

						lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

						if(client.ctype==BYOND){
							confirmPassword = input_text("\nConfirm Password: ",src)
						}else{
							confirmPassword = input_password("\nConfirm Password: ",src)
						}

						if(password == confirmPassword){
							var
								race
								mob/Player/newMob = NULL;

							email:

							lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

							email = input_text("\nEmail: ",src)

							if(Review_Email(email)){
								sleep(1)
								goto email:
							}

							send("\nPlease choose a race.",src)
							send("{G*{x {cSaiyan{x",src)
							send("{G*{x {CHalfbreed{x",src)
							send("{G*{x {yHuman{x",src)
							send("{G*{x {gNamekian{x",src)
							send("{G*{x {DAndroid{x",src)
							send("{G*{x {mIcer{x",src)
							send("{G*{x {wKaio{x",src)
							send("{G*{x {MGenie{x",src)
							send("{G*{x {rDemon{x",src)
							send("{G*{x {bAlien{x",src)
							send("{G*{x {GBio-Android{x",src)
							send("{G*{x {WSpirit{x",src)
							send("{D*{x {bKanassan{x {R({YCOMING SOON{x{R){x",src)
							send("{D*{x {rMutant{x {R({YCOMING SOON{x{R){x",src)


							lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

							race = input_selection("What is your race?",list("Saiyan","Human","Namekian","Android","Icer","Halfbreed","Kaio","Genie","Demon","Alien","Bio-Android", "Spirit"),src,selection="race")

							switch(race){
								if("Saiyan"){
									if(rand(1,10000) != 777) {
										newMob = new /mob/Player/Saiyan()
										mobRef = newMob; // Reference for if we idle out.
										newMob.canSave = FALSE;

										newMob.race = SAIYAN
										newMob.currpl = 250
										newMob.maxpl = 250
										newMob.curreng = 100
										newMob.maxeng = 100
										newMob.sex = sex()
										newMob.alignment = alignment()
										newMob.visuals["skin_color"] = skin_color(newMob.race)
										newMob.visuals["eye_color"] = eye_color(newMob.race)
										newMob.visuals["hair_length"] = hair_length()
										newMob.visuals["hair_style"] = hair_style(newMob.visuals["hair_length"])
										newMob.visuals["hair_color"] = hair_color(newMob.race)
										newMob.visuals["height"] = height()
										newMob.visuals["build"] = build()
									} else {
										newMob = new /mob/Player/Legendary_Saiyan()
										mobRef = newMob; // Reference for if we idle out.
										newMob.canSave = FALSE;

										newMob.race = LEGENDARY_SAIYAN
										newMob.currpl = 5000
										newMob.maxpl = 5000
										newMob.curreng = 150
										newMob.maxeng = 150
										newMob.sex = sex()
										newMob.alignment = alignment()
										newMob.visuals["skin_color"] = skin_color(newMob.race)
										newMob.visuals["eye_color"] = eye_color(newMob.race)
										newMob.visuals["hair_length"] = hair_length()
										newMob.visuals["hair_style"] = hair_style(newMob.visuals["hair_length"])
										newMob.visuals["hair_color"] = hair_color(newMob.race)
										newMob.visuals["height"] = height()
										newMob.visuals["build"] = build()
									}
								}
								if("Halfbreed"){
									newMob = new /mob/Player/Halfbreed()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = HALFBREED
									newMob.currpl = 225
									newMob.maxpl = 225
									newMob.curreng = 108
									newMob.maxeng = 108
									newMob.sex = sex()
									newMob.alignment = alignment()
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = hair_length()
									newMob.visuals["hair_style"] = hair_style(newMob.visuals["hair_length"])
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Kanassan"){
									newMob = new /mob/Player/Kanassan()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = KANASSAN
									newMob.currpl = 250
									newMob.maxpl = 250
									newMob.curreng = 100
									newMob.maxeng = 100
									newMob.sex = sex()
									newMob.alignment = alignment()
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = "None"
									newMob.visuals["hair_style"] = "None"
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Alien"){
									newMob = new /mob/Player/Alien()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = ALIEN
									newMob.currpl = 300
									newMob.maxpl = 300
									newMob.curreng = 100
									newMob.maxeng = 100
									newMob.sex = sex()
									newMob.alignment = alignment()
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = "None"
									newMob.visuals["hair_style"] = "None"
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Bio-Android"){
									newMob = new /mob/Player/Bio_Android()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = BIO_ANDROID
									newMob.form = "Imperfect"
									newMob.currpl = 300
									newMob.maxpl = 300
									newMob.curreng = 100
									newMob.maxeng = 100
									newMob.sex = sex()
									newMob.alignment = EVIL
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = "None"
									newMob.visuals["hair_style"] = "None"
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Human"){
									newMob = new /mob/Player/Human()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = HUMAN
									newMob.currpl = 200
									newMob.maxpl = 200
									newMob.curreng = 100
									newMob.maxeng = 100
									newMob.sex = sex()
									newMob.alignment = alignment()
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = hair_length()
									newMob.visuals["hair_style"] = hair_style(newMob.visuals["hair_length"])
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Spirit"){
									newMob = new /mob/Player/Spirit()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = SPIRIT
									newMob.form = "Phantasm"
									newMob.currpl = 180
									newMob.maxpl = 180
									newMob.curreng = 120
									newMob.maxeng = 120
									newMob.sex = sex()
									newMob.alignment = alignment()
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = hair_length()
									newMob.visuals["hair_style"] = hair_style(newMob.visuals["hair_length"])
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Namekian"){
									newMob = new /mob/Player/Namekian()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = NAMEK
									newMob.currpl = 275
									newMob.maxpl = 275
									newMob.curreng = 100
									newMob.maxeng = 100
									newMob.sex = MALE
									newMob.alignment = alignment()
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = "None"
									newMob.visuals["hair_style"] = "Antennae"
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Genie"){
									newMob = new /mob/Player/Genie()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = GENIE
									newMob.currpl = 375
									newMob.maxpl = 375
									newMob.curreng = 100
									newMob.maxeng = 100
									newMob.sex = MALE
									newMob.alignment = alignment()
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = "None"
									newMob.visuals["hair_style"] = "Antennae"
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Android"){
									newMob = new /mob/Player/Android()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = ANDROID
									newMob.currpl = 300
									newMob.maxpl = 300
									newMob.curreng = 105
									newMob.maxeng = 105
									newMob.sex = sex()
									newMob.alignment = EVIL
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = hair_length()
									newMob.visuals["hair_style"] = hair_style(newMob.visuals["hair_length"])
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Icer"){
									newMob = new /mob/Player/Icer()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = ICER
									newMob.form = "FORM 1"
									newMob.currpl = 300
									newMob.maxpl = 300
									newMob.curreng = 100
									newMob.maxeng = 100
									newMob.sex = sex()
									newMob.alignment = EVIL
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = "None"
									newMob.visuals["hair_style"] = "Bald"
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Kaio"){
									newMob = new /mob/Player/Kaio()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = KAIO
									newMob.currpl = 225
									newMob.maxpl = 225
									newMob.curreng = 100
									newMob.maxeng = 100
									newMob.sex = sex()
									newMob.alignment = alignment()
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = hair_length()
									newMob.visuals["hair_style"] = hair_style(newMob.visuals["hair_length"])
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
								if("Demon"){
									newMob = new /mob/Player/Demon()
									mobRef = newMob; // Reference for if we idle out.
									newMob.canSave = FALSE;

									newMob.race = DEMON
									newMob.currpl = 250
									newMob.maxpl = 250
									newMob.curreng = 110
									newMob.maxeng = 110
									newMob.sex = sex()
									newMob.alignment = EVIL
									newMob.visuals["skin_color"] = skin_color(newMob.race)
									newMob.visuals["eye_color"] = eye_color(newMob.race)
									newMob.visuals["hair_length"] = hair_length()
									newMob.visuals["hair_style"] = "Horns"
									newMob.visuals["hair_color"] = hair_color(newMob.race)
									newMob.visuals["height"] = height()
									newMob.visuals["build"] = build()
								}
							}

							/*Original Visuals*/
							newMob.visuals["original_skin_color"] = newMob.visuals["skin_color"]
							newMob.visuals["original_eye_color"] = newMob.visuals["eye_color"]
							newMob.visuals["original_hair_length"] = newMob.visuals["hair_length"]
							newMob.visuals["original_hair_style"] = newMob.visuals["hair_style"]
							newMob.visuals["original_hair_color"] = newMob.visuals["hair_color"]
							newMob.visuals["original_height"] = newMob.visuals["height"]
							newMob.visuals["original_build"] = newMob.visuals["build"]
							/*Original Visuals*/

							newMob.name = name

							newMob.spawnHomeWorld(newMob.race);

							newMob.currpl = newMob.getMaxPL();
							newMob.curreng = newMob.getMaxEN();

							client.mob = newMob

							newMob.password=md5(crypto_salt+password)
							newMob.email=email

							newMob.canSave = TRUE
							defaultAlias(newMob.name)
							newMob.saveSQLCharacter()

							newMob.loadAliases();

							alaparser.parse(newMob,"help newbie",list());

							del(src)
						}
						else{
							send("Incorrect password.",src)
							sleep(1)
							goto name:
						}
					}
					else{
						sleep(1)
						goto name:
					}
				}
			}
		}
