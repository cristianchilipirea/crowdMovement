source('Scripts/crowdMovement/algorithms/createMovementVector.r')
source('Scripts/crowdMovement/runGeneric.r')
source('Scripts/crowdMovement/util/distance_GPS.r')

getValuesOfKnobs = function() {
	Eps = c(100)
	mergeTime = c(600)
	valuesOfKnobs = expand.grid(Eps = Eps, mergeTime = mergeTime)
	return(valuesOfKnobs)
}


#rezultsOurSolution = runSweepOnAlgorithm(GPSDetections2)

startTime = Sys.time()
ourMovementVector = wrapperAlgorithm(GPSDetections[GPSDetections$device==2,], getValuesOfKnobs())
print(Sys.time() - startTime)
rm(startTime)

#rez = runSweepOnAlgorithmWithAllDevices(GPSDetections)

rm(list = lsf.str())