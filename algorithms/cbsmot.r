source('Scripts/crowdMovement/algorithms/dbscan.r')
source('Scripts/crowdMovement/algorithms/cbsmot_utils.r')

cbsmot = function(detections, Eps, minTime) {
	clusters = dbscan(detections, Eps, minTime)
	return(clusters)
}

wrapperAlgorithm = function(detections, valueOfKnobs) {
	clusters = cbsmot(detections, valueOfKnobs$Eps, valueOfKnobs$minTime)
	movementVector = convertStaticClustersToMovementVector(clusters)
	return(movementVector)
}