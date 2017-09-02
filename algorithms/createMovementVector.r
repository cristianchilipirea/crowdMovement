source('Scripts/crowdMovement/util/distances.r')

createMovementVector = function(detections, Eps) {
	reference = detections[1,]

	movementVector = rep(F, nrow(detections))
	if(nrow(detections)<2)
		return(movementVector)

	for(i in 2:nrow(detections)) {
		if(getDistance(reference, detections[i,]) >= Eps) {
			movementVector[i] = T
			reference = detections[i,]
		}
	}
	return(movementVector)
}

wrapperAlgorithm = function(detections, valueOfKnobs) {
	movementVector = createMovementVector(detections, valueOfKnobs$Eps)
	return(movementVector)
}