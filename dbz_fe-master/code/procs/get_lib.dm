proc
	getLib(lib_name){
		switch(world.system_type){
			if(MS_WINDOWS){
				return "lib/win32/[lib_name].dll"
			}else{
				return "lib/unix/[lib_name].so"
			}
		}
	}