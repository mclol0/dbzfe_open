proc
	formatList(list/fList){
		var/listLen = (fList.len + 1);

		for(var/i=1,i<listLen,i++){
			fList[i] = format_text(fList[i]);
		}

		return fList;
	}