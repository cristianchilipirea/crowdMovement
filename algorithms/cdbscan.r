source('Scripts/crowdMovement/algorithms/dbscan.r')

cdbscan = function(detections, Eps, minPts) {
	clusters = dbscan(detections, Eps, minPts)
	print(table(clusters))
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
	return(clusters)
}

wrapperAlgorithm = function(detections, valueOfKnobs) {
	clusters = cdbscan(detections, valueOfKnobs$Eps, valueOfKnobs$minPts)
	movementVector = convertStaticClustersToMovementVector(clusters)
	return(movementVector)
}