source('Scripts/crowdMovement/algorithms/cdbscan.r')
source('Scripts/crowdMovement/runHelpers/runGeneric.r')

runSweepOnAlgorithm = function(detections) {
	valuesOfKnobs = getValuesOfKnobs()
	valuesOfKnobsAsList = split(valuesOfKnobs,1:nrow(valuesOfKnobs))

	allMovementsPredicted = lapply(valuesOfKnobsAsList, FUN = function(valueOfKnobs) {
		print(valueOfKnobs)
		movementVector = wrapperCdbscan(detections, valueOfKnobs$Eps, valueOfKnobs$minPts)
		movementsPredicted = extractMovements(movementVector, detections$time)
		movementsPredicted = mergeMovements(movementsPredicted, valueOfKnobs$mergeTime)
		return(movementsPredicted)
	})

	return(list(valuesOfKnobs = valuesOfKnobs, allMovementsPredicted = allMovementsPredicted))
}