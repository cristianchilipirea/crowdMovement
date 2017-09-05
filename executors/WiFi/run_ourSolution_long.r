source('Scripts/crowdMovement/algorithms/createMovementVector.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_scanners.r')

getValuesOfKnobs = function() {
	Eps = seq(50,500,10)
	mergeTime = c(seq(0, 280, 20), seq(300, 3600, 300))
	valuesOfKnobs = expand.grid(Eps = Eps, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

resultsOurSolution2 = runSweepOnAlgorithmWithAllDevices(ourDetections)

rm(list = lsf.str())