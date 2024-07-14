/*
	This datum was written to track if a player has been floating on a snakeway cloud too long and if so then they fall to HFIL.
*/

proc/findCloudDatum(mob/m){
	var/mob/mb = NULL;

	for(var/cloudDatum/x){
		if(m == x:m){
			mb = x;
		}
	}

	if(mb){
		return mb;
	}else{
		return NULL;
	}
}

cloudDatum
	var
		tmp
			cloudRef = NULL;
			mob/Player/m = NULL;
			cloudTick = 0;
			cloudMaxTick = 4;

	proc
		tick(){
			set waitfor = FALSE;
			set background = TRUE;

			while(m && m.loc &&  m.loc.type == cloudRef && cloudTick < cloudMaxTick){
				cloudTick++;
				sleep(10);
			}

			if(cloudTick >= cloudMaxTick){

				var/planet/area = get_area("hfil");

				if(area && m){
					m.warpArea(rand(1,area.dx),rand(1,area.dy),area);
					send(buildMap(m,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),m);
					send("{RYou have fell to HFIL!{x",m);
				}
			}

			del(src);
		}

	New(mob/Player/owner=NULL, x=NULL){
		..()

		m = owner
		cloudRef = x:type;

		tick();
	}