source('Scripts/crowdMovement/algorithms/dbscan.r')
source('Scripts/crowdMovement/algorithms/cbsmot_utils2.r')

cbsmot = function(detections, Eps, minTime) {
	withoutLast = -nrow(detections)
	withoutFirst = -1
	prevDetections = detections[withoutLast,]
	nextDetections = detections[withoutFirst,]
	consecDistances <<- getDistance(prevDetections, nextDetections)
	clusters = dbscan(detections, Eps, minTime)
	rm(consecDistances)
	return(clusters)
}

wrapperAlgorithm = function(detections, valueOfKnobs) {
	clusters = cbsmot(detections, valueOfKnobs$Eps, valueOfKnobs$minTime)
	movementVector = convertStaticClustersToMovementVector(clusters)
	return(movementVector)
}