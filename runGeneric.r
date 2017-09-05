source('Scripts/crowdMovement/util/movements.r')
source('Scripts/crowdMovement/util/confusionMatrix.r')
source('Scripts/crowdMovement/util/detections.r')

compareMultipleMovements = function(movementsPredictedSet, movements) {
	results = sapply(movementsPredictedSet, FUN = function(movementsPredicted) {
		TP = getTimeInCommonMovementSets(movementsPredicted, movements)
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

runSweepOnAlgorithm = function(detections, movements) {
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

runSweepOnAlgorithmPartitionedTimes = function(detections) {
	valueOfKnobs = getValuesOfKnobs()
	partitions = getPartitions(detections)
	splitDetections = split(detections, partitions)
	splitDetections = splitDetections[lapply(splitDetections, nrow) > 1]
	movementsPredicted = lapply(splitDetections, FUN=function(partialDetections){
		minTime = min(partialDetections$time)
		maxTime = max(partialDetections$time)
		print(minTime)
		print(maxTime)
		movementVector = wrapperAlgorithm(partialDetections, valueOfKnobs)
		movementsPredicted = extractMovements(movementVector, partialDetections$time)
		movementsPredicted = mergeMovements(movementsPredicted, valueOfKnobs$mergeTime)
		return(movementsPredicted)
	})
	movementsPredicted = do.call("rbind", movementsPredicted)
	return(movementsPredicted)
}

getPartitions = function(detections) {
	maximalTimeBetweenDetections = 1200
	timeBetweenDetections = detections$time[-1] - detections$time[-nrow(detections)]
	splitPoints = timeBetweenDetections > maximalTimeBetweenDetections
	partitions = cumsum(c(T,splitPoints))
	return(partitions)
}

runSweepOnAlgorithmWithAllDevices = function(detections) {
	devices = unique(detections$device)
	results = sapply(devices, FUN = function(device) {
		print(device)
		filteredDetections = detections[detections$device == device,]
		filteredMovements = movements[movements$device == device,]
		partitions = getPartitions(filteredDetections)
		print(max(partitions))
		splitDetections = split(filteredDetections, partitions)
		
		splitDetections = splitDetections[lapply(splitDetections, nrow) > 1]
		print(lapply(splitDetections,nrow))
		
		partialConfusionMatrices = lapply(splitDetections, FUN=function(partialDetections){
			minTime = min(partialDetections$time)
			maxTime = max(partialDetections$time)
			print(minTime)
			print(maxTime)
			partialMovements = limitMovementsToTimeInterval(filteredMovements, minTime, maxTime)
			partialConfusionMatrices = runSweepOnAlgorithm(partialDetections, partialMovements)
			return(partialConfusionMatrices)
		})
		confusionMatrices = partialConfusionMatrices[[1]]
		if(length(partialConfusionMatrices)>=2)
			for(i in 2:length(partialConfusionMatrices))
				confusionMatrices[1:4] = confusionMatrices[1:4] + partialConfusionMatrices[[i]][1:4]
		return(list(list(device = device, confusionMatrices = confusionMatrices)))
	})
	return(results)
}