var/global/lastAID = 0;

datum
	proc
		clean()

atom/movable
	clean(){
		..()
		contents=NULL;
		loc=NULL;
	}

atom
	var
		cColor = 0
		display = "x"
		MULTI = FALSE;
		lifeTick = 0;

		tmp
			visible = TRUE
			cmdtime = 0
			ID = 0
			xray = FALSE;
			invisible = FALSE;

	proc

		getArea(){
			if(isturf(src) && loc) { return loc; }

			if(!loc || !loc.loc){
				return NULL;
			}

			return loc.loc;
		}

		getX(){
			var/area/X = getArea();

			if(X){ return (x - X.x + 1); }

			return x;
		}

		getY(){
			var/area/X = getArea();

			if(X){ return (y - X.y + 1); }

			return y;
		}

		findloc(type) // find where an type is no matter where it is located.
			if(istype(src, type)) return src
			if(!loc) return NULL;
			if(istype(loc, type)) return loc
			return loc.findloc(type)

		setDisplay(text){
			display = text
			text = text
		}

		get_life(){
			return (world.time - lifeTick);
		}

	New(){
		..()
		lifeTick = world.time;
		ID = ++global.lastAID;
	}

	Del(){
		..()
	}