source('Scripts/crowdMovement/algorithms/createMovementVector.r')
source('Scripts/crowdMovement/runGeneric.r')

getValuesOfKnobs = function() {
	Eps = c(100, 120)
	mergeTime = c(0, 600)
	valuesOfKnobs = expand.grid(Eps = Eps, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

rezultsOurSolution = runSweepOnAlgorithm(GPSDetections)

rm(list = lsf.str())