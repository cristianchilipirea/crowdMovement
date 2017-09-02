source('Scripts/crowdMovement/util/movements.r')
source('Scripts/crowdMovement/util/confusionMatrix.r')
source('Scripts/crowdMovement/util/detections.r')

compareMultipleMovements = function(movementsPredictedSet, movements) {
	results = sapply(movementsPredictedSet, FUN = function(movementsPredicted) {
		TP = compareMovements(movementsPredicted, movements)
		PredictedP = getTotalMovementDuration(movementsPredicted)
		return(c(TP, PredictedP))
	})

	return(data.frame(TP = results[1,], PredictedP = results[2,]))
}

convertComparisonResultsToConfusionMatrix = function(comparisonResults, movements, detections) {
	numSimulations = nrow(comparisonResults)
	TP = comparisonResults$TP
	RealP = rep(getTotalMovementDuration(movements), numSimulations)
	RealN = rep(getTotalDuration(detections), numSimulations) - RealP
	PredictedP = comparisonResults$PredictedP
	PredictedN = rep(getTotalDuration(detections), numSimulations) - PredictedP

	confusionMatrix = calculateConfusionMatrix(RealP, RealN, PredictedP, PredictedN, TP)
	return(confusionMatrix)
}

runSweepOnAlgorithm = function(detections) {
	valuesOfKnobs = getValuesOfKnobs()
	valuesOfKnobsAsList = split(valuesOfKnobs,1:nrow(valuesOfKnobs))

	allMovementsPredicted = lapply(valuesOfKnobsAsList, FUN = function(valueOfKnobs) {
		print(valueOfKnobs)
		movementVector = wrapperAlgorithm(detections, valueOfKnobs)
		movementsPredicted = extractMovements(movementVector, detections$time)
		movementsPredicted = mergeMovements(movementsPredicted, valueOfKnobs$mergeTime)
		return(movementsPredicted)
	})
	comparisonResults = compareMultipleMovements(allMovementsPredicted, movements)
	confusionMatrices = convertComparisonResultsToConfusionMatrix(comparisonResults, movements, detections)
	return(cbind(confusionMatrices, valuesOfKnobs))
}