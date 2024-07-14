Command/Public
	Movement
		getDescription() {
			return "This command will move your character [name]. While moving in ground, movement can be blocked by land features such as mountains, buildings or walls."
		}

		getSyntax() {
			return "{R[name]{x"
		}

		helpCategory = "Movement"

		/* Movement */
		north
			name = "north"
			format = "~north";
			priority = 2;
			syntax = "north|n"

			command(mob/user) {
				if("north" in user.Exits()){
					if(!user.density){
						send("You fly north.", user)
					}
					else if(user.loc:tType == WATER){
						send("You swim north.", user)
					}
					else{
						send("You move north.", user)
					}
					user.Move(get_step(user,NORTH), NORTH)
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
				}
				else{
					send("Umph, I can't go that way!",user)
				}
			}

		north_east
			name = "northeast"
			format = "~northeast|ne;";

			command(mob/user) {
				if("ne" in user.Exits()){
					if(!user.density){
						send("You fly northeast.", user)
					}
					else if(user.loc:tType == WATER){
						send("You swim northeast.", user)
					}
					else{
						send("You move northeast.", user)
					}
					user.Move(get_step(user,NORTHEAST), NORTHEAST)
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
				}
				else{
					send("Umph, I can't go that way!",user)
				}
			}

		north_west
			name = "northwest"
			format = "~northwest|nw";

			command(mob/user) {
				if("nw" in user.Exits()){
					if(!user.density){
						send("You fly northwest.", user)
					}
					else if(user.loc:tType == WATER){
						send("You swim northwest.", user)
					}
					else{
						send("You move northwest.", user)
					}
					user.Move(get_step(user,NORTHWEST), NORTHWEST)
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
				}
				else{
					send("Umph, I can't go that way!",user)
				}
			}

		south
			name = "south"
			format = "~south";
			priority = 4

			command(mob/user) {
				if("south" in user.Exits()){
					if(!user.density){
						send("You fly south.", user)
					}
					else if(user.loc:tType == WATER){
						send("You swim south.", user)
					}
					else{
						send("You move south.", user)
					}
					user.Move(get_step(user,SOUTH), SOUTH)
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
				}
				else{
					send("Umph, I can't go that way!",user)
				}
			}

		south_east
			name = "southeast"
			format = "~southeast|se";
			priority = 2

			command(mob/user) {
				if("se" in user.Exits()){
					if(!user.density){
						send("You fly southeast.", user)
					}
					else if(user.loc:tType == WATER){
						send("You swim southeast.", user)
					}
					else{
						send("You move southeast.", user)
					}
					user.Move(get_step(user,SOUTHEAST), SOUTHEAST)
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
				}
				else{
					send("Umph, I can't go that way!",user)
				}
			}

		south_west
			name = "southwest"
			format = "~southwest|sw";
			priority = 3

			command(mob/user) {
				if("sw" in user.Exits()){
					if(!user.density){
						send("You fly southwest.", user)
					}
					else if(user.loc:tType == WATER){
						send("You swim southwest.", user)
					}
					else{
						send("You move southwest.", user)
					}
					user.Move(get_step(user,SOUTHWEST), SOUTHWEST)
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
				}
				else{
					send("Umph, I can't go that way!",user)
				}
			}

		east
			name = "east"
			format = "~east";
			priority = 10

			command(mob/user) {
				if("east" in user.Exits()){
					if(!user.density){
						send("You fly east.", user)
					}
					else if(user.loc:tType == WATER){
						send("You swim east.", user)
					}
					else{
						send("You move east.", user)
					}
					user.Move(get_step(user,EAST), EAST)
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
				}
				else{
					send("Umph, I can't go that way!",user)
				}
			}

		west
			name = "west"
			format = "~west";
			priority = 2

			command(mob/user) {
				if("west" in user.Exits()){
					if(!user.density){
						send("You fly west.", user)
					}
					else if(user.loc:tType == WATER){
						send("You swim west.", user)
					}
					else{
						send("You move west.", user)
					}
					user.Move(get_step(user,WEST), WEST)
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
				}
				else{
					send("Umph, I can't go that way!",user)
				}
			}