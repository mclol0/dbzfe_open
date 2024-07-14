proc
	/*
	One of our most efficient wrapping procedures to get the distance between two atoms.
	*/
	a_get_dist(atom/A=src, atom/B){
		if(!A || !B){
			return 0;
		}else{
			return max(min( abs(A.getX() - B.getX()), abs(A.getX() - B.getX() - A.loc.loc:dx), abs(A.getX() - B.getX() + A.loc.loc:dx) ),min( abs(A.getY() - B.getY()), abs(A.getY() - B.getY() - A.loc.loc:dy), abs(A.getY() - B.getY() + A.loc.loc:dy) ));
		}
	}