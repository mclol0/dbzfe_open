proc
	newMeter(min,max,COLOR_1="{C",COLOR_2="{D",COLOR_3="{R",CHARACTER_1="|",CHARACTER_2="|"){
		var
			CCHAR = CHARACTER_1;
			CUR_PERCENT = 0.00;
			PER_PERCENT = 5.00;
			list/meter[] = list();

		for(var/i=0,i<20,i++){

			if(percent(min,max) >= (CUR_PERCENT + PER_PERCENT)){
				meter += "[COLOR_1][CCHAR]{x";
			}else if(percent(min,max) > 0){
				meter += "[COLOR_2][CCHAR]{x";
			}else{
				meter += "[COLOR_3][CCHAR]{x";
			}

			CUR_PERCENT += PER_PERCENT;

			if(CCHAR == CHARACTER_1){ CCHAR = CHARACTER_2; } else { CCHAR = CHARACTER_1; }
		}

		return implodetext(meter,"");
	}

	meter(min,max,c1="{C|{x",c2="{D|{x",c3="{R|{x"){
		var
			percent = 0;
			list/meter[] = list();

		for(var/i=0,i<10,i++){
			if(percent(min,max) >= (percent + 10)){
				meter += c1;
			}else if(percent(min,max) > 0){
				meter += c2;
			}else{
				meter += c3;
			}
			percent += 10;
		}

		return implodetext(meter,"");
	}