proc/coord(min,max){ return min > (max / 2) ? (min - max - 1) : min } // converts coordinates into more FE like coordinates lol.

proc/byondcoord(min,max) { return min < (0) ? (max + min + 1) : (min) }