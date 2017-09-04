source('Scripts/crowdMovement/algorithms/cdbscan.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_GPS.r')

getValuesOfKnobs = function() {
	Eps = c(100,110,120)
	minPts = c(4)
	mergeTime = c(0, 300, 600)
	valuesOfKnobs = expand.grid(Eps = Eps, minPts = minPts, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

rezultsCdbscan = runSweepOnAlgorithm(GPSDetections)

rm(list = lsf.str())