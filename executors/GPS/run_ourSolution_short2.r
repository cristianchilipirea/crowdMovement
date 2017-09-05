source('Scripts/crowdMovement/algorithms/createMovementVector.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_GPS.r')

getValuesOfKnobs = function() {
	Eps = c(100)
	mergeTime = c(600)
	valuesOfKnobs = expand.grid(Eps = Eps, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

stuff = function() {
	for(device in unique(GPSDetections$device)) {
		movementPredicted = runSweepOnAlgorithmPartitionedTimes(GPSDetections[GPSDetections$device==device,])
		plotMovementSets(movements[movements$device==device,], movementPredicted)
		dev.copy(png,paste(device, ".png"))
		dev.off()
	}
}

stuff()
rm(list = lsf.str())