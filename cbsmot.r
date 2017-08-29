source('Scripts/crowdMovement/dbscan.r')

epsLinearNeighborhoodCBsmot = function(p, t, Eps) {
	neighbors = c(p)
	if(p>1) {
		aux = p
		sum = 0
		for(i in (p-1):1) {
			sum = sum + getDistance(t[aux,], t[i,])
			if(sum <= Eps)
				neighbors = c(neighbors, i)
			else
				break
			aux = i
		}
	}
	if(p<nrow(t)) {
		aux = p
		sum = 0
		for(i in (p+1):nrow(t)) {
			sum = sum + getDistance(t[aux,], t[i,])
			if(sum <= Eps)
				neighbors = c(neighbors, i)
			else
				break
			aux = i
		}
	}

	return(neighbors)
}

isCoreCBsmot = function(neighbors, t, minTime) {
	duration = t$time[max(neighbors)] - t$time[min(neighbors)]
	return(duration >= minTime)
}

cbsmot = function(minTime, Eps, detections) {
  aux = epsLinearNeighborhood
  aux1 = isCore
	epsLinearNeighborhood <<- epsLinearNeighborhoodCBsmot
	isCore <<- isCoreCBsmot
	rezult = dbscan(minTime, Eps, detections)
	
	epsLinearNeighborhood <<- aux
	isCore <<- aux1
	return(rezult)
}



clusters2 = cbsmot(300, 200, GPSDetections)

rm(list = lsf.str())