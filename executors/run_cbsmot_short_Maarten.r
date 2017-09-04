source('Scripts/crowdMovement/algorithms/cbsmot.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_GPS.r')

getValuesOfKnobs = function() {
	Eps = c(100)
	minTime = c(300)
	mergeTime = c(600)
	valuesOfKnobs = expand.grid(Eps = Eps, minTime = minTime, mergeTime = mergeTime)
	return(valuesOfKnobs)
}


#rezultsOurSolution = runSweepOnAlgorithm(GPSDetections2)
startTime = Sys.time()
a = wrapperAlgorithm(GPSDetections[GPSDetections$device==2,], getValuesOfKnobs())
print(Sys.time() - startTime)
rm(startTime)
#rez = runSweepOnAlgorithmWithAllDevices(GPSDetections)

rm(list = lsf.str())