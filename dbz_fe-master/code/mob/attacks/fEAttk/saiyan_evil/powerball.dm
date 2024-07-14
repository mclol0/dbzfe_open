fEAttk
	powerball
		name = "powerball"
		text = "{W@{x"
		display = "{W@{x"
		pColor = NULL
		isProjectile = FALSE;
		isCharge = FALSE;
		cdTime = 300 SECONDS;

		proc/scan(){
			set waitfor=FALSE;

			var
				nextScan = (world.time + 5 SECONDS);

				deathTime = (world.time + 2 MINUTES);

			while(src){
				if(world.time >= nextScan){
					nextScan = (world.time + 5 SECONDS);

					for(var/mob/Player/m in ov_out(0,8,src)){
						m.transformOozaru();
					}
				}

				if(world.time >= deathTime){ break; }

				sleep(world.tick_lag);
			}

			del(src);
		}

		New(var/mob/m as mob, var/x as num,  var/y as num, var/z as num){
			..()

			if(y > world.maxy){ y = world.maxy; }

			loc=locate(x,y,z);

			scan();
		}