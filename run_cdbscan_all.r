source('Scripts/crowdMovement/algorithms/cdbscan.r')
source('Scripts/crowdMovement/runGeneric.r')

getValuesOfKnobs = function() {
	Eps = c(seq(0, 290, 10), seq(300, 800, 50))
	minPts = 3:10
	mergeTime = c(0, 300, 600, 900,1800)
	valuesOfKnobs = expand.grid(Eps = Eps, minPts = minPts, mergeTime = mergeTime,)
	return(valuesOfKnobs)
}

rezultsCdbscan = runSweepOnAlgorithm(GPSDetections)

rm(list = lsf.str())