epsLinearNeighborhood = function(p, elements, Eps) {
	neighbors = rep(F, nrow(elements))
	neighbors[p] = T
	if(p>1) {
		aux = p
		sum = 0
		for(i in (p-1):1) {
			sum = sum + getDistance(elements[aux,], elements[i,])
			if(sum < Eps)
				neighbors[i] = T
			else
				break
			aux = i
		}
	}
	if(p<nrow(elements)) {
		aux = p
		sum = 0
		for(i in (p+1):nrow(elements)) {
			sum = sum + getDistance(elements[aux,], elements[i,])
			if(sum < Eps)
			  neighbors[i] = T
			else
				break
			aux = i
		}
	}

	return(neighbors)
}

isCore = function(neighbors, t, minTime) {
	neighbors = which(neighbors)
	duration = t$time[max(neighbors)] - t$time[min(neighbors)]
	return(duration >= minTime)
}