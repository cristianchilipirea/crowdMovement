source('Scripts/crowdMovement/algorithms/dbscan.r')
source('Scripts/crowdMovement/algorithms/dbscan_utils.r')
# TODO add wrapper algorithm

cdbscan = function(detections, Eps, minPts) {
	clusters = dbscan(detections, Eps, minPts)

	reference = clusters[1]
	count = 1
	for(i in 2:length(clusters)) {
		if(reference == clusters[i])
			count = count + 1
		else {
			if(count < minPts)
				clusters[(i-count):(i-1)] = 0
			count = 1
			reference = clusters[i]
		}
	}
	# It might be the case that a "fake" cluster is at the end
	if(count < minPts)
		clusters[(length(clusters)-count+1):length(clusters)] = 0
	return(clusters)
}

wrapperAlgorithm = function(detections, valueOfKnobs) {
	clusters = cdbscan(detections, valueOfKnobs$Eps, valueOfKnobs$minPts)
	movementVector = convertStaticClustersToMovementVector(clusters)
	return(movementVector)
}