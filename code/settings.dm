Settings
	var
		list/map = list()
		_divider = 100

	New() {
		// Android LC values
		map["lcBaseValue"] = 1
		map["lcVeryWeakMinGain"] = 10
		map["lcVeryWeakMaxGain"] = 30
		map["lcWeakMinGain"] = 20
		map["lcWeakMaxGain"] = 50
		map["lcEqualMinGain"] = 40
		map["lcEqualMaxGain"] = 100
		map["lcStrongMinGain"] = 80
		map["lcStrongMaxGain"] = 140
		map["lcGodlikeMinGain"] = 130
		map["lcGodlikeMaxGain"] = 200
		map["lcExchangeReward"] = 0.75

		// NPC liveliness
		map["npcIdleActionprobability"] = 23

		// Combat
		map["fightStunChance"] = 22.00
		map["mobFightStunChance"] = 10.00
	}

	proc
		veryWeakMinGain()
			return map["lcVeryWeakMinGain"] / _divider

		veryWeakMaxGain()
			return map["lcVeryWeakMaxGain"] / _divider

		weakMinGain()
			return map["lcWeakMinGain"] / _divider

		weakMaxGain()
			return map["lcWeakMaxGain"] / _divider

		equalMinGain()
			return map["lcEqualMinGain"] / _divider

		equalMaxGain()
			return map["lcEqualMaxGain"] / _divider

		strongMinGain()
			return map["lcStrongMinGain"] / _divider

		strongMaxGain()
			return map["lcStrongMaxGain"] / _divider

		godlikeMinGain()
			return map["lcGodlikeMinGain"] / _divider

		godlikeMaxGain()
			return map["lcGodlikeMaxGain"] / _divider

		veryWeakRandGain()
			return rand(map["lcVeryWeakMinGain"], map["lcVeryWeakMaxGain"]) / _divider

		weakRandGain()
			return rand(map["lcWeakMinGain"], map["lcWeakMaxGain"]) / _divider

		equalRandGain()
			return rand(map["lcEqualMinGain"], map["lcEqualMaxGain"]) / _divider

		strongRandGain()
			return rand(map["lcStrongMinGain"], map["lcStrongMaxGain"]) / _divider

		godlikeRandGain()
			return rand(map["lcGodlikeMinGain"], map["lcGodlikeMaxGain"]) / _divider

		setValue(var/key, var/value) {
			map[key] = value
		}

		get(var/key) {
			return map[key]
		}