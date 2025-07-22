proc
	send(text, target, canAllHear = FALSE)
	{
		if (!target || isnpc(target))
			return

		var/list/targets = islist(target) ? target : list(target)

		for (var/a in targets)
		{
			if (!a)
				continue

			var/mob/player = isplayer(a) ? a : null
			var/client/C = isclient(a) ? a : (player ? player.client : null)

			if (!C)
				continue

			if (!canAllHear && player && (player:getStatus() in list("unconscious", "sleeping")))
				continue

			if (a:output)
				a:output:add("[text]{x\n")

			C.bust_prompt = TRUE
		}
	}
