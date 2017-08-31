source('Scripts/crowdMovement/createMovementVector.r')
source('Scripts/crowdMovement/movements.r')
source('Scripts/crowdMovement/confusionMatrix.r')
source('Scripts/crowdMovement/detections.r')

run = function(detections, mergeTime) {
  Epses = c(seq(0,300,10), 10000000)
  numSimulations = length(Epses)
  simRezults = sapply(Epses, FUN = function(Eps){
    print(Eps)
	  movementVector = createMovementVector(detections, Eps)
	  predictedMovements = extractMovements(movementVector, detections$time)
	  predictedMovements = mergeMovements(predictedMovements, mergeTime)
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

a = sapply(c(seq(0, 900, 60),1800, 3600, 7200, 10800), FUN = function(x) {
    print(paste(">>>>",x))
    return(run(GPSDetections, x))
  })

rm(list = lsf.str())