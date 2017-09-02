source('Scripts/crowdMovement/algorithms/createMovementVector.r')
source('Scripts/crowdMovement/runHelpers/runGeneric.r')

runSweepOnAlgorithm = function(detections) {
	valuesOfKnobs = getValuesOfKnobs()
	valuesOfKnobsAsList = split(valuesOfKnobs,1:nrow(valuesOfKnobs))

	allMovementsPredicted = lapply(valuesOfKnobsAsList, FUN = function(valueOfKnobs) {
		print(valueOfKnobs)
		movementVector = wrapperOurSolution(detections, valueOfKnobs$Eps)
		movementsPredicted = extractMovements(movementVector, detections$time)
		movementsPredicted = mergeMovements(movementsPredicted, valueOfKnobs$mergeTime)
		return(movementsPredicted)
	})

	return(list(valuesOfKnobs = valuesOfKnobs, allMovementsPredicted = allMovementsPredicted))
}