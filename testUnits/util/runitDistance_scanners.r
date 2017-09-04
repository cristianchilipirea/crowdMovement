source("Scripts/crowdMovement/util/distance_scanners.r")

.setUp = function() {
	distanceScanners <<- data.frame(scannerA = c(2353, 2350), scannerB=c(2379, 2374), distance=c(3,5))
}

test.getDistance = function() {
	detectionA = data.frame(scanner = c(2353))
	detectionB = data.frame(scanner = c(2379))
	checkEquals(getDistance(detectionA, detectionB), c(3))
}

.tearDown = function() {
	rm(list = c("distanceScanners"), envir = globalenv())
}