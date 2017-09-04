
epsLinearNeighborhood = function(elementPosition, elements, Eps) {
	reference = elements[elementPosition,]

	isNeighbor = (getDistance(reference, elements) < Eps)

	return(isNeighbor)
}

isCore = function(neighbors, detections, minPts) {
	return(sum(neighbors) >= minPts)
}