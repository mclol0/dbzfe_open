Command/Public
	shortnum
		name = "shortnum"
		format = "shortnum";
		canAlwaysUSE = TRUE;
		helpDescription = "Toggle between long and short number representation. When enabled, numbers will be shortened to have at most 6 digits and one of the following prefixes:\n<al2></a>Thousands: K\n<al2></a>Million: M\n<al2></a>Billion: B\n<al2></a>Trillion: T\n<al2></a>Quadrillion: QUAD\n<al2></a>Quintillion: QUINT\n<al2></a>Sextillion: SEXT\n<al2></a>Septillion: SEPT\n<al2></a>Octillion: OCT"
		cancelsPushups = FALSE;

		command(mob/user) {
			if(user.shortNUM){
				send("Short numbers disabled.",user,TRUE);
				user.shortNUM = FALSE;
			}else{
				send("Short numbers enabled.",user,TRUE);
				user.shortNUM = TRUE;
			}
		}