proc
	send(text,target,canAllHear=FALSE){
		if(!target || isnpc(target)) return;

		if(islist(target)){
			for(var/a in target){
				if(isclient(a) || isplayer(a)&&a:client&&!((a:getStatus() in list("unconscious","sleeping")) && !canAllHear)){
					a:output:add("[text]{x\n");
					if(a:client) a:client:bust_prompt = TRUE;
				}
			}
		}
		else if(isclient(target) || isplayer(target)&&target:client&&!((target:getStatus() in list("unconscious","sleeping")) && !canAllHear)){
			if(target && target:output) target:output:add("[text]{x\n");
			if(target:client) target:client:bust_prompt = TRUE;
		}
	}