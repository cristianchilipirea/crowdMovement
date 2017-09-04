calculateTPR = function(confusionMatrix) {
	TP = confusionMatrix$TP
	FN = confusionMatrix$FN

	if(any(TP+FN == 0))
		warning("TP+FN == 0")

	return(TP/(TP+FN))
}

calculateFPR = function(confusionMatrix) {
	FP = confusionMatrix$FP
	TN = confusionMatrix$TN

	if(any(FP+TN == 0))
		warning("FP+TN == 0")

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
	if(any(TP+TN+FP+FN == 0))
		warning("TP+TN+FP+FN == 0")
	return((TP+TN) / (TP+TN+FP+FN))
}

calculateMatthewsCorrelationCoefficient = function(confusionMatrix) {
	TP = confusionMatrix$TP
	TN = confusionMatrix$TN
	FP = confusionMatrix$FP
	FN = confusionMatrix$FN

	numerator = TP*TN - FP*FN
	denominator = sqrt((TP+FP) * (TP+FN) * (TN+FP) * (TN+FN))
	if(any(denominator == 0))
		warning("denominator == 0")
	return(numerator/denominator)
}

calculateF1 = function(confusionMatrix) {
	TP = confusionMatrix$TP
	TN = confusionMatrix$TN
	FP = confusionMatrix$FP
	FN = confusionMatrix$FN

	numerator = 2*TP
	denominator = (2*TP + FP + FN)
	if(any(denominator == 0))
		warning("denominator == 0")
	return(numerator/denominator)
}

calculateROCValues = function(confusionMatrix) {
	TPR = calculateTPR(confusionMatrix)
	FPR = calculateFPR(confusionMatrix)
	return(data.frame(TPR, FPR))
}