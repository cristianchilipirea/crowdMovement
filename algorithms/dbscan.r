source('Scripts/crowdMovement/util/misc.r')

dbscan = function(elements, Eps, minValue) {
	elements = fixRowNames(elements)
	clusters = rep(0, nrow(elements))
	for(i in 1:nrow(elements)) {
		print(i)
		neighbors = epsLinearNeighborhood(i, elements, Eps)
		if(isCore(neighbors, elements, minValue)) {
			cluster = i
			if(clusters[i] != 0)
				cluster = clusters[i]
			selector = neighbors & clusters == 0
			clusters[selector] = cluster
		}
	}
	return(clusters)
}