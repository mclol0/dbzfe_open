proc
	Wrap(currentx, x1, x2, hideEdges=FALSE)
	{
		var/relativeLocation = currentx


		if(relativeLocation < x1)
			if(hideEdges) return 1;
			return relativeLocation + (x2-x1)+1
		else if(relativeLocation > x2)
			if(hideEdges) return 1;
			return (relativeLocation % (x2))+x1-1
		else
			//if(hideEdges) return 1;
			return relativeLocation
	}