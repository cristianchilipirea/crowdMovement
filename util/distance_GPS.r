library('geosphere')

getDistance = function(detectionA, detectionsB) {
	# There can be multiple B detections but only one A
	geoPositionDetectionA = detectionA[,c("latitude", "longitude")]
	geoPositionDetectionB = detectionsB[,c("latitude", "longitude")]
	distance = distGeo(geoPositionDetectionA, geoPositionDetectionB)
	return(distance)
}