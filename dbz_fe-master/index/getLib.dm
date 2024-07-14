proc
	getLib(lib_name){
		switch(world.system_type){
			if(MS_WINDOWS){
				if(!fexists("lib/win32/[lib_name].dll")){
					game.logger.error("Unable to load [lib_name].dll!")
				}else{
					return "lib/win32/[lib_name].dll"
				}
			}

			if(UNIX){
				if(!fexists("lib/unix/[lib_name].so")){
					game.logger.error("Unable to load [lib_name].so!")
				}else{
					return "lib/unix/[lib_name].so"
				}
			}
		}
	}