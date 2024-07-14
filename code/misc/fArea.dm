planet
	parent_type = /area

	locked = FALSE;
	var/noSummon = FALSE;
	var/atmosphere = TRUE;
	var/list/moons[] = list();

	proc

		obtainMoon(var/moon/m){
			moons.Add(m);
		}

		getRealX(fakeX){
			var/rX = 1;

			if(fakeX < 0){
				rX = (getMaxX() + fakeX + 1);
			}else{
				rX = (x + fakeX - 1);
			}

			return clamp(rX,x,getMaxX());
		}

		getRealY(fakeY){
			var/rY = 1;

			if(fakeY < 0){
				rY = (getMaxY() + fakeY + 1);
			}else{
				rY = (y + fakeY - 1);
			}

			return clamp(rY,y,getMaxY());
		}

	getDX(){
		return dx;
	}

	getDY(){
		return dy;
	}

	arena
		var
			entranceX = 0;
			entranceY = 0;
			entranceZ = 0;

			exitX = 0;
			exitY = 0;
			exitZ = 0;

		locked = TRUE;
		name = "{RArena{x"
		wrapArea = TRUE;
		hideEdges = TRUE;
		gravity = 1;
		powerLocked = TRUE;


		A_1
			name = "{RArena{x #1"
			entranceX=81;
			entranceY=64;
			entranceZ=1;
			exitX=49;
			exitY=164;
			maxPower = 100000;
		A_2
			name = "{RArena{x #2"
			entranceX=177;
			entranceY=66;
			entranceZ=1;
			exitX=74;
			exitY=164;
			maxPower = 500000;
		A_3
			name = "{RArena{x #3"
			entranceX=142;
			entranceY=224;
			entranceZ=1;
			exitX=99;
			exitY=164;
			maxPower = 1000000;
		A_4
			name = "{RArena{x #4"
			entranceX=201;
			entranceY=249;
			entranceZ=1;
			exitX=123;
			exitY=162;
			maxPower = 100000000;
		A_5
			name = "{RArena{x #5"
			entranceX=50;
			entranceY=204;
			entranceZ=10;
			exitX=160;
			exitY=179;
			maxPower = 1.50e+011;
		A_6
			name = "{RArena{x #6"
			entranceX=178;
			entranceY=24;
			entranceZ=10;
			exitX=157;
			exitY=145;
			maxPower = 3.50e+012;

	check_in_station
		gravity = 1;
		locked = TRUE;
		name = "{WCheck-In Station{x";
		wrapArea = TRUE;
		hideEdges = TRUE;
		noSummon = TRUE;

	king_kaio_planet
		gravity = 5;
		locked = TRUE;
		name = "{CKing Kai's{x {YPlanet{x"
		wrapArea = TRUE;
		noSummon = TRUE;

	space
		gravity = 0;
		locked = TRUE;
		name = "{WOuter Space{x";
		noSummon = TRUE;

	earth
		gravity = 1;
		name = "{YEarth{x";
	bas
		gravity = 2;
		name = "{MBas{x";
	vegeta
		gravity = 10;
		name = "{RVegeta{x";

	namek
		gravity = 3;
		name = "{gNamek{x";

	freezer
		gravity = 7;
		name = "{MFrieza{x";

	kaishin
		gravity = 10;
		name = "{wKaishin{x";

	snake_way
		gravity = 1;
		locked = TRUE;
		wrapArea = TRUE;
		hideEdges = FALSE;
		name = "{RSnakeway{x";
		noSummon = TRUE;
		//startX=59;
		//startY=2;

	hfil
		gravity = 3;
		locked = TRUE;
		wrapArea = TRUE;
		name = "{RHFIL{x";
		noSummon = TRUE;
		//startX=182;
		//startY=2;

	silent_bubble
		gravity = 15;
		locked = TRUE;
		hideEdges = TRUE;
		wrapArea = TRUE;
		name = "{DSilent Bubble{x";
		noSummon = TRUE;
		startX=86;
		startY=186;

	moon_lab_secret
		gravity = 0;
		locked = TRUE;
		hideEdges = TRUE;
		wrapArea = TRUE;
		name = "{DSecret Moon Lab{x";
		noSummon = TRUE;
		startX=186;
		startY=286;

	moon_lab_lair
		gravity = 15;
		locked = TRUE;
		hideEdges = TRUE;
		wrapArea = TRUE;
		name = "{DSecret Moon Lab{x";
		noSummon = TRUE;
		startX=156;
		startY=286;

	moon_lab_lair_basement
		gravity = 15;
		locked = TRUE;
		hideEdges = TRUE;
		wrapArea = TRUE;
		name = "{DSecret Moon Lab{x";
		noSummon = TRUE;
		startX=156;
		startY=286;

	underwater_lake
		gravity = 2;
		locked = TRUE;
		hideEdges = TRUE;
		wrapArea = TRUE;
		name = "{BUnderwater Lake{x";
		noSummon = TRUE;
		startX=97;
		startY=197;

	arlia
		gravity = 7;
		wrapArea = TRUE;
		name = "{rArlia{x";

	arlia_prison
		gravity = 7;
		locked = TRUE;
		wrapArea = TRUE;
		hideEdges = TRUE;
		noSummon = TRUE;
		name = "{rArlian{x {YPrison{x";

	admin_lounge
		gravity = 0;
		locked = TRUE;
		wrapArea = TRUE;
		hideEdges = TRUE;
		noSummon = TRUE;
		name = "{RADMIN{x {WLOUNGE{x";

	hbtc
		gravity = 0;
		locked = TRUE;
		wrapArea = TRUE;
		name = "{YHyperbolic Time Chamber{x";
		maxPower = 5.00e+08;
		powerLocked = TRUE;
		noSummon = TRUE;
		//startX=97;
		//startY=2;

	korin_and_kamis_tower
		gravity = 1;
		locked = FALSE;
		wrapArea = TRUE;
		hideEdges = TRUE;
		name = "{yKorin's{x {WTower{x";
		noSummon = TRUE;
		startX = 57;
		startY = 43;

	New(){
		..()

		if(wrapArea){
			var
				sX = x;
				sY = y;

			while(!maxx){
				var/turf/T = locate(sX,y,z)
				if(hideEdges){
					if(T.loc.type != type){
						maxx = (sX);
						dx--;
					}
				}else{
					if(T.loc.type != type){
						maxx = (sX - 1);
						dx--;
					}
				}
				dx++
				sX++
			}

			while(!maxy){
				var/turf/T = locate(x,sY,z)
				if(hideEdges){
					if(T.loc.type != type){
						maxy = (sY);
						dy--;
					}
				}else{
					if(T.loc.type != type){
						maxy = (sY - 1);
						dy--;
					}
				}
				dy++
				sY++
			}

			center = new/obj(locate(x,y,z))
			center.visible = FALSE;
			center.invisible = TRUE;
		}else{
			maxx=world.maxx
			maxy=world.maxy
			dx=world.maxx;
			dy=world.maxy;
			center = new/obj(locate((dx/2),(dy/2),z))
			center.visible = FALSE;
			center.invisible = TRUE;
		}
	}

area
	var
		maxx = 0;
		maxy = 0;
		dx = 0;
		dy = 0;
		startX = NULL;
		startY = NULL;
		hideEdges = FALSE;
		locked = TRUE;
		obj/center;
		wrapArea = FALSE;
		gravity = 0;
		finishLocked = FALSE;

		powerLocked = FALSE;
		maxPower = 0;

	teleporter
		var
			telx=NULL;
			tely=NULL;
			telz=NULL;
			message = NULL;

		king_kai_port
			telx=212;
			tely=176;
			telz=4;
			message = "You take a running jump to King Kai's planet and land safely!";

			teleport(mob/m,telx,tely,telz){
				..(m,telx,tely,telz);
				qFac.updateVariable(m,"SQ003_TRAVEL_SNAKEWAY","Travel Snakeway",TRUE);
			}

		proc
			teleport(mob/m,telx,tely,telz)
				m.loc=locate(telx,tely,telz)
				if(message){ send(message,m); }

		Entered(mob/Player/m){
			if(!m.fCombat.hostileTargets.len) teleport(m,telx,tely,telz)
			..()
		}

	proc
		getDX(){
			return 0;
		}

		getDY(){
			return 0;
		}

		getMinX(){
			if(isplanet(src)){
				return src:x;
			}else{
				return 1;
			}
		}

		getMaxX(){
			if(isplanet(src)){
				return src:maxx;
			}else{
				return world.maxx;
			}
		}

		getMinY(){
			if(isplanet(src)){
				return src:y;
			}else{
				return 1;
			}
		}

		getMaxY(){
			if(isplanet(src)){
				return src:maxy;
			}else{
				return world.maxy;
			}
		}
