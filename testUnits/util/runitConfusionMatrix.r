source("Scripts/crowdMovement/util/confusionMatrix.r")

test.calculateTPR = function() {
	confusionMatrix = data.frame(TP = c(5, 3), FP = c(0, 1), FN = c(0, 3), TN = c(5, 3))
	checkEquals(calculateTPR(confusionMatrix), c(1, 0.5))
	confusionMatrix = data.frame(TP = c(5, 0), FP = c(0, 0), FN = c(0, 0), TN = c(5, 0))
	checkEquals(calculateTPR(confusionMatrix), c(1, NA))
}

test.calculateFPR = function() {
	confusionMatrix = data.frame(TP = c(5, 3), FP = c(0, 1), FN = c(0, 3), TN = c(5, 3))
	checkEquals(calculateFPR(confusionMatrix), c(0, 0.25))
	confusionMatrix = data.frame(TP = c(5, 0), FP = c(0, 0), FN = c(0, 0), TN = c(5, 0))
	checkEquals(calculateFPR(confusionMatrix), c(0, NA))
}

test.calculateROCValues = function() {
	confusionMatrix = data.frame(TP = c(5, 3), FP = c(0, 1), FN = c(0, 3), TN = c(5, 3))
	checkEquals(calculateROCValues(confusionMatrix), data.frame(TPR = c(1, 0.5), FPR = c(0, 0.25)))
}

test.calculateConfusionMatrix = function() {
	RealP = c(5, 6)
	RealN = c(5, 4)
	PredictedP = c(5, 4)
	PredictedN = c(5, 6)
	TP = c(5, 3)
	checkEquals(calculateConfusionMatrix(RealP, RealN, PredictedP, PredictedN, TP), data.frame(TP = c(5, 3), FP = c(0, 1), FN = c(0, 3), TN = c(5, 3)))
}

test.calculateAccuracy = function() {
	confusionMatrix = data.frame(TP = c(5, 3), FP = c(0, 1), FN = c(0, 3), TN = c(5, 3))
	checkEquals(calculateAccuracy(confusionMatrix), c(1,0.6))
}

test.calculateMatthewsCorrelationCoefficient = function() {
	confusionMatrix = data.frame(TP = c(5, 3), FP = c(0, 1), FN = c(0, 3), TN = c(5, 3))
	checkEquals(calculateMatthewsCorrelationCoefficient(confusionMatrix), c(1,0.25))
}

test.calculateF1 = function() {
	confusionMatrix = data.frame(TP = c(5, 3), FP = c(0, 1), FN = c(0, 3), TN = c(5, 3))
	checkEquals(calculateF1(confusionMatrix), c(1, 0.6))
}