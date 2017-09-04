source("Scripts/crowdMovement/util/misc.r")

getTotalDuration = function(detections) {
	# We do not add + 1 because a movement covering the entire data set would go from min time to max time
	return(max(detections$time) - min(detections$time))
}

sortScannerWiFiDetections = function (detections) {
	detections = detections[order(detections$device, detections$time, detections$seq_nr, detections$scanner),]
	detections = fixRowNames(detections)
	return(detections)
}

sortGPSDetections = function(detections) {
	detections = detections[order(detections$device, detections$time),]
	detections = fixRowNames(detections)
	return(detections)
}