/////////////////////////////////////////////////////////////
// Inputs
/////////////////////////////////////////////////////////////
// Author: Ebonshadow
// Email: Ebonshadow@TeamEbon.com
// Last Updated: 05/31/03
/////////////////////////////////////////////////////////////
// This file provides some useful procs for getting input from
// the user.
/////////////////////////////////////////////////////////////
// input_text(msg,m=usr)
// 		Same as input(m,msg) as command_text
// input_number(msg,m=usr)
//		Gets a valid number from the user
// input_confirm(msg,m=usr)
//		Returns 1 if the user picks yes
// input_list(msg,list/l,m=usr)
//		Forces the user to pick a valid option from the list
// input_message(msg,m=usr)
//		Allows the user to input multi-line text.  This one is
//		the big one.  It is the equivelent of input as message.
//		You will probably find that this one is very useful for a
//		text based mud that uses clients other than Dream Seeker
// input_menu(msg,list/options,border="default",width=40,m=usr)
//		This is similar to input_list(), but looks prettier
//		and is easier for the user.  It creates a menu with
//		the title msg, and displays the list of options.
//		The border option is the name of the border in which
//		to use.  To make new borders, simply make a new
//		MBborder type.  Take a look at borders.dm for some
//		examples.  Finally, width is the width of menu to make.
/////////////////////////////////////////////////////////////
            /*isMatch(entry, attempt) {
                var/list/keywords = src._getEntryKeywords(entry);

                for(var/word in keywords) {
                    if(__textMatch(word, attempt, src._isCaseSensitive(), src._isPartial())) return TRUE;
                }
                return FALSE;
            }*/

proc/short2full(given,list/commands)
	var/end = length(given) +1
	given = lowertext(given)
	if(given in commands)
		return given
	for(var/command in commands)
		var/check = lowertext(copytext(rStrip_Escapes(command),1,end))
		if(check==given)
			return command

proc/input_text(msg,mob/m=usr)
	m = GetMob(m)
	if(!m) return
	if(m.client.ctype==BYOND) send(msg,m)
	return input(m,msg) as command_text

proc/input_password(msg,mob/m=usr)
	m = GetMob(m)
	if(!m) return
	if(m.client.ctype==BYOND) send(msg,m)
	return input(m,msg) as password

proc/input_name(msg,mob/m=usr)
	m = GetMob(m)
	if(!m) return
	var/inp
	while(!inp)
		inp = input(m,send(msg,m)) as command_text
		if(!m.Review_Name(inp)){break}
	return inp
proc/GetMob(m)
	if(istype(m,/mob)) return m
	else if(istype(m,/client)) return m:mob
proc/input_number(msg,mob/m=usr)
	m = GetMob(m)
	if(!m) return
	var/val
	while(!val)
		if(m.client.ctype==BYOND) send(msg,m)
		val = text2num(input(m,msg) as command_text)
	return val
proc/input_confirm(msg,mob/m=usr)
	m = GetMob(m)
	if(!m) return
	msg = "[msg], is that correct? \[Y/N\]"
	if(m.client.ctype==BYOND) send(msg,m)
	var/confirm = input(m,msg) as command_text
	if(short2full(confirm,list("Y","N"))=="Y")
		return 1
proc/input_list(msg,list/l,mob/m=usr)
	m = GetMob(m)
	if(!m) return
	var/inp
	while(1)
		var/i = input(m,send(msg,m)) as command_text
		inp = short2full(i,l)
		if(!inp || !i) send("Invalid choice",m)
		else break
	return inp

proc/input_selection(msg,list/l,mob/m=usr,selection="choice")
	m = GetMob(m)
	if(!m) return
	var/inp
	while(1)
		var/i = input(m,send(msg,m)) as command_text
		inp = short2full(i,l)
		if(!inp || !i) send("Invalid [selection].",m)
		else break
	return inp

proc/input_planet(msg,list/l,mob/m=usr)
	m = GetMob(m)
	if(!m) return
	var/inp
	while(1)
		var/i = input(m,send(msg,m)) as command_text
		inp = short2full(i,l)
		if(!inp || !i) {
			send("Invalid choice",m)
		}
		else break
	return inp

proc/display_menu(msg, list/l, border="default", width=40, mob/m=usr) {
	var/MBborder/Border = MUDbase.borders[border]
	if(!Border) Border = MUDbase.borders["default"]
	var/top = Border.upper_left
	var/c
	while(c < width)
		top += Border.upper_center
		c += length(Border.upper_center)
	top += Border.upper_right
	var/low = Border.lower_left
	c = 0
	while(c < width)
		low += Border.lower_center
		c += length(Border.lower_center)
	low += Border.lower_right
	send(format_text(top),m)
	send(format_text("[Border.center_left]<ac[(width+(length(msg) - length(rStrip_Escapes(msg))))]>[msg]</a>[Border.center_right]"),m)
	c = 0
	for(var/i in l)
		c++
		send(format_text("[Border.center_left]<al4>[c]) </a><al[(width+(length(i) - length(rStrip_Escapes(i))))-4]>[i]</a>[Border.center_right]"),m)
	send(format_text(low),m)
}

proc/input_menu(msg,list/l,border="default",width=40,mob/m=usr)
	m = GetMob(m)
	if(!m) return
	m.in_npc_menu = TRUE;
	var/MBborder/Border = MUDbase.borders[border]
	if(!Border) Border = MUDbase.borders["default"]
	var/top = Border.upper_left
	var/c
	while(c < width)
		top += Border.upper_center
		c += length(Border.upper_center)
	top += Border.upper_right
	var/low = Border.lower_left
	c = 0
	while(c < width)
		low += Border.lower_center
		c += length(Border.lower_center)
	low += Border.lower_right
	var/inp
	while(!inp)
		send(format_text(top),m)
		send(format_text("[Border.center_left]<ac[(width+(length(msg) - length(rStrip_Escapes(msg))))]>[msg]</a>[Border.center_right]"),m)
		c = 0
		for(var/i in l)
			c++
			send(format_text("[Border.center_left]<al4>[c]) </a><al[(width+(length(i) - length(rStrip_Escapes(i))))-4]>[i]</a>[Border.center_right]"),m)
		send(format_text(low),m)
		inp = input_number(">")
		if(inp <= 0 || inp > l.len) inp = NULL;
	m.in_npc_menu = FALSE;
	return l[inp]

proc/ranking_menu(msg,list/l,border="default",width=40,mob/m=usr)
	m = GetMob(m)
	var/MBborder/Border = MUDbase.borders[border]
	if(!Border) Border = MUDbase.borders["default"]
	var/top = Border.upper_left
	var/c
	while(c < width)
		top += Border.upper_center
		c += length(Border.upper_center)
	top += Border.upper_right
	var/low = Border.lower_left
	c = 0
	while(c < width)
		low += Border.lower_center
		c += length(Border.lower_center)
	low += Border.lower_right
	if(!m){
		var/webBuffer;
		webBuffer+="[msg]<br />"
		var/lastUpdate="Last update: [game.lastRankUpdate()]<br />"
		webBuffer+="[lastUpdate]<br />"
		var/rank_border = "# Name Powerlevel<br />"
		webBuffer+="[rank_border]<br />"
		c = 0
		for(var/i in l)
			c++
			webBuffer+="[c]) [i]<br />"
			if(c>=25) break
		return webBuffer;
	}
	send(top,m,TRUE)
	send(format_text("[Border.center_left]<ac[(width+(length(msg) - length(rStrip_Escapes(msg))))]>[msg]</a>[Border.center_right]"),m,TRUE)
	var/lastUpdate="Last update: [game.lastRankUpdate()]"
	send(format_text("[Border.center_left]<ac[(width+(length(lastUpdate) - length(rStrip_Escapes(lastUpdate))))]>[lastUpdate]</a>[Border.center_right]"),m,TRUE)
	var/rank_border = format_text("<al1>#</a> <ar6>Name</a> <ar37>Powerlevel</a><ar24></a>")
	send(format_text("[Border.center_left][rank_border][Border.center_right]"),m,TRUE)
	c = 0
	for(var/i in l)
		c++
		send(format_text("[Border.center_left]<al4>[c]) </a><al[(width+(length(i) - length(rStrip_Escapes(i))))-4]>[i]</a>[Border.center_right]"),m,TRUE)
		if(c>=25) break
	if(!m) return low;
	send(low,m,TRUE)

proc/input_message(curval="",mob/m=usr)
	m = GetMob(m)
	if(!m) return
	var/list/value = __textToList(curval,"\n")
	if(!curval) value = list()
	send("Type line by line.  Type #? for a list of commands.",m)
	while(1)
		var/val = input_text(">")
		var/list/entered = __textToList(val," ")
		var/commands = list("#?","#done","#delete","#replace","#view","#reformat","#clear","#insert")
		if(entered.len>=1)
			var/command = short2full(entered[1], commands)
			if(command)
				var/list/margs = __textToList(val," ")
				if(margs.len)
					margs -= margs[1]
				switch(command)
					if("#?")
						send("Commands:",m)
						send("<al14>#?</a> This help.",m)
						send("<al14>#done</a> Exit and save.",m)
						send("<al14>#delete N</a> Delete line N.",m)
						send("<al14>#clear</a> Clears all text.",m)
						send("<al14>#replace N X</a> Replace line N with X.",m)
						send("<al14>#insert N X</a> Inserts Xx before line N.",m)
						send("<al14>#view</a> Views current text.",m)
						send("<al14>#reformat</a> Formats the text to a constant width.",m)
					if("#done") break
					if("#reformat")
						var/newtext = __listToText(value," ")
						var/newtext_list = __textToList(newtext," ")
						var/final_text
						var/cur_chars = 0
						for(var/i in newtext_list)
							cur_chars += length(i)
							if(cur_chars>=80)
								cur_chars=0
								final_text="[final_text][i]\n"
							else
								final_text="[final_text][i] "
						var/grouped1 = __textToList(final_text,"\n")
						value = grouped1
						value -= value[value.len]
						send("Text has been reformated.",m)
					if("#clear")
						if(input_confirm("Clear text?",m))
							send("Text has been cleared.",m)
							value = list()
					if("#delete")
						if(margs.len)
							var/n = text2num(margs[1])
							if(!n) send("#insert \[number]",m)
							else if(value.len>=n)
								if(input_confirm("Delete line [n]?",m))
									value -= value[n]
									send("Line [n] has been deleted.",m)
							else
								send("That line does not exist.",m)
					if("#replace")
						if(margs.len>=2)
							var/n = text2num(margs[1])
							if(!n) send("#insert \[number]",m)
							else if(value.len>=n)
								if(input_confirm("Replace line [n]?",m))
									value[n] = __listToText(margs.Copy(2), " ")
									send("Line [n] has been replaced.",m)
							else
								send("That line does not exist.",m)
					if("#insert")
						if(margs.len>=2)
							var/n = text2num(margs[1])
							if(!n) send("#insert \[number]",m)
							else if(value.len>=n)
								send("Insert before line [n]? (type yes to confirm)",m)
								if(input_confirm("Confirm?",m))
									var/list/new_value = list()
									for(var/t = 1 to value.len)
										var/i = value[t]
										var/k = value.Find(i)
										if(k==n)
											new_value += __listToText(margs.Copy(2), " ")
										new_value+= i
									value = new_value
									send("Inserted.",m)
							else
								send("That line does not exist.",m)
					if("#view")
						send("Current text:",m)
						for(var/i = 1 to value.len)
							send("[i]\t[value[i]]",m)
			else
				value += val
				m << val
	send("Done.",m)
	return __listToText(value,"\n")

MUDbase
	var/list/borders = list()
	New()
		for(var/i in typesof(/MBborder)-/MBborder)
			var/MBborder/border = new i()
			borders[border.name] = border
		return ..()

MBborder
	var
		name
		upper_left
		upper_center
		upper_right
		lower_left
		lower_center
		lower_right
		center_left
		center_right