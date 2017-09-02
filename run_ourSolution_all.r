source('Scripts/crowdMovement/runHelpers/runOurSolution.r')

getValuesOfKnobs = function() {
	Eps = c(seq(0,290,10), seq(300, 800, 50))
	mergeTime = c(seq(0, 900, 60),1800, 3600, 7200, 10800)
	valuesOfKnobs = expand.grid(Eps = Eps, mergeTime = mergeTime)
	return(valuesOfKnobs)
}


rezultsOurSolution = wrapperRunSweepOnAlgorithm(GPSDetections)

rm(list = lsf.str())