source('Rscripts/myGPS/createMovementVector.r')
source('Rscripts/core/utils.r')

eps_linear_neighborhood = function(p, t, Eps) {
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

isCore = function(neighbors, t, minPts) {
	return(length(neighbors) >= minPts)
}

cdbscan = function(minPts, Eps, t) {
	t = fixRowNames(t)
	t$cluster = 0
	for(p in 1:nrow(t)) {
		print(p)
		neighbors = eps_linear_neighborhood(p, t, Eps)
		if(isCore(neighbors, t, minPts)) {
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

start = Sys.time()
clusters = cdbscan(5, 100, GPSDetections)
print(Sys.time()-start)
rm(list = lsf.str())