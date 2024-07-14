proc

	short_num(var/int){
		var
			shortNum = NULL;
			newInt = commafy(int);

		switch(length(newInt)){
			if(39){
				shortNum = "OCT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(38){
				shortNum = "OCT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(37){
				shortNum = "OCT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
			if(35){
				shortNum = "SEPT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(34){
				shortNum = "SEPT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(33){
				shortNum = "SEPT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
			if(31){
				shortNum = "SEXT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(30){
				shortNum = "SEXT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(29){
				shortNum = "SEXT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
			if(27){
				shortNum = "QUINT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(26){
				shortNum = "QUINT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(25){
				shortNum = "QUINT";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
			if(23){
				shortNum = "QUAD";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(22){
				shortNum = "QUAD";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(21){
				shortNum = "QUAD";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
			if(19){
				shortNum = "T";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(18){
				shortNum = "T";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(17){
				shortNum = "T";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
			if(15){
				shortNum = "B";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(14){
				shortNum = "B";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(13){
				shortNum = "B";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
			if(11){
				shortNum = "M";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(10){
				shortNum = "M";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(9){
				shortNum = "M";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
			if(7){
				shortNum = "K";
				newInt = copytext("[replacetext(newInt,",",".")]",1,7);
			}
			if(6){
				shortNum = "K";
				newInt = copytext("[replacetext(newInt,",",".")]",1,6);
			}
			if(5){
				shortNum = "K";
				newInt = copytext("[replacetext(newInt,",",".")]",1,5);
			}
		}

		if(shortNum != NULL){
			return "[newInt][shortNum]";
		}


		return newInt;
	}