source('Scripts/crowdMovement/algorithms/cbsmot.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_scanners.r')

getValuesOfKnobs = function() {
	Eps = c(100,110,120)
	minTime = c(80)
	mergeTime = c(0, 300, 600)
	valuesOfKnobs = expand.grid(Eps = Eps, minTime = minTime, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

resultsCbsmot2 = runSweepOnAlgorithmWithAllDevices(ourDetections)

rm(list = lsf.str())