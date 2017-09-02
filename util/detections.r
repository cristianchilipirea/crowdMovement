getTotalDuration = function(detections) {
	return(max(detections$time) - min(detections$time))
}

sortScannerWiFiDetections = function (detections) {
	detections = detections[order(detections$device, detections$time, detections$seq_nr, detections$scanner),]
	return(detections)
}

sortGPSDetections = function(detections) {
	detections = detections[order(detections$time),]
	return(detections)
}