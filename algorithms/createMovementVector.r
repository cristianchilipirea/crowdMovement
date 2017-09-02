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

wrapperOurSolution = function(detections, Eps) {
	movementVector = createMovementVector(detections, Eps)
	return(movementVector)
}