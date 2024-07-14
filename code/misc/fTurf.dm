turf
	proc
		Change(type){
			var/turf/T = src
			src = NULL;
			T = new type(T)
		}

		returnLocation(atom/a){
			if(isplayer(a) && a:spacePod && (a in a:spacePod:passengers)){ return "Spacepod"}

			if(!location){
				if(isplanet(a.loc.loc)){
					var/x = game.mapdir(a_get_dir(a.loc.loc:center,a));

					return "{C[x]{x";
				}else{
					return "{YERROR.{x";
				}
			}else{
				return location;
			}
		}

		showDisplay() {
			return display
		}

	icon='rsc/tiles.dmi'

	var
		location = NULL;
		ignoreDensity = 0
		tType = 0
		//opacityDisplay = " "
		possibleDisplay[] = list();
		gravity = NULL

	arena
		density = TRUE;
		display = "{RA{x";
		text = "<font color=red>A</font>";

	void
		density = TRUE;
		opacity = TRUE;
		display = " "
		text = " "

	space
		name = "{WSpace{x"
		display = "."
		text = "."
		//possibleDisplay = list("{Y*{x", "{B*{x", "{Y.{x", "{B.{x", "{R.{x", " ", " ", " ", " ", "{W*{x", " ", " ", "{W.{x"," ", " ", " ", " ", " ", " "," ", " ", " ", " ", " ", " "," ", " ", " ", " ", " ", " "," ", " ", " ", " ", " ", " "," ", " ", " ", " ", " ", " ");

		New(){
			..()

			if(prob(2)){
				display = pick(list("{Y*{x","{B*{x","{R*{x","{Y.{x","{B.{x","{G.{x","{G*{x","{r.{x","{y.{x","{r*{x","{m*{x"));
			}else if(prob(6)){
				display = "{W.{x";
			}else{
				display = " ";
			}

			//display = pick(list("{Y*{x", "{B*{x", "{Y.{x", "{B.{x", "{R.{x", " ", " ", " ", " ", "{W*{x", " ", " ", "{W.{x"," ", " ", " ", " ", " ", " "," ", " ", " ", " ", " ", " "," ", " ", " ", " ", " ", " "," ", " ", " ", " ", " ", " "," ", " ", " ", " ", " ", " " , " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "));
		}

	arena_floor
		display = "{W#{x"
		text = "<font color=white>#</font>"


	king_kaio_planet
		name = "{CKing Kai's{x {YPlanet{x";

		road
			display = "{W#{x";
			text = "#";

		Droad
			display = "{w#{x";
			text = "<font color=white>#</font>"

		sidewalk
			display = "|";
			text = "|";

		Lowwalk
			display = "_";
			text = "_";

		Pillar_base
			display = "{Y_{x";
			text = "<font color=YELLOW>_</font>"

		Lowwall
			display = "_";
			text = "_";
			density = TRUE

		highwalk
			display = "-";
			text = "-";


		Gold_trim
			display = "{Y-{x";
			text = "<font color=YELLOW>-</font>"

	vegeta
		name = "{RVegeta{x"

		ground
			tType = DIRT;
			display = "{y'{x";
			text = "<font color=yellow>'</font>"

		mountain
			tType = MOUNTAIN;
			display = "{r^{x";
			text = "<font color=red>^</font>";
			density = TRUE;

		water
			tType = WATER;
			display = "{r~{x"
			text = "<font color=red>~</font>";
			possibleDisplay = list("{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{R~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x","{r~{x")

		river
			tType = WATER;
			display = "{M\"{x";
			text = "<font color=purple>\"</font>";

	namek
		name = "{gNamek{x"

		safe_zone
			location = "{YSafe Zone{x";
			icon_state="safe"
			display = "{Y.{x"
			text = "<font color=yellow>.</font>"

		tower_wall
			icon_state="Tower Wall"
			tType = TREE
			display = "|"
			text = "|"
			density = TRUE

		pillar_wall_M
			icon_state="Pillar Wall"
			tType = TREE
			display = "{W*{x"
			text = "<font color=WHITE>*</font>"

		pillar_wall_l
			icon_state="Pillar Wall"
			tType = TREE
			display = "{W{{x"
			text = "<font color=WHITE>{</font>"
			density = TRUE

		pillar_wall_r
			icon_state="Pillar Wall"
			tType = TREE
			display = "{W}{x"
			text = "<font color=WHITE>}</font>"
			density = TRUE

		tree_base
			icon_state="namek_tree_base"
			tType = TREE
			display = "{y|{x"
			text = "<font color=yellow>|</font>"
			density = TRUE

		tree
			icon_state="namek_tree"
			tType = TREE
			display = "{g@{x"
			text = "<font color=green>@</font>"
			density = TRUE

		namek_mountain
			icon_state="earth_mountains"
			tType = MOUNTAIN
			display = "{y^{x"
			text = "<font color=yellow>^</font>"
			density = TRUE

		grass
			icon_state="namek_grass"
			tType = DIRT
			display = "{C.{x"
			text = "<font color=green>.</font>"

		water
			icon_state="namek_water"
			tType = WATER
			display = "{g~{x"
			text = "<font color=green>~</font>"
			possibleDisplay = list("{g~{x","{g~{x","{g~{x","{g~{x","{g~{x","{g~{x","{g~{x","{g~{x","{g~{x","{G~{x")


	freezer
		icon='rsc/icons.dmi';
		name = "{MFrieza{x"

		sand
			tType = DIRT
			display="{w.{x"
			text="<font color=red>,</font>"

		grass
			icon_state="snow_mountain";
			tType = DIRT
			display="{W,{x"
			text="<font color=#ffffff>,</font>"

		mountain
			tType = MOUNTAIN
			display = "{r^{x"
			text = "<font color=#cf0000>^</font>"
			density = TRUE;

		water
			tType = WATER
			display = "{m~{x"
			text = "<font color=#cf00cf>~</font>"
			possibleDisplay = list("{m~{x","{m~{x","{m~{x","{m~{x","{m~{x","{m~{x","{M~{x")

		river
			tType = WATER
			display = "{M~{x"
			text = "<font color=#ff00ff>~</font>"

	earth
		icon='rsc/icons.dmi';
		name = "{YEarth{x"

		kame_wall
			icon_state="namek_tree_base"
			tType = TREE
			display = "{M|{x"
			text = "<font color=#ff00ff>|</font>"
			density = TRUE

		kame_roof
			display = "{R@{x"
			text = "<font color=RED>@</font>"
			density = TRUE

		kame_trim
			display = "{R-{x"
			text = "<font color=RED>-</font>"
			density = TRUE

		kame_paint_k
			display = "{RK{x"
			text = "<font color=RED>K</font>"
			density = TRUE

		kame_paint_a
			display = "{RA{x"
			text = "<font color=RED>A</font>"
			density = TRUE

		kame_paint_m
			display = "{RM{x"
			text = "<font color=RED>M</font>"
			density = TRUE

		kame_paint_e
			display = "{RE{x"
			text = "<font color=RED>E</font>"
			density = TRUE

		snowmountain
			icon_state="snow_mountains"
			tType = MOUNTAIN
			display = "{W^{x"
			text = "<font color=white>^</font>"
			density = TRUE;

		safe_zone
			location = "{YSafe Zone{x";
			icon_state="safe"
			display = "{Y'{x"
			text = "<font color=yellow>'</font>"

		grass
			icon_state="grass"
			tType = DIRT
			display = "{g.{x"
			text = "<font color=green>.</font>"

		river
			icon_state="river"
			tType = WATER
			display = "{C\"{x"
			text = "<font color=cyan>\"</font>"

		water
			icon_state="water"
			tType = WATER
			display = "{b~{x"
			text = "<font color=blue>~</font>"
			//possibleDisplay = list("{B'{x","{B'{x","{B'{x","{B'{x","{B'{x","{B'{x","{B'{x","{C\"{x","{b'{x","{b'{x","{b'{x","{b'{x","{b'{x","{b'{x","{b'{x")
			possibleDisplay = list("{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{B~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{B~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{B~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{B~{x","{b~{x","{b~{x","{C~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x")

		clouds
			icon_state="clouds"
			tType = WATER
			display = "{W~{x"
			text ="<font color=WHITE>~</font>"
			possibleDisplay = list("{W~{x","{W~{x","{w~{x","{W~{x","{W~{x","{w~{x","{W~{x","{Y~{x","{W~{x","{w~{x","{W~{x","{w~{x","{W~{x","{W~{x","{w~{x","{W~{x","{W~{x","{W~{x","{W~{x","{W~{x","{W~{x","{W~{x","{Y~{x","{W~{x","{W~{x","{w~{x","{W~{x","{W~{x")

		Wclouds
			icon_state="clouds"
			tType = WATER
			display = "{W@{x"
			text ="<font color=WHITE>@</font>"
			possibleDisplay = list("{W@{x","{W@{x","{w@{x","{W@{x","{W@{x","{w@{x","{w@{x","{W@{x","{D@{x","{w@{x","{W@{x","{w@{x","{W@{x","{W@{x","{w@{x","{W@{x","{D@{x","{D@{x","{D@{x","{w~{x","{W~{x","{W~{x","{W@{x")

		sand
			icon_state="sand"
			tType = DIRT
			display = "{y.{x"
			text = "<font color=#CC9900>.</font>"

		sky
			icon_state="sand"
			tType = MOUNTAIN
			display = "{C.{x"
			text = "<font color=cyan>.</font>"

		mountain
			icon_state="earth_mountains"
			tType = MOUNTAIN
			opacity=FALSE
			display = "{g^{x"
			text = "<font color=green>^</font>"
			density = TRUE

		gero_lab
			location = "{DDr. Gero's{x {yLab{x";
			icon_state="lab"
			tType = BUILDING
			opacity = FALSE
			display = "{RL{x"
			text = "<font color=red>L</font>"
			density = FALSE

		korins_tower
			icon_state="ktower"
			tType=BUILDING
			display="{YH{x"
			text="<font color=grey>H</font>"
			density=FALSE

		HBTC
			icon_state="HBTC"
			tType=BUILDING
			display="{C%{x"
			text="<font color=CYAN>%</font>"
			density=FALSE

		UNDERWATER_LAKE
			icon_state="HBTC"
			tType=BUILDING
			display="{CL{x"
			text="<font color=CYAN>L</font>"
			density=FALSE

		SILENT_BUBBLE
			icon_state="HBTC"
			tType=BUILDING
			display="{Wo{x"
			text="<font color=WHITE>o</font>"
			density=FALSE


		gero_wall
			icon_state="earth_mountains"
			tType=MOUNTAIN
			opacity=FALSE
			display="{D@{x"
			text="<font color=grey>@</font>"
			density=TRUE

		gero_mud
			icon_state="earth_mountains"
			tType=MOUNTAIN
			opacity=FALSE
			display="{y@{x"
			text="<font color=yellow>@</font>"
			density=TRUE

		exit
			tType=EXIT
			display="{RE{x"
			text="<font color=RED>E</font>"

	arlia
		name = "{rArlia{x";


		arlia_ground
			text = "<font color=yellow>,</font>";
			display = "{y,{x";
			tType = DIRT;

		arlia_water
			text = "<font color=red>~</font>";
			display = "{r~{x"
			possibleDisplay = list("{R\"{x","{r'{x")
			tType = WATER

		arlia_mountain
			text = "<font color=yellow>^</font>"
			display = "{y^{x"
			tType = MOUNTAIN
			density = TRUE
	moon
		moon_lab_secret
			tType=BUILDING
			display="{DL{x"
			text="<font color=GRAY>L</font>"
			density=FALSE

		moon_lab_lair
			tType=BUILDING
			display="{Yo{x"
			text="<font color=YELLOW>o</font>"
			density=FALSE

		moon_lab_lair_basement
			tType=BUILDING
			display="{Yo{x"
			text="<font color=YELLOW>o</font>"
			density=FALSE

	snake_way
		name = "{YSnake Way{x"

		snake_clouds
			icon_state="snakeway_clouds"
			text = "<font color=white>%</font>"
			display = "{W%{x"
			possibleDisplay = list("{Y~{x"," "," "," "," "," "," "," "," "," "," "," "," ")

			Entered(mob/M){
				if(isnpc(M)){ return ..() }

				var/h = findCloudDatum(M);

				if(!h){
					new /cloudDatum(M,src)
				}else{
					return ..()
				}

				..()
			}

		snake_floor
			icon_state="snakeway_floor"
			text = "<font color=yellow>.</font>"
			display = "{m.{x"
			tType = FLOOR;
			opacity = TRUE;

		snake_wall
			icon_state="snakeway_edge"
			text = "<font_color=brown>n</font>"
			display = "{g^{x"
			tType = WALL;
			opacity = FALSE;
			density = TRUE;

	hfil
		name = "{RHFIL{x"

		hfil_floor
			icon_state="floor"
			text = "<font color=red>~</font>"
			display = "{R~{x"
			possibleDisplay = list("{R~{x","{R~{x","{r\"{x");
			tType = WATER;
			opacity = TRUE;

	kaishin
		name = "{CK{x{ma{x{Ci{x{ms{x{Ch{x{mi{x{Cn{x"

		water
			tType = WATER
			display = "{m~{x"
			text = "<font color=#cf00cf>~</font>"
			possibleDisplay = list("{b~{x","{b~{x","{m~{x","{m~{x","{b~{x","{b~{x","{C~{x","{m~{x","{b~{x","{C~{x","{b~{x","{m~{x","{m~{x","{C~{x")



		mountain
			tType = MOUNTAIN
			display = "{c^{x"
			text = "<font color=cyan>^</font>"
			density = TRUE;

		flowers
			tType = DIRT
			display="{M@{x"
			text="<font color=purple>@</font>"
			possibleDisplay = list("{M@{x","{g@{x","{C@{x","{m@{x","{Y@{x","{B@{x","{M@{x","{C@{x","{m@{x","{Y@{x","{o@{x","{R@{x","{M@{x","{W@{x")


		grass
			tType = DIRT
			display="{C,{x"
			text="<font color=cyan>,</font>"

		kaifruit
			tType = DIRT
			display="{Ro{x"
			text="<font color=RED>o</font>"
			possibleDisplay = list("{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Ro{x","{Yo{x")
	bas
		name = "{MBas"

		water
			tType = WATER
			display = "{m~{x"
			text = "<font color=#cf00cf>~</font>"
			possibleDisplay = list("{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{b~{x","{m~{x","{m~{x","{m~{x","{m~{x","{m~{x","{m~{x","{m~{x","{b~{x","{b~{x","{m~{x","{b~{x","{b~{x","{m~{x","{m~{x","{b~{x","{b~{x","{m~{x","{m~{x","{b~{x","{b~{x","{m~{x","{b~{x","{b~{x","{m~{x","{m~{x","{b~{x","{b~{x","{m~{x","{m~{x","{b~{x","{b~{x","{m~{x","{b~{x","{b~{x","{m~{x","{M~{x")
		river
			tType = WATER
			display = "{M\"{x"
			text = "<font color='#F000DC'>\"</font>"
			density = TRUE;