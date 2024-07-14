client/proc/
	color_prompt(var/text as text){
		if(findtextEx(text,"{")) text = replacetext(text,"{","[gForm.getPColor(mob.form,"{")]")
		if(findtextEx(text,"}")) text = replacetext(text,"}","[gForm.getPColor(mob.form,"}")]")
		if(findtextEx(text,"<")) text = replacetext(text,"<","[gForm.getPColor(mob.form,"<")]")
		if(findtextEx(text,"<")) text = replacetext(text,">","[gForm.getPColor(mob.form,">")]")
		if(findtextEx(text,"\[")) text = replacetext(text,"\[","[gForm.getPColor(mob.form,"\[")]")
		if(findtextEx(text,"\]")) text = replacetext(text,"\]","[gForm.getPColor(mob.form,"\]")]")
		if(findtextEx(text,"(")) text = replacetext(text,"(","[gForm.getPColor(mob.form,"(")]")
		if(findtextEx(text,")")) text = replacetext(text,")","[gForm.getPColor(mob.form,")")]")
		if(findtextEx(text,"\\")) text = replacetext(text,"\\","[gForm.getPColor(mob.form,"\\")]")
		if(findtextEx(text,"/")) text = replacetext(text,"/","[gForm.getPColor(mob.form,"/")]")
		if(findtextEx(text,"|")) text = replacetext(text,"|","[gForm.getPColor(mob.form,"|")]")
		if(findtextEx(text,"-")) text = replacetext(text,"-","[gForm.getPColor(mob.form,"-")]")
		return text;
	}