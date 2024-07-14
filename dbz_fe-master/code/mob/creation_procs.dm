mob
	proc
		determineSex(type,YOU=FALSE){
			if(YOU) { return "your"; }

			if(type == 1){
				switch(sex){
					if(MALE){
						return "his";
					}
					if(FEMALE){
						return "her";
					}
					if(UNKNOWN){
						return "their";
					}
				}
				game.logger.warn("[type] determined wrong sex value from [name].")
			}
			else if(type == 2){
				switch(sex){
					if(MALE){
						return "him";
					}
					if(FEMALE){
						return "her";
					}
					if(UNKNOWN){
						return "it";
					}
				}
				game.logger.warn("[type] determined wrong sex value from [name].")
			}
			else if(type == 3){
				switch(sex){
					if(MALE){
						return "he";
					}
					if(FEMALE){
						return "she";
					}
					if(UNKNOWN){
						return "they";
					}
				}
				game.logger.warn("[type] determined wrong sex value from [name].")
			}
			else{
				game.logger.error("[type] invalid value type.")
			}
		}

		tutorial(){
			send("{R**{x {rTUTORIAL RECOMENDED{x {R**{x",src)
			var/choice = input_selection("Do the tutorial? \[Y/N\]",list("Y","N"),src,selection="answer")

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			switch(choice){
				if("Y"){
					return TRUE;
				}

				if("N"){
					return FALSE;
				}
			}
		}

		sex(){
			send("Please choose a sex.",src)
			send("{G*{x {cMale{x\n{G*{x {mFemale{x",src)
			var/choice = input_selection("What is your sex?",list("Male","Female"),src,selection="sex")

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			switch(choice){
				if("Male"){
					return MALE;
				}
				if("Female"){
					return FEMALE;
				}
			}
		}

		alignment(){
			send("Please choose a alignment.",src)
			send("{G*{x {BGood{x\n{G*{x {REvil{x",src)
			var/choice = input_selection("What is your alignment?",list("Good","Evil"),src,selection="alignment")

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			switch(choice){
				if("Good"){
					return GOOD;
				}
				if("Evil"){
					return EVIL;
				}
			}
		}

		skin_color(race){
			var
				list/skin_colors = list()

			send("Please choose a skin color.",src)

			switch(race){
				if(SAIYAN){
					skin_colors.Add("{yTan{x")
				}
				if(LEGENDARY_SAIYAN){
					skin_colors.Add("{yTan{x")
				}
				if(KANASSAN){
					skin_colors.Add("{rRed{x")
					skin_colors.Add("{gGreen{x")
					skin_colors.Add("{bBlue{x")
				}
				if(HALFBREED){
					skin_colors.Add("{yTan{x")
					skin_colors.Add("{WPale{x")
				}
				if(HUMAN){
					skin_colors.Add("{WPale{x")
					skin_colors.Add("{yTan{x")
				}
				if(NAMEK){
					skin_colors.Add("{gDark Green{x")
					skin_colors.Add("{GBright Green{x")
				}
				if(BIO_ANDROID){
					skin_colors.Add("{gDark Green{x")
					skin_colors.Add("{GBright Green{x")
				}
				if(GENIE){
					skin_colors.Add("{MPink{x")
					skin_colors.Add("{DBlack{x")
					skin_colors.Add("{WWhite{x")
					skin_colors.Add("{BBlue{x")
				}
				if(ANDROID){
					skin_colors.Add("{WPale{x")
					skin_colors.Add("{yTan{x")
					skin_colors.Add("{RRed{x")
					skin_colors.Add("{BBlue{x")
					skin_colors.Add("{gDark Green{x")
					skin_colors.Add("{GBright Green{x")
					skin_colors.Add("{YBright Yellow{x")
				}
				if(ALIEN){
					skin_colors.Add("{WPale{x")
					skin_colors.Add("{yTan{x")
					skin_colors.Add("{RRed{x")
					skin_colors.Add("{BBlue{x")
					skin_colors.Add("{gDark Green{x")
					skin_colors.Add("{GBright Green{x")
					skin_colors.Add("{YBright Yellow{x")
				}
				if(ICER){
					skin_colors.Add("{MPink{x")
					skin_colors.Add("{mPurple{x")
					skin_colors.Add("{WWhite{x")
				}
				if(SPIRIT){
					skin_colors.Add("{WPale{x")
				}				
				if(KAIO){
					skin_colors.Add("{CCyan{x")
					skin_colors.Add("{WPale{x")
					skin_colors.Add("{BBlue{x")
					skin_colors.Add("{MPink{x")
					skin_colors.Add("{mPurple{x")
				}
				if(DEMON){
					skin_colors.Add("{WPale{x")
					skin_colors.Add("{rCrimson{x")
					skin_colors.Add("{RRed{x")
					skin_colors.Add("{BBlue{x")
					skin_colors.Add("{DBlack{x")
					skin_colors.Add("{mPurple{x")
					skin_colors.Add("{oOrange{x")
				}
			}

			for(var/i in skin_colors){
				send("{G*{x [i]",src)
			}

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			return input_selection("What is your skin color?",skin_colors,src,selection="skin color");
		}

		hair_length(){
			var
				list/hair_length = list()

			send("Please choose a hair length.",src)

			hair_length.Add("{cNone{x")
			hair_length.Add("{cShort{x")
			hair_length.Add("{cShoulder Length{x")
			hair_length.Add("{cLong{x")

			for(var/i in hair_length){
				send("{G*{x [i]",src)
			}

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			return rStrip_Escapes(input_selection("What is your hair length?",hair_length,src,selection="hair length"));
		}

		hair_style(hair_length){
			var
				list/hair_style = list()

			send("Please choose a hair style.",src)

			switch(hair_length){
				if("Short"){
					hair_style.Add("{cParted{x")
					hair_style.Add("{cSlicked Back{x")
					hair_style.Add("{cMessy{x")
					hair_style.Add("{cSpiked{x")
				}
				if("Shoulder Length"){
					hair_style.Add("{cParted{x")
					hair_style.Add("{cSlicked Back{x")
					hair_style.Add("{cMessy{x")
					hair_style.Add("{cSpiked{x")
				}
				if("None"){
					hair_style.Add("{cBald{x")
				}
				if("Long"){
					hair_style.Add("{cMessy{x")
					hair_style.Add("{cStraight{x")
					hair_style.Add("{cPony Tail{x")
				}
			}

			for(var/i in hair_style){
				send("{G*{x [i]",src)
			}

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			return rStrip_Escapes(input_selection("What is your hair style?",hair_style,src,selection="hair style"));
		}

		hair_color(race){
			var
				list/hair_color = list()

			send("Please choose a hair color.",src)

			switch(race){
				if(SAIYAN){
					hair_color.Add("{DBlack{x")
					hair_color.Add("{yBrown{x")
				}
				if(LEGENDARY_SAIYAN){
					hair_color.Add("{DBlack{x")
					hair_color.Add("{yBrown{x")
				}
				if(HALFBREED){
					hair_color.Add("{DBlack{x")
					hair_color.Add("{yBrown{x")
					hair_color.Add("{YBlonde{x")
				}
				if(HUMAN){
					hair_color.Add("{DBlack{x")
					hair_color.Add("{yBrown{x")
					hair_color.Add("{YBlonde{x")
					hair_color.Add("{RRed{x")
				}

				if(NAMEK){
					hair_color.Add("None")
				}

				if(KANASSAN){
					hair_color.Add("None")
				}

				if(ALIEN){
					hair_color.Add("None")
				}

				if(BIO_ANDROID){
					hair_color.Add("None")
				}

				if(GENIE){
					hair_color.Add("None")
				}

				if(ANDROID){
					hair_color.Add("{DBlack{x")
					hair_color.Add("{yBrown{x")
					hair_color.Add("{YBlonde{x")
					hair_color.Add("{RRed{x")
					hair_color.Add("{mPurple{x")
					hair_color.Add("{MPink{x")
					hair_color.Add("{gGreen{x")
				}
				if(SPIRIT){
					hair_color.Add("{DBlack{x")
					hair_color.Add("{yBrown{x")
					hair_color.Add("{YBlonde{x")
					hair_color.Add("{RRed{x")
				}
				if(ICER){
					hair_color.Add("None")
				}
				if(KAIO){
					hair_color.Add("{WWhite{x")
					hair_color.Add("{CCyan{x")
					hair_color.Add("{MPink{x")
					hair_color.Add("{DBlack{x")
					hair_color.Add("{RRed{x")
				}
				if(DEMON){
					hair_color.Add("{WWhite{x")
					hair_color.Add("{BBlue{x")
					hair_color.Add("{mPurple{x")
					hair_color.Add("{DBlack{x")
					hair_color.Add("{RRed{x")
					hair_color.Add("{rCrimson{x")
					hair_color.Add("{oOrange{x")
				}
			}

			for(var/i in hair_color){
				send("{G*{x [i]",src)
			}

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			return input_selection("What is your hair color?",hair_color,src,selection="hair color");
		}

		eye_color(race){
			var
				list/eye_color = list()

			send("Please choose a eye color.",src)

			switch(race){
				if(SAIYAN){
					eye_color.Add("{DBlack{x")
				}
				if(LEGENDARY_SAIYAN){
					eye_color.Add("{DBlack{x")
				}
				if(HALFBREED){
					eye_color.Add("{DBlack{x")
				}

				if(NAMEK){
					eye_color.Add("{DBlack{x")
				}

				if(BIO_ANDROID){
					eye_color.Add("{DBlack{x")
					eye_color.Add("{RRed{x")
				}

				if(GENIE){
					eye_color.Add("{DBlack{x")
					eye_color.Add("{RRed{x")
				}

				if(HUMAN){
					eye_color.Add("{DBlack{x")
					eye_color.Add("{yBrown{x")
					eye_color.Add("{BBlue{x")
				}

				if(ANDROID){
					eye_color.Add("{DBlack{x")
					eye_color.Add("{yBrown{x")
					eye_color.Add("{RRed{x")
					eye_color.Add("{mPurple{x")
					eye_color.Add("{MPink{x")
					eye_color.Add("{gGreen{x")
				}

				if(ALIEN){
					eye_color.Add("{DBlack{x")
					eye_color.Add("{yBrown{x")
					eye_color.Add("{RRed{x")
					eye_color.Add("{mPurple{x")
					eye_color.Add("{MPink{x")
					eye_color.Add("{gGreen{x")
				}
				if(SPIRIT){
					eye_color.Add("{DBlack{x")
					eye_color.Add("{RRed{x")
					eye_color.Add("{CCyan{x")
				}
				if(ICER){
					eye_color.Add("{RRed{x")
					eye_color.Add("{DBlack{x")
					eye_color.Add("{mPurple{x")
				}

				if(KANASSAN){
					eye_color.Add("{RRed{x")
					eye_color.Add("{DBlack{x")
					eye_color.Add("{mPurple{x")
				}

				if(KAIO){
					eye_color.Add("{DBlack{x")
					eye_color.Add("{yBrown{x")
					eye_color.Add("{BBlue{x")
					eye_color.Add("{RRed{x")
					eye_color.Add("{mPurple{x")
				}
				if(DEMON){
					eye_color.Add("{WWhite{x")
					eye_color.Add("{BBlue{x")
					eye_color.Add("{mPurple{x")
					eye_color.Add("{DBlack{x")
					eye_color.Add("{RRed{x")
					eye_color.Add("{rCrimson{x")
				}
			}

			for(var/i in eye_color){
				send("{G*{x [i]",src)
			}

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			return input_selection("What is your eye color?",eye_color,src,selection="eye color");
		}

		height(){
			var
				list/height = list()

			send("Please choose a height.",src)

			height.Add("{cShort{x")
			height.Add("{cAverage{x")
			height.Add("{cTall{x")

			for(var/i in height){
				send("{G*{x [i]",src)
			}

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			return rStrip_Escapes(input_selection("What is your height?",height,src,selection="height"));
		}

		build(){
			var
				list/build = list()

			send("Please choose a build.",src)

			build.Add("{cSkinny{x")
			build.Add("{cAverage{x")
			build.Add("{cToned{x")
			build.Add("{cMuscular{x")
			build.Add("{cChubby{x")
			build.Add("{cFat{x")

			for(var/i in build){
				send("{G*{x [i]",src)
			}

			lifeTick = world.time; // Update our life tick to the current time so we don't idle out.

			return rStrip_Escapes(input_selection("What is your build?",build,src,selection="build"));
		}
