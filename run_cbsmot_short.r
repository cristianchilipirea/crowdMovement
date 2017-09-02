source('Scripts/crowdMovement/runHelpers/runCbsmot.r')

getValuesOfKnobs = function() {
	Eps = c(100,110,120)
	minTime = c(300)
	mergeTime = c(0, 300, 600)
	valuesOfKnobs = expand.grid(Eps = Eps, minTime = minTime, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

rezultsCbsmot = wrapperRunSweepOnAlgorithm(GPSDetections)

rm(list = lsf.str())