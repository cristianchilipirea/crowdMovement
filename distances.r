library('geosphere')

getDistance = function(detectionA, detectionB) {
	return(getGeoDistance(detectionA, detectionB))
}

getGeoDistance = function(detectionA, detectionB) {
	geoPositionDetectionA = detectionA[,c("latitude", "longitude")]
	geoPositionDetectionB = detectionB[,c("latitude", "longitude")]
	distance = distGeo(geoPositionDetectionA, geoPositionDetectionB)
	return(distance)
}

getScannerDistance = function(detectionA, detectionB) {
	scannerA = min(detectionA[,"scanner"], detectionB[,"scanner"])
	scannerB = max(detectionA[,"scanner"], detectionB[,"scanner"])
	selector = distanceScanners$scannerA == scannerA & distanceScanners$scannerB == scannerB
	distance = distanceScanners[selector, "dist_km"]
	return(distance)
}