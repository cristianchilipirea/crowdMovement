source('Scripts/crowdMovement/dbscan.r')
epsLinearNeighborhoodCDbscan = function(p, t, Eps) {
	neighbors = c(p)
	if(p>1) {
		for(i in (p-1):1) {
			if(getDistance(t[p,], t[i,]) <= Eps)
				neighbors = c(neighbors, i)
			else
				break
		}
	}
	if(p<nrow(t)) {
		for(i in (p+1):nrow(t)) {
			if(getDistance(t[p,], t[i,]) <= Eps)
				neighbors = c(neighbors, i)
			else
				break
		}
	}

	return(neighbors)
}

cdbscan = function(minPts, Eps, detections) {
	aux = epsLinearNeighborhood
	epsLinearNeighborhood <<- epsLinearNeighborhoodCDbscan

	rezult = dbscan(minPts, Eps, detections)

	epsLinearNeighborhood <<- aux
	return(rezult)
}

#cluster = cdbscan(5, 100, GPSDetections)
#rm(list = lsf.str())