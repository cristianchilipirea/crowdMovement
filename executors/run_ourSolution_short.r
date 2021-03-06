source('Scripts/crowdMovement/algorithms/createMovementVector.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_GPS.r')

getValuesOfKnobs = function() {
	Eps = c(100, 120, 130)
	mergeTime = c(0, 300, 600)
	valuesOfKnobs = expand.grid(Eps = Eps, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

resultsOurSolution = runSweepOnAlgorithmWithAllDevices(GPSDetections)

rm(list = lsf.str())