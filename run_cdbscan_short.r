source('Scripts/crowdMovement/runHelpers/runCdbscan.r')

getValuesOfKnobs = function() {
	Eps = c(100,110,120)
	minPts = c(4,5,6)
	mergeTime = c(0, 300, 600)
	valuesOfKnobs = expand.grid(Eps = Eps, minPts = minPts, mergeTime = mergeTime,)
	return(valuesOfKnobs)
}

rezultsCdbscan = wrapperRunSweepOnAlgorithm(GPSDetections)

rm(list = lsf.str())