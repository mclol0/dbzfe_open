respawnMob
	var
		_type=NULL;
		_random=FALSE;
		_x=0;
		_y=0;
		_z=0;
		planet/_area=NULL;
		_time=0;
		_respawn=FALSE;

	proc
		_wait();
		_respawn();

	New(type,israndom,x,y,z,planet,time){
		_type=type;
		_random=israndom;
		_x=x;
		_y=y;
		_z=z;
		_area=planet;
		_time=(world.time+time);
		_wait();
	}

	clean(){
		_type=NULL;
		_random=FALSE;
		_x=0;
		_y=0;
		_z=0;
		_area=NULL;
		_time=0;
		_respawn=FALSE;
		..();
	}

	_wait(){
		set waitfor=FALSE;
		set background = TRUE;

		while(!_respawn){

			if(world.time >= _time) { _respawn=TRUE; }

			sleep(world.tick_lag);
		}

		_respawn();
	}

	_respawn(){
		var/mob/NPA/npc = new _type(locate(_x,_y,_z));

		if(_random){
			respawn:
			npc.loc=locate(rand(_area.x,_area.getMaxX()),rand(_area.y,_area.getMaxY()),_z)
			if(npc.isSafe() || (npc.getStatus() in list("swimming"))){ goto respawn: }
		}

		clean();
	}

