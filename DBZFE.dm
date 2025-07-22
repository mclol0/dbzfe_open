var/DBZFE/game = new()
var/Shop/shop = new()
var/MUDbase/MUDbase = new()
var/fQuest_Factory/qFac = new/fQuest_Factory
var/textLib = "lib/unix/parseText.so";
var/cryptoLib = "lib/unix/crypto.so";
var/BuildDate = "July 21rst 2025";

world
	name = "Drag(*)nBall Z: Fighter Edition"
	hub = "Gokussj99.dbzfe"
	hub_password = "NDzSjOrL7ZCJrrAR"
	fps = FPS // PULSES PER SECOND
	mob = /mob/cClient;
	turf = /turf/void;
	view = 5

	loop_checks = FALSE;

	New(){
		..()

		game.DB = new("dbzfe.db")

		world.SetConfig("APP/admin", ckey("Gokussj99"), "role=root");

		log = file("error.log")

		//game.logger.htmlFileConfig("worldlog.html");
		//game.logger.setLevel(LOG_ALL);
		//game.logger.startLogging();

		game.loadBans();
		game.loadDragonballs();
		game.buildSkill_list();
		game.buildMystery_list();
		game.buildEvent_list();
		game.buildItem_list();
		game.buildNPC_list();
		game.healSafe();
		game.itemValues();
		game.initShops();
		game.dailyReboot();
		game.updateRanking();
		houseSystem.loadSystemData();
		helpSystem.loadSystem();

		if(fexists(file("copyover/"))){
			game.logger.info("Recovering from a copyover.");
			spawn(4){
				game.logger.info("Copyover complete.");
				fdel(file("copyover/"));
			}
		}

		game.logger.info("[world.name] started on port [world.port]");

		for(var/moon/m){ m._loadMoon(); }
	}

	Del(){
		for(var/obj/item/corpse/i){ del(i); } // Clean up corpses in mud (save player corpses) incase of pre-mature shutdown.
		for(var/mob/Player/m){ if(m.hasDB()){ m.dropDragonballs(); } }
		for(var/moon/m){ m._saveMoon(); }
		game.logger.info("[world.name] has shutdown.");
		game.logger.endLogging();
		game.saveDragonballs();
		..()
	}