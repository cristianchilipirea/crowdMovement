getDistance = function(detectionA, detectionB) {
	scannerA = pmin(detectionA[,"scanner"], detectionB[,"scanner"])
	scannerB = pmax(detectionA[,"scanner"], detectionB[,"scanner"])
	distance = rep(0, length(scannerA))
	for(i in 1:length(scannerA)) {
		if(scannerA[i] != scannerB[i]) {
			selector = distanceScanners$scannerA == scannerA[i] & distanceScanners$scannerB == scannerB[i]
			distance[i] = distanceScanners$distance[selector]
		}
	}
	return(distance)
}