calculateTPR = function(TP, FN) {
	return(TP/(TP+FN))
}

calculateFPR = function(FP, TN) {
	return(FP/(FP+TN))
}

calculateConfusionMatrix = function(RealP, RealN, PredictedP, PredictedN, TP) {
  FP = PredictedP - TP
  FN = RealP - TP
  TN = RealN - FP
  return(data.frame(TP, FP, FN, TN))
}

calculateROCValues = function(confusionMatrix) {
  TPR = calculateTPR(confusionMatrix$TP, confusionMatrix$FN)
  FPR = calculateFPR(confusionMatrix$FP, confusionMatrix$TN)
  return(data.frame(TPR, FPR))
}