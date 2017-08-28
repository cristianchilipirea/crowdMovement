#install.packages('geosphere')
library('geosphere')

createMovementVector = function(detections) {
	reference = detections[1,]

	movementVector = rep(F, nrow(detections))
	if(nrow(detections)<2)
		return(movementVector)

	for(i in 2:nrow(detections)) {
	  print(i)
		if(isDistanceLargeEnough(reference, detections[i,])) {
			movementVector[i] = T
			reference = detections[i,]
		}
	}
	return(movementVector)
}

isDistanceLargeEnough = function(detectionA, detectionB) {
	# TODO generalize this and add scanner/distance support, remove 100
	return(getDistance(detectionA, detectionB) > 100)
}

getDistance = function(detectionA, detectionB) {
  #print(detectionA)
	geoPositionDetectionA = detectionA[,c("latitude", "longitude")]
	geoPositionDetectionB = detectionB[,c("latitude", "longitude")]
	distance = distGeo(geoPositionDetectionA, geoPositionDetectionB)
	return(distance)
}

# start = Sys.time()
# movementVector = createMovementVector(GPSDetections)
# print(Sys.time() - start)
# rm(list = lsf.str())