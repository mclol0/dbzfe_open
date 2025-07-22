mob
	NPA
		freezer
			FriezaSlaver
				name = "Frieza's Slaver"
				race = MUTANT
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/blast, /Command/Technique/elbow, /Command/Technique/tail_whip)
				teach = list("blast","summon")

				visuals = list("skin_color" = "{RRed{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "{DBlack{x",
								"height" = "Tall",
								"build" = "Muscular")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(15000,25000)
					currpl = maxpl
					..()
				}
			IcerianSlave
				name = "Icerian Slave"
				race = MUTANT
				sex = UNKNOWN
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = VERY_EASY;
				curreng = 100
				maxeng = 100

				teach = list("tailwhip")

				visuals = list("skin_color" = "{WPale{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(3000,7000)
					currpl = maxpl
					..()
				}
			YoungIcer
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="FORM 1"){
								form="FORM 1"
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] shrinks back down to their original size!",_ohearers(0,src))
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="FORM 1"){
								if(currpl < 100000){
									powering=FALSE
									form="FORM 2"
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] {Mmuscles bulge with power as they grow in height{x!",_ohearers(0,src))
									if (teachDelayed[form]) {
										teach = teachDelayed[form]
									}
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Young Icer"
				form = "FORM 1"
				race = ICER
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HARD;
				curreng = 100
				maxeng = 100
				teachDelayed = list("FORM 2" = list("form 2","eye laser"))
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/tail_whip,
						/Command/Technique/eye_laser, /Command/Technique/Form/form_2)

				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "{mPurple{x",
								"hair_length" = "None",
								"hair_style" = "Horns",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Skinny")
				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(250000,350000)
					currpl = maxpl
					..()
				}
			IcerianWarrior
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="FORM 2"){
								form="FORM 2"
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] shrinks back down to their original size!",_ohearers(0,src))
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="FORM 2"){
								if(currpl < 150000){
									powering=FALSE
									form="FORM 3"
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] {Mhunches over as their head elongates and spikes erupt from their body{x!",_ohearers(0,src))
									teach = list("form 3")
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Icerian Warrior"
				form = "FORM 2"
				race = ICER
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/tail_whip,
						/Command/Technique/eye_laser, /Command/Technique/death_beam)
				visuals = list("skin_color" = "{MPink{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Horns",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Toned")
				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(750000,1250000)
					currpl = maxpl
					..()
				}
			Cooler
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="FORM 4"){
								form="FORM 4"
								maxpl=1.20e+010
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="FORM 4"){
								if(currpl < 7.25e+090){
									form="FORM 5"
									maxpl=1.30e+010
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] grins wickedly as amorphous armor enwraps him and a slitted visor slides over his mouth!",_ohearers(0,src))
									teach = list("form 5","deathball")
								}
							}
						}
						sleep(world.tick_lag)
					}
				}

				name = "Cooler"
				form = "FORM 4"
				race = ICER
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = FUSION;
				currpl = 1.20e+010
				maxpl = 1.20e+010
				curreng = 170
				maxeng = 170
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/tail_whip,
						/Command/Technique/eye_laser, /Command/Technique/death_beam, /Command/Technique/blast)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

			FriezaReborn
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="FORM 4"){
								form="FORM 4"
								maxpl=7.75e+011
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="FORM 4"){
								if(currpl < 3.75e+011){
									form="FORM 5"
									maxpl=7.75e+011
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "say OOh have I got a treat for you!", list())
									send("[raceColor(name)] grins wickedly as golden armor slides over his skin!",_ohearers(0,src))
								}
							}
						}
						sleep(world.tick_lag)
					}
				}

				name = "Frieza Reborn"
				form = "FORM 4"
				race = ICER
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = FUSION;
				currpl = 7.75e+011
				maxpl = 7.75e+011
				curreng = 170
				maxeng = 170
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/tail_whip,
						/Command/Technique/eye_laser, /Command/Technique/death_beam, /Command/Technique/blast)
				dropList = list(/obj/item/FRIEZAS_BATTLE_ARMOR_FRAGMENTS)

				visuals = list("skin_color" = "{wWhite{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Toned")

			Neiz
				name = "Neiz"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = INSANE;
				currpl = 200000000
				maxpl = 200000000
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/freezer/Dore, /mob/NPA/freezer/Salza)
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/masenko,
						/Command/Technique/blast)

				visuals = list("skin_color" = "{yBrown{x",
								"eye_color" = "{YYellow{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Muscular")


			Dore
				name = "Dore"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = INSANE;
				currpl = 225000000
				maxpl = 225000000
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/freezer/Neiz, /mob/NPA/freezer/Salza)
				randomRespawn = FALSE;
				dropList = list(/obj/item/DORES_HELMET)
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/masenko,
						/Command/Technique/blast)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{mPurple{x",
								"hair_length" = "Long",
								"hair_style" = "Spiked",
								"hair_color" = "{DBlack{x",
								"height" = "Tall",
								"build" = "Muscular")

			Salza
				name = "Salza"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = INSANE;
				currpl = 250000000
				maxpl = 250000000
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/freezer/Dore, /mob/NPA/freezer/Neiz)
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/masenko,
						/Command/Technique/blast)

				visuals = list("skin_color" = "{CCyan{x",
								"eye_color" = "{yBrown{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "{YBlonde{x",
								"height" = "Average",
								"build" = "Toned")