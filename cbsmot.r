source('Rscripts/myGPS/createMovementVector.r')
source('Rscripts/core/utils.r')

eps_linear_neighborhood = function(p, t, Eps) {
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

isCore = function(neighbors, t, minTime) {
	duration = t$time[max(neighbors)] - t$time[min(neighbors)]
	return(duration >= minTime)
}

cbsmot = function(minTime, Eps, t) {
	t = fixRowNames(t)
	t$cluster = 0
	for(p in 1:nrow(t)) {
	  print(p)
		neighbors = eps_linear_neighborhood(p, t, Eps)
		if(isCore(neighbors, t, minTime)) {
			cluster = p
			if(t$cluster[p] != 0)
				cluster = t$cluster[p]
			t$cluster[neighbors] = cluster
		}
	}
	return(t)
}

staticClustersToMovementVector = function(t) {
	withoutFirst = -1
	withoutLast = -nrow(t)
	movementVector = (t$cluster == 0) | c(F, t$cluster[withoutFirst] != t$cluster[withoutFirst])
	movementVector[1] = F
	return(movementVector)
}

clusters2 = cbsmot(300, 200, GPSDetections)

rm(list = lsf.str())