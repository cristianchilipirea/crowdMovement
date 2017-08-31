source('Scripts/crowdMovement/cdbscan.r')
source('Scripts/crowdMovement/movements.r')
source('Scripts/crowdMovement/confusionMatrix.r')
source('Scripts/crowdMovement/detections.r')

run = function(detections) {
  Epses = c(seq(0,300,10), 10000000)
  minPts = 4
  numSimulations = length(Epses)
  simRezults = sapply(Epses, FUN = function(Eps){
    print(Eps)
	  clusters = cdbscan(detections, Eps, minPts)
	  movementVector = convertStaticClustersToMovementVector(clusters)
	  predictedMovements = extractMovements(movementVector, detections$time)
	  predictedMovements = mergeMovements(predictedMovements, 0)
	  TP = compareMovements(predictedMovements, movements)
	  PredictedP = getTotalMovementDuration(predictedMovements)
	  return(c(TP, PredictedP))
	})
  print(simRezults)
  TP = simRezults[1,]
  RealP = rep(getTotalMovementDuration(movements), numSimulations)
  RealN = rep(getTotalDuration(detections), numSimulations) - RealP
  PredictedP = simRezults[2,]
  PredictedN = rep(getTotalDuration(detections), numSimulations) - PredictedP
  
  confusionMatrix = calculateConfusionMatrix(RealP, RealN, PredictedP, PredictedN, TP)
  return(calculateROCValues(confusionMatrix))
}

a = run(GPSDetections)

rm(list = lsf.str())