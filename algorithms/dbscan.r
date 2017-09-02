source('Scripts/crowdMovement/util/misc.r')
source('Scripts/crowdMovement/util/distances.r')

epsLinearNeighborhood = function(elementPosition, elements, Eps) {
	reference = elements[elementPosition,]

	isNeighbor = (getDistance(reference, elements) < Eps)

	return(isNeighbor)
}

isCore = function(neighbors, detections, minPts) {
	return(sum(neighbors) >= minPts)
}

dbscan = function(elements, Eps, minValue) {
	elements = fixRowNames(elements)
	clusters = rep(0, nrow(elements))
	for(i in 1:nrow(elements)) {
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