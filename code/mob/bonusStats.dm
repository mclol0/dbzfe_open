#define DAMAGE_PER_STR 12
#define DAMAGE_PERCENT 0.8

#define ZENKAI_BONUS 10;
#define ZENKAI_BONUS_LSSJ 20;
#define ZENKAI_ARMOR_BONUS_LSSJ 5;

#define ENERGY_PER_STA 10
#define ENERGY_PERCENT 1

#define GAIN_PER_POUND 2
#define GAIN_PERCENT 0.12

#define GRAVITY_GAIN_PERCENT 0.02

#define DEFENSE_PER_ARM 14
#define ARMOR_PERCENT 1

#define POWERLEVEL_PER_KI 9
#define KI_PERCENT 0.25

#define DROP_PER_MF 30
#define DROP_PERCENT 0.5

#define STR_PER_POUND 1 // For every STR_EVERY_POUND we take x amount of strength %
#define STR_EVERY_POUND 2 // For every x amount of pounds we take strength

#define KI_PER_POUND 2
#define KI_EVERY_POUND 3

#define FLIGHT_PER_STAT 1
#define FLIGHT_PERCENT 3.00

#define LBS_PER_STR 4
#define LBS_PER_PERCENT 3

#define STA_PER_LBS 30.00
#define STA_PER_PERCENT 1.00

#define FLY_SPEED_PER 3 // For every 3 fly speed we reward FLY_SPEED_EXTRA per room.
#define FLY_SPEED_EXTRA 1 // For every 3 fly speed we provide this value per room.

//WIP
mob
	proc
		isBursting(){
			switch(bursting){
				if(TRUE){ return 9; }
			}

			return 0;
		}

		calcBonusFly(){
			return (flightSPEED + floor(((isBursting() + gForm.getFSMod(form)) / FLY_SPEED_PER * FLY_SPEED_EXTRA)));
		}

		buildStrength(){
			switch(visuals["build"]){
				if("Skinny"){
					return 5.00;
				}

				if("Average"){
					return 25.00;
				}

				if("Toned"){
					return 50.00;
				}

				if("Muscular"){
					return 75.00;
				}

				if("Chubby"){
					return 55.00;
				}

				if("Fat"){
					return 45.00;
				}
			}
		}

		buildArmor(){
			switch(visuals["build"]){
				if("Skinny"){
					return -10.00;
				}

				if("Average"){
					return -5.00;
				}

				if("Toned"){
					return 35.00;
				}

				if("Muscular"){
					return 50.00;
				}

				if("Chubby"){
					return 125.00;
				}

				if("Fat"){
					return 150.00;
				}
			}
		}

		buildSTA(){
			switch(visuals["build"]){
				if("Skinny"){
					return 50.00;
				}

				if("Average"){
					return 30.00;
				}

				if("Toned"){
					return 20.00;
				}

				if("Muscular"){
					return 0.00;
				}

				if("Chubby"){
					return -50.00;
				}

				if("Fat"){
					return -70.00;
				}
			}
		}

		buildWeight(){
			switch(visuals["build"]){
				if("Skinny"){
					return 7.50;
				}

				if("Average"){
					return 13.00;
				}

				if("Toned"){
					return 15.00;
				}

				if("Muscular"){
					return 18.50;
				}

				if("Chubby"){
					return 22.50;
				}

				if("Fat"){
					return 30.00;
				}
			}
		}

		calcMaxWeight(){
			return round(((totalStr()) / LBS_PER_STR * LBS_PER_PERCENT),0.1);
		}

		calcExtraStam(){
			return round(((percent(totalWeight(),calcMaxWeight()*2)) / STA_PER_LBS * STA_PER_PERCENT),1);
		}

		inventoryWeight(){
			var/weight = 0;

			for(var/obj/item/i in contents){ weight = (weight + i.WEIGHT); }

			return round((weight*getGravity()),0.1);
		}

		totalWeight(){
			var/weight = buildWeight();

			for(var/obj/item/i in (equipment + contents)){ weight = (weight + i.WEIGHT); }

			return round((weight*getGravity()),0.1);
		}

		totalKi(){
			var/ki = bonus_ki;

			for(var/obj/item/i in equipment){ ki = (ki + i.BONUS_KI); }

			ki = (ki + gForm.getPLMod(form))

			if(isplayer(src) && (race == SAIYAN || race == LEGENDARY_SAIYAN || race == HALFBREED) && hasTail){ ki = (ki + 500); }

			return floor(ki);
		}

		stats(mob/req){
			req << "ARM: [totalArmor()]";
			req << "STR: [totalStr()]";
			req << "STA: [totalSta()]";
			req << "KI: [totalKi()]";
		}

		totalArmor(){
			var/armor = (bonus_arm + buildArmor());
			var/planet/area = getArea();

			if(area && area.powerLocked){
				return 1000;
			}

			if(demonWeapon == DEMON_SHIELD){ armor += DEMON_SHIELD_BONUS; }

			for(var/obj/item/i in equipment){ armor += i.BONUS_ARM; }

			armor += gForm.getbonusARM(form);

			if(race == LEGENDARY_SAIYAN && techniques.Find(/Command/Technique/zenkai)){
				armor += ((getMaxEN() - curreng) * ZENKAI_ARMOR_BONUS_LSSJ);
			}

			return floor(armor);
		}

		totalMF(){
			var/mf = bonus_mf;

			for(var/obj/item/i in equipment){ mf += i.BONUS_MF; }

			return floor(mf);
		}

		totalSta(){
			var/sta = (bonus_sta + buildSTA());

			var/planet/area = getArea();

			if(area && area.powerLocked){
				return 250;
			}

			for(var/obj/item/i in equipment){ sta += i.BONUS_STA; }

			sta += gForm.getbonusSTA(form)

			if(techniques.Find(/Command/Technique/onslaught)){ sta += ONSLAUGHT_BONUS_STA; }

			if(race==ANDROID){ sta += 50; }

			return floor(sta);
		}

		totalStr(){
			var/str = (bonus_str + buildStrength());

			var/planet/area = getArea();

			if(area && area.powerLocked){
				return 1000;
			}

			if(demonWeapon == DEMON_SWORD){ str += DEMON_SWORD_BONUS; }

			for(var/obj/item/i in equipment){ str += i.BONUS_STR; }

			str += gForm.getbonusSTR(form)

			if(techniques.Find(/Command/Technique/arrogance)){ str += ARROGANCE_BONUS_STR; }

			if(techniques.Find(/Command/Technique/zenkai)){
				if(race == LEGENDARY_SAIYAN){
					str += ((getMaxEN() - curreng) * ZENKAI_BONUS_LSSJ);
				}else{
					str += ((getMaxEN() - curreng) * ZENKAI_BONUS);
				}
			}

			if(fCombat.lastTarget && simultaneous && !fCombat.lastTarget:simultaneous){ str += -500; }

			return floor(str);
		}

		calcBonusDamage(){
			return round(((totalStr()) / DAMAGE_PER_STR * DAMAGE_PERCENT),0.01);
		}

		calcBonusEnergy(){
			return floor(((totalSta()) / ENERGY_PER_STA * ENERGY_PERCENT));
		}

		calcBonusDefense(){
			return round(((totalArmor()) / DEFENSE_PER_ARM * ARMOR_PERCENT),0.01);
		}

		calcBonusPL(){
			var/bonusPL = ret_percent_notrunx(((totalKi()) / POWERLEVEL_PER_KI * KI_PERCENT),maxpl);

			return floor(bonusPL);
		}

		calcBonusMF(){
			return round(((totalMF()) / DROP_PER_MF * DROP_PERCENT),0.01);
		}

		calcBonusGain(var/gravity = FALSE){
			if(gravity == FALSE) {
				return round(((totalWeight()) / GAIN_PER_POUND * GAIN_PERCENT),0.01);
			} else {
				return round(((totalWeight()/3.5) / GAIN_PER_POUND * GRAVITY_GAIN_PERCENT ),0.01);

			}

		}

		calcFlightBonus(){
			if(istype(src,/mob/NPA) && src:difficultyLevel == EVENT_MOB){ return 0; }

			return ((isBursting() + gForm.getFSMod(form)) / FLIGHT_PER_STAT * FLIGHT_PERCENT);
		}

		calcFlySpeed(){
			return calcBonusFly();
		}
