proc
	/*
	This procedure returns a list of atoms re-ordered by distance.
	*/

	distance_order(source, objects[])
		var/distances[objects.len]

		for(var/x = 1 to objects.len)
			distances[x] = a_get_dist(source, objects[x])

		for(var/index = distances.len, index > 0, index --)
			var
				max = max(distances)
				pos = distances.Find(max)

			objects.Swap(index, pos)
			distances.Swap(index, pos)
			distances[index] = -1

		return objects
