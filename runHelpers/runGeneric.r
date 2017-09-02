source('Scripts/crowdMovement/util/movements.r')
source('Scripts/crowdMovement/util/confusionMatrix.r')
source('Scripts/crowdMovement/util/detections.r')

compareMultipleMovements = function(movementsPredictedSet, movements) {
	rezults = sapply(movementsPredictedSet, FUN = function(movementsPredicted) {
		TP = compareMovements(movementsPredicted, movements)
		PredictedP = getTotalMovementDuration(movementsPredicted)
		return(c(TP, PredictedP))
	})

	rezults = t(rezults) #Here be dragons because of sapply
	return(data.frame(TP = rezults[,1], PredictedP = rezults[,2], valuesOfKnobs))
}

convertComparisonResultsToConfusionMatrix = function(comparisonResults, movements) {
	numSimulations = nrow(comparisonResults)
	TP = simRezults$TP
	RealP = rep(getTotalMovementDuration(movements), numSimulations)
	RealN = rep(getTotalDuration(detections), numSimulations) - RealP
	PredictedP = comparisonResults$PredictedP
	PredictedN = rep(getTotalDuration(detections), numSimulations) - PredictedP

	confusionMatrix = calculateConfusionMatrix(RealP, RealN, PredictedP, PredictedN, TP)
	columnFilter = !(colnames(comparisonResults) %in% c("TP","PredictedP"))
	return(cbind(comparisonResults[,columnFilter], confusionMatrix))
}

wrapperRunSweepOnAlgorithm = function(detections) {
	results = runSweepOnAlgorithm(detections)
	comparisonResults = compareMultipleMovements(results$allMovementsPredicted, movements)
	confusionMatrices = convertComparisonResultsToConfusionMatrix(comparisonResults, movements)
	return(confusionMatrices)
}