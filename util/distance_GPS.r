library('geosphere')

getDistance = function(detectionsA, detectionsB) {
	# There can be multiple B detections but only one A
	geoPositionDetectionA = detectionsA[,c("latitude", "longitude")]
	geoPositionDetectionB = detectionsB[,c("latitude", "longitude")]
	distance = distGeo(geoPositionDetectionA, geoPositionDetectionB)
	return(distance)
}