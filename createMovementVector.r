#install.packages('geosphere')
source('Scripts/crowdMovement/distances.r')
library('geosphere')

createMovementVector = function(detections, Eps) {
	reference = detections[1,]

	movementVector = rep(F, nrow(detections))
	if(nrow(detections)<2)
		return(movementVector)

	for(i in 2:nrow(detections)) {
	  #print(i)
		if(getDistance(reference, detections[i,]) >= Eps) {
			movementVector[i] = T
			reference = detections[i,]
		}
	}
	return(movementVector)
}



# start = Sys.time()
# movementVector = createMovementVector(GPSDetections)
# print(Sys.time() - start)
# rm(list = lsf.str())