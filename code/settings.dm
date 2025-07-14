Settings
	var
		lcBaseValue = 1
		lcVeryWeakMinGain = 10
		lcVeryWeakMaxGain = 30
		lcWeakMinGain = 20
		lcWeakMaxGain = 50
		lcEqualMinGain = 40
		lcEqualMaxGain = 100
		lcStrongMinGain = 80
		lcStrongMaxGain = 140
		lcGodlikeMinGain = 130
		lcGodlikeMaxGain = 200

		_divider = 100

	proc
		veryWeakMinGain()
			return lcVeryWeakMinGain / _divider
		
		veryWeakMaxGain()
			return lcVeryWeakMaxGain / _divider

		weakMinGain()
			return lcWeakMinGain / _divider

		weakMaxGain()
			return lcWeakMaxGain / _divider

		equalMinGain()
			return lcEqualMinGain / _divider

		equalMaxGain()
			return lcEqualMaxGain / _divider

		strongMinGain()
			return lcStrongMinGain / _divider

		strongMaxGain()
			return lcStrongMaxGain / _divider

		godlikeMinGain()
			return lcGodlikeMinGain / _divider

		godlikeMaxGain()
			return lcGodlikeMaxGain / _divider

		veryWeakRandGain()
			return rand(lcVeryWeakMinGain, lcVeryWeakMaxGain) / _divider
			
		weakRandGain()
			return rand(lcWeakMinGain, lcWeakMaxGain) / _divider

		equalRandGain()
			return rand(lcEqualMinGain, lcEqualMaxGain) / _divider

		strongRandGain()
			return rand(lcStrongMinGain, lcStrongMaxGain) / _divider	

		godlikeRandGain()
			return rand(lcGodlikeMinGain, lcGodlikeMaxGain) / _divider