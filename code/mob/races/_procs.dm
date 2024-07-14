proc
	rankColor(race,text){
		switch(race){
			if(SAIYAN){
				return "{c[text]{x"
			}
			if(LEGENDARY_SAIYAN){
				return "{c[text]{x"
			}
			if(HUMAN){
				return "{y[text]{x"
			}
			if(NAMEK){
				return "{g[text]{x"
			}
			if(ANDROID){
				return "{D[text]{x"
			}
			if(SAIBAMAN){
				return "{g[text]{x"
			}
			if(MUTANT){
				return "{r[text]{x"
			}
			if(ICER){
				return "{m[text]{x"
			}
			if(BIO_ANDROID){
				return "{G[text]{x"
			}
			if(ALIEN){
				return "{B[text]{x"
			}
			if(ARLIAN){
				return "{B[text]{x"
			}
			if(SHINJIN){
				return "{C[text]{x"
			}
			if(HALFBREED){
				return "{C[text]{x"
			}
			if(IMMORTAL){
				return "{o[text]{x"
			}
			if(SPIRIT){
				return "{W[text]{x"
			}
			if(DEMON){
				return "{R[text]{x"
			}
			if(GENIE){
				return "{M[text]{x"
			}
			if(GOD_RACE){
				return "{o[text]{x"
			}
			if(KAIO){
				return "{w[text]{x"
			}
			if(MAKYAN){
				return "{r[text]{x"
			}
			if(KANASSAN){
				return "{b[text]{x"
			}
			if(ALIEN){
				return "{Y[text]{x"
			}
			if(SPIRIT){
				return "{W[text]{x"
			}		
			if(REMORT_ANDROID){
				return "{D[text]{x"
			}	
		}
		return rStrip_Escapes(text)
	}

	getMinPL(race){
		switch(race){
			if(SAIYAN) return 250;
			if(HUMAN) return 200;
			if(NAMEK) return 275;
			if(ANDROID) return 300;
			if(ICER) return 300;
			if(HALFBREED) return 225;
			if(KAIO) return 225;
			if(DEMON) return 250;
			if(GENIE) return 375;
			if(KANASSAN) return 250;
			if(ALIEN) return 300;
			if(BIO_ANDROID) return 300;
			if(SPIRIT) return 220;
			if(IMMORTAL) return MAX_PL;

			if(LEGENDARY_SAIYAN) return 500;
			if(REMORT_ANDROID) return 500;
		}
	}

	getRaceName(race){
		switch(race){
			if(SAIYAN) return "Saiyan";
			if(HUMAN) return "Human";
			if(NAMEK) return "Namekian";
			if(ANDROID) return "Android";
			if(ICER) return "Icer";
			if(HALFBREED) return "Halfbreed";
			if(IMMORTAL) return "Immortal";
			if(KAIO) return "Kaio";
			if(MAKYAN) return "Makyan";
			if(DEMON) return "Demon";
			if(GENIE) return "Genie";
			if(KANASSAN) return "Kanassan";
			if(ALIEN) return "Alien";
			if(BIO_ANDROID) return "Bio-Android";
			if(SPIRIT) return "Spirit";

			if(LEGENDARY_SAIYAN) return "Saiyan";
			if(REMORT_ANDROID) return "Android";
		}

		return "?ERROR?";
	}

mob
	proc
		raceColor(text){
			if(isplayer(src) && isImm){
				return "{o[text]{x"
			}else if(form != "Normal"){
				return gForm.getColor(form,text)
			}else{
				switch(race){
					if(SAIYAN){
						return "{c[text]{x"
					}
					if(LEGENDARY_SAIYAN){
						return "{c[text]{x"
					}
					if(HUMAN){
						return "{y[text]{x"
					}
					if(NAMEK){
						return "{g[text]{x"
					}
					if(ANDROID){
						return "{D[text]{x"
					}
					if(SAIBAMAN){
						return "{g[text]{x"
					}
					if(MUTANT){
						return "{r[text]{x"
					}
					if(GOD_RACE){
						return "{o[text]{x"
					}
					if(ICER){
						return "{m[text]{x"
					}
					if(BIO_ANDROID){
						return "{G[text]{x"
					}
					if(ALIEN){
						return "{B[text]{x"
					}
					if(ARLIAN){
						return "{B[text]{x"
					}
					if(SHINJIN){
						return "{C[text]{x"
					}
					if(HALFBREED){
						return "{C[text]{x"
					}
					if(SPIRIT){
						return "{W[text]{x"
					}
					if(DEMON){
						return "{r[text]{x"
					}
					if(GENIE){
						return "{M[text]{x"
					}
					if(KAIO){
						return "{w[text]{x"
					}
					if(MAKYAN){
						return "{r[text]{x"
					}
					if(KANASSAN){
						return "{b[text]{x"
					}
					if(SPIRIT) {
						return "{w[text]{x"
					}
					if(REMORT_ANDROID){
						return "{D[text]{x"
					}
				}
			}

			return rStrip_Escapes(text)
		}
