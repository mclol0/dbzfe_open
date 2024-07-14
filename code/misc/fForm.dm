var/fForm_factory/gForm = new/fForm_factory

fForm
	var
		fUNI = FALSE; // Is our form perm or not.
		name = NULL; // Name of form.
		bonusKI = 0; // Powerlevel mod from form.
		gMod = 0; // Gain mod from form.
		bonusSTR = 0; // Damage mod from form.
		bonusARM = 0; // Defense mod from form.
		bonusSTA = 0;	//Energy boost from form
		fsMod = 0; // Flight speed mod from form.
		fColor = NULL; // Form color.
		pColor = NULL; // Prompt color.
		fAbbr = NULL; // Form abbreviation.
		fCost = 0; // Form cost if any (this is for androids for now)
		gravRes = 0; //Gravity resistance modified to reduce damage under gravity

fForm_factory
	parent_type = /Factory
	objectType = /fForm

	proc
		getPLMod(var/request as text);
		getbonusSTR(var/request as text);
		getbonusARM(var/request as text);
		getFSMod(var/request as text);
		getGMod(var/request as text);
		getAbbr(var/request as text);
		getColor(var/request as text, var/text as text);
		getPColor(var/request as text, var/text as text);
		getFUni(var/request as text);
		getbonusSTA(var/request as text);
		getAuraColor(var/mob/user, var/request as text, var/text as text);
		getGravityResistance(var/request as text);

	getFUni(var/request as text){
		var/fForm/o = gForm.get(request);

		return o.fUNI;
	}

	getPLMod(var/request as text){
		var/fForm/o = gForm.get(request);

		return o.bonusKI;
	}

	getbonusSTR(var/request as text){
		var/fForm/o = gForm.get(request);

		return o.bonusSTR;
	}

	getbonusARM(var/request as text){
		var/fForm/o = gForm.get(request);

		return o.bonusARM;
	}

	getFSMod(var/request as text){
		var/fForm/o = gForm.get(request);

		return o.fsMod;
	}

	getGMod(var/request as text){
		var/fForm/o = gForm.get(request);

		return o.gMod;
	}

	getbonusSTA(var/request as text){
		var/fForm/o = gForm.get(request);

		return o.bonusSTA;
	}

	getGravityResistance(var/request as text){
		var/fForm/o = gForm.get(request);

		return o.gravRes;
	}

	getAbbr(var/request as text){
		var/fForm/o = gForm.get(request);

		if(o.fAbbr){
			return " [getPColor(request,"(")][getColor(request,o.fAbbr)][getPColor(request,")")]";
		}else{
			return NULL;
		}
	}

	getColor(var/request as text, var/text as text){
		var/fForm/o = gForm.get(request);

		return o.fColor + text + "{x";
	}

	getAuraColor(var/mob/user, var/request as text, var/text as text){
		var/fForm/o = gForm.get(request);

		if((isplayer(user) || isnpc(user)) && user.bursting && (user.form in list("Normal","FORM 1"))){
			return user.raceColor(text);
		}else if(!user.bursting && (user.form in list("Normal","FORM 1"))){
			return text;
		}

		return o.fColor + text + "{x";
	}

	getPColor(var/request as text, var/text as text){
		var/fForm/o = gForm.get(request);

		return o.pColor + text + "{x";
	}

	get(var/request as text){
		var/fForm/o = new objectType;

		switch(lowertext(request)){
			if("normal"){
				o.name = "Normal";
				o.fColor = "{W";
				o.pColor = NULL;
				o.fAbbr = NULL;
			}

			if("super saiyan"){
				o.name = "Super Saiyan";
				o.bonusKI = 1200;
				o.gMod = 0;
				o.bonusSTR = 250;
				o.fColor = "{Y";
				o.pColor = "{g";
				o.fAbbr = "SSJ";
				o.fsMod = 12;
				o.gravRes = 1;
			}

			if("super saiyan 2"){
				o.name = "Super Saiyan 2";
				o.bonusKI = 2400;
				o.gMod = 0;
				o.bonusSTR = 350;
				o.fColor = "{Y";
				o.pColor = "{g";
				o.fAbbr = "SSJ2";
				o.fsMod = 16;
				o.gravRes = 1;
			}

			if("super saiyan 3"){
				o.name = "Super Saiyan 3";
				o.bonusKI = 4800;
				o.gMod = 0;
				o.bonusSTR = 450;
				o.fColor = "{Y";
				o.pColor = "{g";
				o.fAbbr = "SSJ3";
				o.fsMod = 20;
				o.gravRes = 2;
			}

			if("super saiyan 4"){
				o.name = "Super Saiyan 4";
				o.bonusKI = 6500;
				o.gMod = 0;
				o.bonusSTR = 850;
				o.bonusARM = 400;
				o.bonusSTA = 400;
				o.fColor = "{r";
				o.pColor = "{Y";
				o.fAbbr = "SSJ4";
				o.fsMod = 30;
				o.gravRes = 2;
			}

			if("legendary ssj"){
				o.name = "Legendary SSJ";
				o.bonusKI = 5000;
				o.gMod = 0;
				o.bonusSTR = 500;
				o.bonusARM = 200;
				o.bonusSTA = 200;
				o.fColor = "{Y";
				o.pColor = "{g";
				o.fAbbr = "LSSJ";
				o.fsMod = 24;
				o.gravRes = 2;
			}

			if("legendary ssj2"){
				o.name = "Legendary SSJ2";
				o.bonusKI = 10000;
				o.gMod = 0;
				o.bonusSTR = 1000;
				o.bonusARM = 400;
				o.bonusSTA = 400;
				o.fColor = "{G";
				o.pColor = "{y";
				o.fAbbr = "LSSJ2";
				o.fsMod = 30;
				o.gravRes = 2;
			}

			if("legendary ssj3"){
				o.name = "Legendary SSJ3";
				o.bonusKI = 15000;
				o.gMod = 0;
				o.bonusSTR = 1200;
				o.bonusARM = 600;
				o.bonusSTA = 600;
				o.fColor = "{g";
				o.pColor = "{g";
				o.fAbbr = "LSSJ3";
				o.fsMod = 40;
				o.gravRes = 3;
			}

			if("legendary ssj4"){
				o.name = "Legendary SSJ4";
				o.bonusKI = 20000;
				o.gMod = 0;
				o.bonusSTR = 1500;
				o.bonusARM = 800;
				o.bonusSTA = 800;
				o.fColor = "{g";
				o.pColor = "{g";
				o.fAbbr = "LSSJ4";
				o.fsMod = 60;
				o.gravRes = 5;
			}

			if("super saiyan god"){
				o.name = "Super Saiyan God";
				o.bonusKI = 6000;
				o.gMod = 0;
				o.bonusSTR = 750;
				o.bonusARM = 750;
				o.bonusSTA = 200;
				o.fColor = "{R";
				o.pColor = "{r";
				o.fAbbr = "SSJG";
				o.fsMod = 28;
				o.gravRes = 3;
			}

			if("super saiyan blue"){
				o.name = "Super Saiyan Blue";
				o.bonusKI = 7000;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 800;
				o.bonusSTA = 300;
				o.fColor = "{C";
				o.pColor = "{c";
				o.fAbbr = "SSJB";
				o.fsMod = 30;
				o.gravRes = 4;
			}

			if("ultra instinct omen"){
				o.name = "Ultra Instinct Omen";
				o.bonusKI = 7000;
				o.gMod = 0;
				o.bonusSTR = 400;
				o.bonusARM = 600;
				o.bonusSTA = 100;
				o.fColor = "{B";
				o.pColor = "{W";
				o.fAbbr = "UIO";
				o.fsMod = 32;
				o.gravRes = 3;
			}

			if("ultra instinct"){
				o.name = "Ultra Instinct";
				o.bonusKI = 9001;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 800;
				o.bonusSTA = 250;
				o.fColor = "{B";
				o.pColor = "{W";
				o.fAbbr = "UI";
				o.fsMod = 36;
				o.gravRes = 4;
			}

			if("super saiyan rose"){
				o.name = "Super Saiyan Rose";
				o.bonusKI = 7000;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 800;
				o.bonusSTA = 300;
				o.fColor = "{M";
				o.pColor = "{m";
				o.fAbbr = "SSJR";
				o.fsMod = 30;
				o.gravRes = 4;
			}

			if("unlocked"){
				o.name = "Unlocked";
				o.bonusKI = 3600;
				o.gMod = 0;
				o.bonusSTR = 400;
				o.fColor = "{W";
				o.pColor = "{c";
				o.fAbbr = "Unlocked";
				o.fsMod = 20;
				o.gravRes = 2;
			}

			if("mystic"){
				o.name = "Mystic";
				o.bonusKI = 6200;
				o.gMod = 0;
				o.bonusSTR = 1200;
				o.bonusARM = 1200;
				o.fColor = "{W";
				o.pColor = "{C";
				o.fAbbr = "Mystic";
				o.fsMod = 26;
				o.gravRes = 4;
			}

			if("imperfect"){
				o.name = "Imperfect";
				o.bonusKI = 150;
				o.gMod = 0;
				o.bonusSTR = 50;
				o.bonusARM = 50;
				o.fColor = "{G";
				o.pColor = "{w";
				o.fAbbr = "Imperfect";
				o.fUNI = TRUE;
				o.fsMod = 0;
			}

			if("semi-perfect"){
				o.name = "Semi-Perfect";
				o.bonusKI = 2250;
				o.gMod = 0;
				o.bonusSTR = 200;
				o.bonusARM = 200;
				o.fColor = "{G";
				o.pColor = "{R";
				o.fAbbr = "Semi-Perfect";
				o.fUNI = TRUE;
				o.fsMod = 12;
				o.gravRes = 1;
			}

			if("perfect"){
				o.name = "Perfect";
				o.bonusKI = 3250;
				o.gMod = 0;
				o.bonusSTR = 400;
				o.bonusARM = 400;
				o.fColor = "{G";
				o.pColor = "{R";
				o.fAbbr = "Perfect";
				o.fUNI = TRUE;
				o.fsMod = 20;
				o.gravRes = 2;
			}

			if("super perfect"){
				o.name = "Super Perfect";
				o.bonusKI = 6650;
				o.gMod = 0;
				o.bonusSTR = 1200;
				o.bonusARM = 1200;
				o.fColor = "{G";
				o.pColor = "{R";
				o.fAbbr = "Super Perfect";
				o.fUNI = TRUE;
				o.fsMod = 26;
				o.gravRes = 4;
			}

			if("enhanced namek"){
				o.name = "Enhanced Namek";
				o.bonusKI = 2250;
				o.gMod = 0;
				o.bonusSTR = 400;
				o.bonusARM = 400;
				o.fColor = "{G";
				o.pColor = "{W";
				o.fAbbr = "Enhanced Namek";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 2;
			}

			if("super namek"){
				o.name = "Super Namek";
				o.bonusKI = 7250;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 800;
				o.fColor = "{G";
				o.pColor = "{R";
				o.fAbbr = "Super Namek";
				o.fUNI = TRUE;
				o.fsMod = 26;
				o.gravRes = 4;
			}

			if("kaioken"){
				o.name = "Kaioken";
				o.bonusKI = 4000;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusSTA = 200;
				o.fColor = "{R";
				o.pColor = "{r";
				o.fAbbr = "Kaioken";
				o.fsMod = 20;
				o.gravRes = 4;
			}

			if("kaioken x2"){
				o.name = "Kaioken x2";
				o.bonusKI = 600;
				o.gMod = 0;
				o.bonusSTR = 600;
				o.fColor = "{R";
				o.pColor = "{r";
				o.fAbbr = "Kaioken x2";
				o.fsMod = 8;
				o.gravRes = 1;
			}

			if("kaioken x3"){
				o.name = "Kaioken x3";
				o.bonusKI = 800;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.fColor = "{R";
				o.pColor = "{r";
				o.fAbbr = "Kaioken x3";
				o.fsMod = 12;
				o.gravRes = 2;
			}

			if("kaioken x4"){
				o.name = "Kaioken x4";
				o.bonusKI = 1000;
				o.gMod = 0;
				o.bonusSTR = 1400;
				o.fColor = "{r";
				o.pColor = "{r";
				o.fAbbr = "Kaioken x4";
				o.fsMod = 18;
				o.gravRes = 3;
			}

			if("super kaioken"){
				o.name = "Super Kaioken";
				o.bonusKI = 3850;
				o.gMod = 0;
				o.bonusSTR = 1500;
				o.fColor = "{R";
				o.pColor = "{R";
				o.fAbbr = "Super Kaioken";
				o.fsMod = 30;
				o.gravRes = 5;
			}

			if("oozaru"){
				o.name = "Oozaru";
				o.bonusKI = 1200
				o.gMod = 0;
				o.bonusSTR = 800
				o.bonusARM = 800
				o.fColor = "{R";
				o.pColor = "{c";
				o.fAbbr = "Oozaru";
				o.fsMod = 3;
				o.gravRes = 4;
			}

			if("form 1"){
				o.name = "FORM 1";
				o.fColor = "{m";
				o.fAbbr = "FORM 1";
			}

			if("form 2"){
				o.name = "FORM 2";
				o.bonusKI = 1250;
				o.gMod = 0;
				o.bonusSTR = 200;
				o.fColor = "{M";
				o.pColor = "{m";
				o.fAbbr = "FORM 2";
				o.fsMod = 12;
				o.gravRes = 1;
			}

			if("form 3"){
				o.name = "FORM 3";
				o.bonusKI = 2150;
				o.gMod = 0;
				o.bonusSTR = 400;
				o.bonusARM = 100;
				o.fColor = "{M";
				o.pColor = "{m";
				o.fAbbr = "FORM 3";
				o.fsMod = 16;
				o.gravRes = 2;
			}

			if("form 4"){
				o.name = "FORM 4";
				o.bonusKI = 3150;
				o.gMod = 0;
				o.bonusSTR = 600;
				o.fColor = "{w";
				o.pColor = "{m";
				o.fAbbr = "FORM 4";
				o.fsMod = 20;
				o.gravRes = 3;
			}

			if("golden form 4"){
				o.name = "GOLDEN FORM 4";
				o.bonusKI = 6500;
				o.gMod = 0;
				o.bonusSTR = 600;
				o.bonusARM = 600;
				o.fColor = "{Y";
				o.pColor = "{Y";
				o.fAbbr = "GOLDEN FORM 4";
				o.fsMod = 30;
				o.gravRes = 5;
			}

			if("form 5"){
				o.name = "FORM 5";
				o.bonusKI = 5200;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 400;
				o.fColor = "{w";
				o.pColor = "{Y";
				o.fAbbr = "FORM 5";
				o.fsMod = 26;
				o.gravRes = 4;
			}

			if("golden form 5"){
				o.name = "GOLDEN FORM 5";
				o.bonusKI = 7250;
				o.gMod = 0;
				o.bonusSTR = 900;
				o.bonusARM = 600;
				o.fColor = "{Y";
				o.pColor = "{Y";
				o.fAbbr = "GOLDEN FORM 5";
				o.fsMod = 30;
				o.gravRes = 5;
			}

			if("spirit burst"){
				o.name = "Spirit Burst";
				o.bonusKI = 5500;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 400;
				o.bonusSTA = 200;
				o.fColor = "{W";
				o.pColor = "{y";
				o.fAbbr = "SPIRIT";
				o.fsMod = 24;
				o.gravRes = 4;
			}

			if("super android"){
				o.name = "Super Android";
				o.bonusKI = 5000;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 600;
				o.bonusSTA = 100;
				o.fColor = "{D";
				o.pColor = "{R";
				o.fAbbr = "SUPER";
				o.fUNI = TRUE;
				o.fsMod = 17;
				o.fCost = 30;
				o.gravRes = 4;
			}

			if("super"){
				o.name = "Super";
				o.bonusKI = 3500;
				o.gMod = 0;
				o.bonusSTR = 400;
				o.bonusARM = 600
				o.fColor = "{M";
				o.pColor = "{B";
				o.fAbbr = "Super";
				o.fUNI = TRUE;
				o.fsMod = 20;
				o.gravRes = 2;
			}

			if("kid"){
				o.name = "Kid";
				o.bonusKI = 4800;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 800;
				o.fColor = "{M";
				o.pColor = "{W";
				o.fAbbr = "Kid";
				o.fUNI = TRUE;
				o.fsMod = 26;
				o.gravRes = 4;
			}

			if("ascended"){
				o.name = "Ascended";
				o.bonusKI = 7000;
				o.gMod = 0;
				o.bonusSTR = 1000;
				o.bonusARM = 1000;
				o.bonusSTA = 1000;
				o.fColor = "{w";
				o.pColor = "{C";
				o.fAbbr = "Ascended";
				o.fsMod = 100;
				o.gravRes = 4;
			}

			if("noble"){
				o.name = "Noble";
				o.bonusKI = 2300;
				o.gMod = 0;
				o.bonusSTR = 333;
				o.bonusARM = 333;
				o.bonusSTA = 333;
				o.fColor = "{R";
				o.pColor = "{m";
				o.fAbbr = "Noble";
				o.fUNI = TRUE;
				o.fsMod = 11;
				o.gravRes = 1;
			}

			if("aristocrat"){
				o.name = "Aristocrat";
				o.bonusKI = 4500;
				o.gMod = 0;
				o.bonusSTR = 666;
				o.bonusARM = 666;
				o.bonusSTA = 666;
				o.fColor = "{r";
				o.pColor = "{W";
				o.fAbbr = "Aristocrat";
				o.fUNI = TRUE;
				o.fsMod = 15;
				o.gravRes = 2;
			}

			if("deity"){
				o.name = "Deity";
				o.bonusKI = 6200;
				o.gMod = 0;
				o.bonusSTR = 888;
				o.bonusARM = 888;
				o.bonusSTA = 888;
				o.fColor = "{R";
				o.pColor = "{W";
				o.fAbbr = "Deity";
				o.fUNI = TRUE;
				o.fsMod = 26;
				o.gravRes = 4;
			}

			if("enhanced"){
				o.name = "Enhanced";
				o.bonusKI = 5750;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 1000;
				o.bonusSTA = 450;
				o.fColor = "{W";
				o.pColor = "{w";
				o.fAbbr = "Enhanced";
				o.fsMod = 26;
				o.gravRes = 4;
			}

			// SPIRITS
			if("phantasm"){
				o.name = "Phantasm";
				o.bonusKI = 0;
				o.gMod = 0;
				o.bonusSTR = 0;
				o.bonusARM = 0;
				o.fColor = "{D";
				o.pColor = "{D";
				o.fAbbr = "Phantasm";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 1;
			}

			if("shade"){
				o.name = "Shade";
				o.bonusKI = 1400;
				o.gMod = 0;
				o.bonusSTR = 100;
				o.bonusARM = 100;
				o.bonusSTA = 150;
				o.fColor = "{D";
				o.pColor = "{D";
				o.fAbbr = "Shade";
				o.fUNI = TRUE;
				o.fsMod = 19;
				o.gravRes = 2;
			}

			if("shadow"){
				o.name = "Shadow";
				o.bonusKI = 2400;
				o.gMod = 0;
				o.bonusSTR = 250;
				o.bonusARM = 250;
				o.bonusSTA = 400;
				o.fColor = "{D";
				o.pColor = "{D";
				o.fAbbr = "Shadow";
				o.fUNI = TRUE;
				o.fsMod = 22;
				o.gravRes = 3;
			}

			if("spectre"){
				o.name = "Spectre";
				o.bonusKI = 2750;
				o.gMod = 0;
				o.bonusSTR = 400;
				o.bonusARM = 400;
				o.bonusSTA = 700;
				o.fColor = "{D";
				o.pColor = "{D";
				o.fAbbr = "Spectre";
				o.fUNI = TRUE;
				o.fsMod = 25;
				o.gravRes = 4;
			}

			if("revenant"){
				o.name = "Revenant";
				o.bonusKI = 6600;
				o.gMod = 0;
				o.bonusSTR = 725;
				o.bonusARM = 725;
				o.bonusSTA = 1000;
				o.fColor = "{r";
				o.pColor = "{r";
				o.fAbbr = "{rRevenant";
				o.fUNI = TRUE;
				o.fsMod = 32;
				o.gravRes = 5;
			}

			if("neomachine"){
				o.name = "NeoMachine";
				o.bonusKI = 8000;
				o.gMod = 0;
				o.bonusSTR = 1000;
				o.bonusARM = 200;
				o.bonusSTA = 400;
				o.fColor = "{W";
				o.pColor = "{W";
				o.fAbbr = "{CNEO";
				o.fUNI = TRUE;
				o.fsMod = 25;
				o.fCost = 50;
				o.gravRes = 3;
			}

			if("overclocked"){
				o.name = "Overclocked";
				o.bonusKI = 13000;
				o.gMod = 0;
				o.bonusSTR = 1000;
				o.bonusARM = 1000;
				o.bonusSTA = 1000;
				o.fColor = "{C";
				o.pColor = "{C";
				o.fAbbr = "{COverclocked";
				o.fUNI = TRUE;
				o.fsMod = 45;
				o.gravRes = 8;
			}

			if("npc_withered"){
				o.name = "Withered";
				o.bonusKI = 500;
				o.gMod = 0;
				o.bonusSTR = 100;
				o.bonusARM = 50;
				o.bonusSTA = 50;
				o.fColor = "{D";
				o.pColor = "{D";
				o.fAbbr = "{CWi{cth{Ber{bed{x";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 3;
			}

			if("npc_alien"){
				o.name = "Alien";
				o.bonusKI = 500;
				o.gMod = 0;
				o.bonusSTR = 550;
				o.bonusARM = 250;
				o.bonusSTA = 250;
				o.fColor = "{m";
				o.pColor = "{m";
				o.fAbbr = "{RAlien{x";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 3;
			}

			if("npc_alien2"){
				o.name = "Alien";
				o.bonusKI = 950;
				o.gMod = 0;
				o.bonusSTR = 550;
				o.bonusARM = 250;
				o.bonusSTA = 250;
				o.fColor = "{B";
				o.pColor = "{B";
				o.fAbbr = "{RAlien{x";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 3;
			}

			if("npc_alien3"){
				o.name = "Sea Creature";
				o.bonusKI = 7250;
				o.gMod = 0;
				o.bonusSTR = 2250;
				o.bonusARM = 350;
				o.bonusSTA = 250;
				o.fColor = "{c";
				o.pColor = "{c";
				o.fAbbr = "{CSea Creature{x";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 3;
			}

			if("npc_blessed"){
				o.name = "blessed";
				o.bonusKI = 500;
				o.gMod = 0;
				o.bonusSTR = 200;
				o.bonusARM = 100;
				o.bonusSTA = 100;
				o.fColor = "{Y";
				o.pColor = "{Y";
				o.fAbbr = "{WBl{wes{Yse{yd";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 4;
			}

			if("npc_replica"){
				o.name = "replica";
				o.bonusKI = 2500;
				o.gMod = 0;
				o.bonusSTR = 1500;
				o.bonusARM = 800;
				o.bonusSTA = 500;
				o.fColor = "{D";
				o.pColor = "{D";
				o.fAbbr = "{WRe{wpl{Yic{ya";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 4;
			}

			if("npc_replica2"){
				o.name = "replica";
				o.bonusKI = 4200;
				o.gMod = 0;
				o.bonusSTR = 1800;
				o.bonusARM = 1300;
				o.bonusSTA = 500;
				o.fColor = "{D";
				o.pColor = "{D";
				o.fAbbr = "{ROver{rclocked";
				o.fUNI = TRUE;
				o.fsMod = 16;
				o.gravRes = 4;
			}

			if("npc_supressed"){
				o.name = "Suppressed";
				o.bonusKI = 500;
				o.gMod = 0;
				o.bonusSTR = 1500;
				o.bonusARM = 1000;
				o.bonusSTA = 1000;
				o.fColor = "{w";
				o.pColor = "{C";
				o.fAbbr = "Suppressed";
				o.fsMod = 100;
				o.gravRes = 4;
			}

			if("npc_mystic"){
				o.name = "Mystic";
				o.bonusKI = 5000;
				o.gMod = 0;
				o.bonusSTR = 800;
				o.bonusARM = 800;
				o.fColor = "{W";
				o.pColor = "{C";
				o.fAbbr = "Mystic";
				o.fsMod = 26;
				o.gravRes = 4;
			}

		}

		return o;
	}
