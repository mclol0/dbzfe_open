fQuest_Factory
	awardItem(var/mob/m as mob, var/type, var/amount=1 as num){
		var/obj/item/o

		if(amount>1){
			for(var/i=0,i<amount,i++){
				o = createItem(type);
				m.addInv(o);
			}

			send("You obtain [o.PREFIX][o.DISPLAY] x[amount]!",m,TRUE)
		}else{
			o = createItem(type);

			send("You obtain [o.PREFIX][o.DISPLAY]!",m,TRUE)
			m.addInv(o);
		}
	}