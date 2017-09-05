source('Scripts/crowdMovement/algorithms/cdbscan.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_GPS.r')

getValuesOfKnobs = function() {
	Eps = c(100)
	minPts = c(5)
	mergeTime = c(600)
	valuesOfKnobs = expand.grid(Eps = Eps, minPts = minPts, mergeTime = mergeTime)
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