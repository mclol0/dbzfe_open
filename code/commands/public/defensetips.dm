Command/Public
	defensetips
		name = "defensetips"
		format = "defensetips";
		canAlwaysUSE = TRUE;
		helpDescription = "Toggle On or Off the defense tips to enemy attacks. When ON, defense tips are displayed after an enemy starts launching an attack and look like this: \n{R* Frieza's henchman retracts his left arm... {B({Rparry high{B / {Rdodge left{B){x"
		cancelsPushups = FALSE;

		command(mob/user) {
			if(user.showDefense){
				send("Defense tips disabled.",user,TRUE);
				user.showDefense = FALSE;
			}else{
				send("Defense tips enabled.",user,TRUE);
				user.showDefense = TRUE;
			}
		}