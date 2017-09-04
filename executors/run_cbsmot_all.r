source('Scripts/crowdMovement/algorithms/cbsmot.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/utils/distance_GPS.r')

getValuesOfKnobs = function() {
	Eps = c(seq(0, 290, 10), c(seq(300, 800, 50)))
	minTime = c(seq(60, 900, 60))
	mergeTime = c(0, 300, 600, 900,1800)
	valuesOfKnobs = expand.grid(Eps = Eps, minTime = minTime, mergeTime = mergeTime)
	return(valuesOfKnobs)
}

rezultsCbsmot = runSweepOnAlgorithm(GPSDetections)

rm(list = lsf.str())