source('Scripts/crowdMovement/algorithms/cdbscan.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_scanners.r')

getValuesOfKnobs = function() {
	Eps = c(150)
	minPts = c(5)
	mergeTime = c(600)
	valuesOfKnobs = expand.grid(Eps = Eps, minPts = minPts, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

stuff = function() {
	for(device in unique(ourDetections$device)) {
		movementPredicted = runSweepOnAlgorithmPartitionedTimes(ourDetections[ourDetections$device==device,])
		plotMovementSets(movements, movementPredicted)
		dev.copy(png,paste(device, ".png"))
		dev.off()
	}
}

stuff()
rm(list = lsf.str())