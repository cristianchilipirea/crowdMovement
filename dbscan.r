source('Rscripts/core/utils.r')
epsLinearNeighborhood = function(elementPosition, elements, Eps) {
	neighbors = c()
	reference = elements[elementPosition,]
	for(i in 1:nrow(elements)) {
		if(getDistance(reference, elements[i,]) <= Eps)
			neighbors = c(neighbors, i)
	}
	return(neighbors)
}

isCore = function(neighbors, detections, minPts) {
	return(length(neighbors) >= minPts)
}

dbscan = function(minValue, Eps, elements) {
	elements = fixRowNames(elements)
	clusters = rep(0, nrow(elements))
	for(i in 1:nrow(elements)) {
	  print(i)
		neighbors = epsLinearNeighborhood(i, elements, Eps)
		if(isCore(neighbors, elements, minValue)) {
		  cluster = i
			if(clusters[i] != 0)
			  cluster = clusters[i]
			clusters[neighbors] = cluster
		}
	}
	return(clusters)
}