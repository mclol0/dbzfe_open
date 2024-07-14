mob/proc/findItems(){
	for(var/obj/i in equipment){
		return i;
	}
	return NULL;
}

Command/Public
	equipment
		name = "equipment"
		format = "~equipment";
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "This command will print your character's current equipped items."
		cancelsPushups = FALSE;

		command(mob/user) {
			if(user.findItems()){
				var/buffer;

				buffer += "{YEquipment:{x\n";
				//send("{YEquipment:{x",user,TRUE)
				for(var/i=1,i<EQUIPMENT_SLOTS,i++){
					if(user.equipment[i]){
						var/obj/item/x = user.equipment[i]
						buffer += " <al26>{Y\[{x{R[uppertext(_getName(i))]{x{Y\]{x</a> [x.DISPLAY]\n";
						//buffer += "[x.showDetails(user,NULL,TRUE)]\n\n"
						//send(format_text(" <al26>{Y\[{x{R[uppertext(_getName(i))]{x{Y\]{x</a> [x.DISPLAY]\n"),user,TRUE)
					}else{
						buffer += " <al26>{Y\[{x{R[uppertext(_getName(i))]{x{Y\]{x</a> {REmpty.{x\n";
						//send(format_text(" <al26>{Y\[{x{R[uppertext(_getName(i))]{x{Y\]{x</a> {REmpty.{x"),user,TRUE);
					}
				}

				send(format_text(buffer),user,TRUE);
				/*for(var/obj/item/i in user.equipment){
					send(" [i.PREFIX][i.DISPLAY] [i.EQ_MSG0] [i.EQ_MSG] your [_getName(i.SLOT)]",user)
				}*/
			}else{
				send("{YEquipment:{x\n {RYou are wearing nothing.{x",user,TRUE)
			}
		}