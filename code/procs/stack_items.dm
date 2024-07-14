proc
	stackItems(objects[], conditionalVars[])

		for(var/index = 1, index <= objects.len, index ++)
			var/datum/object = objects[index]

			loop:
				for(var/newIndex = (index + 1), newIndex <= objects.len, newIndex ++)
					var/datum/comparison = objects[newIndex]

					for(var/v in conditionalVars)
						if(object.vars[v] == comparison.vars[v] && comparison.vars["STACKABLE"] == TRUE)
							continue
						continue loop

					objects.Remove(comparison)
					objects[object] ++

					newIndex --

		// Gives each at least one stack.
		for(var/x in objects)
			objects[x] ++

		return objects