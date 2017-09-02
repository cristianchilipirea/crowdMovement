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

calculateAccuracy = function(confusionMatrix) {
  TP = confusionMatrix$TP
  TN = confusionMatrix$TN
  FP = confusionMatrix$FP
  FN = confusionMatrix$FN
  return((TP+TN) / (TP+TN+FP+FN))
}

calculateMatthewsCorrelationCoefficient = function(confusionMatrix) {
  TP = confusionMatrix$TP
  TN = confusionMatrix$TN
  FP = confusionMatrix$FP
  FN = confusionMatrix$FN
  
  numerator = TP*TN - FP*FN
  denominator = sqrt((TP+FP) * (TP+FN) * (TN+FP) * (TN+FN))
  return(numerator/denominator)
}

calculateF1 = function(confusionMatrix) {
  TP = confusionMatrix$TP
  TN = confusionMatrix$TN
  FP = confusionMatrix$FP
  FN = confusionMatrix$FN
  
  numerator = 2*TP
  denominator = (2*TP + FP + FN)
  return(numerator/denominator)
}

calculateROCValues = function(confusionMatrix) {
  TPR = calculateTPR(confusionMatrix$TP, confusionMatrix$FN)
  FPR = calculateFPR(confusionMatrix$FP, confusionMatrix$TN)
  return(data.frame(TPR, FPR))
}