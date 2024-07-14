proc
    checkPlane(mob/m, target) {
        if (istype(target, /mob) || istype(target, /obj))
        {
            return target:insideBuilding == m:insideBuilding
        }

        return TRUE
    }