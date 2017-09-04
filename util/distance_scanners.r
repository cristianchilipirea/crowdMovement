getDistance = function(detectionA, detectionB) {
	scannerA = min(detectionA[,"scanner"], detectionB[,"scanner"])
	scannerB = max(detectionA[,"scanner"], detectionB[,"scanner"])
	selector = distanceScanners$scannerA == scannerA & distanceScanners$scannerB == scannerB
	distance = distanceScanners$distance[selector]
	return(distance)
}