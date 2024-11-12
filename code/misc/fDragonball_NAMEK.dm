var/dragonballDatum_NAMEK/DBDatum_NAMEK = new();

dragonballDatum_NAMEK

	var
		WISHING = FALSE;
		COOLDOWN = 0;
		dragonballs[] = list();

	proc
		COOLDOWN_LOOP(){
			set waitfor=FALSE;
			set background = TRUE;

			while(src){
				COOLDOWN--;
				sleep(world.tick_lag);
			}
		}

		areActive(){
			if(COOLDOWN > 0){
				return FALSE;
			}

			return TRUE;
		}

		scatterDBS(){
			for(var/obj/item/NAMEK_DRAGONBALLS/d in dragonballs){
				d.scatter();
			}
		}

		checkForDB(mob/Player/m=NULL){ //Check if we have all 7 in the same room
			if(!length(dragonballs)){ return FALSE; }

			var/obj/item/NAMEK_DRAGONBALLS/dLoc = dragonballs[1];

			if(m && m.loc != dLoc.loc){ return FALSE; }

			for(var/obj/item/NAMEK_DRAGONBALLS/d in dragonballs){
				if(dLoc.loc != d.loc){ return FALSE; }
			}

			return TRUE;
		}

		listenForCaller(){
			set waitfor=FALSE;
			set background = TRUE;

			while(src){
				if(!WISHING && areActive() && checkForDB()){
					var/obj/item/NAMEK_DRAGONBALLS/dLoc = dragonballs[1];

					send("{YThe {x{GNamekian{x {YDrag({x{R*{x{Y)n{RBalls{x {Yare glowing!{x",_ohearers(0,dLoc));
				}
				sleep(10 SECONDS);
			}
		}

	New(){
		..();
		listenForCaller();
		COOLDOWN_LOOP();
	}

	Del(){
		..();
	}

obj/item/NAMEK_DRAGONBALLS
	DESC = "The Dragon Balls were intended to be a thing of extraordinary magic and power, something to be revered, not for the ease of their method, but for the dream of never having to use them."
	PREFIX = "the "
	text="{Y*{x"
	display="{Y*{x"
	STACKABLE = FALSE;
	MULTI = TRUE;
	SLOT = NULL;
	EDIBLE = FALSE;
	DESTRUCTABLE = FALSE;
	DECAY = FALSE;
	MISC = TRUE;
	WEIGHT = 3.0;
	CAN_GIVE = FALSE;
	CAN_SELL = FALSE;
	CAN_STASH = FALSE;

	New(){
		blink();
		..();

		var/planet/area = getArea();

		if(loc && game.safeTypes.Find(loc.type)){ warpArea(rand(1,area.dx),rand(1,area.dy),area) }

		if(area == get_area("outer space")){ scatter(); }

		DBDatum_NAMEK.dragonballs.Add(src);
	}

	proc

		scatter(){
			var/planet/area = get_area("namek");
			if(area != null && area.dx != null && area.dy != null){
				relocate:
				warpArea(rand(1,area.dx),rand(1,area.dy),area)

				if(game.safeTypes.Find(loc.type)){ goto relocate; }
			}
		}

		blink(){
			set waitfor = FALSE;

			while(src){
				if(DBDatum_NAMEK.areActive()){
					visible=FALSE;
					sleep(3 SECONDS);
					visible=TRUE;
					sleep(2 SECONDS);
				}else{
					visible=FALSE;
				}
				sleep(world.tick_lag);
			}
		}

		warpArea(x,y,planet/A){

			if(!isplanet(A)) { A = locate(A); } // Find the area we were asked to locate to.

			if(isplanet(A)){
				if(x > A.getDX() || x < 1 || y > A.getDY() || y < 1){ // Check our area's boundaries to see if its a valid warp.
					game.logger.error("DRAGONBALL ERROR: Invalid coordinates for area!")
					return FALSE;
				}
				loc=locate(((x - 1) + A.x),((y - 1) + A.y),A.z); // Take our areas minimum coordinates an add to which room we wish to warp to.
			}else{
				game.logger.error("DRAGONBALL ERROR: Invalid planet.");
				return FALSE;
			}

			return TRUE;
		}

	ONE_STAR_DRAGONBALL
		DISPLAY = "{GNamekian{x {YOne Star Drag({x{R*{x{Y)n{x{RBall{x"
		SHOW_ITEMDB = FALSE;

	TWO_STAR_DRAGONBALL
		DISPLAY = "{GNamekian{x {YTwo Star Drag({x{R*{x{Y)n{x{RBall{x"
		SHOW_ITEMDB = FALSE;

	THREE_STAR_DRAGONBALL
		DISPLAY = "{GNamekian{x {YThree Star Drag({x{R*{x{Y)n{x{RBall{x"
		SHOW_ITEMDB = FALSE;

	FOUR_STAR_DRAGONBALL
		DISPLAY = "{GNamekian{x {YFour Star Drag({x{R*{x{Y)n{x{RBall{x"
		SHOW_ITEMDB = FALSE;

	FIVE_STAR_DRAGONBALL
		DISPLAY = "{GNamekian{x {YFive Star Drag({x{R*{x{Y)n{x{RBall{x"
		SHOW_ITEMDB = FALSE;

	SIX_STAR_DRAGONBALL
		DISPLAY = "{GNamekian{x {YSix Star Drag({x{R*{x{Y)n{x{RBall{x"
		SHOW_ITEMDB = FALSE;

	SEVEN_STAR_DRAGONBALL
		DISPLAY = "{GNamekian{x {YSeven Star Drag({x{R*{x{Y)n{x{RBall{x"
		SHOW_ITEMDB = FALSE;
