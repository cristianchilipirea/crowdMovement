getTotalDuration = function(detections) {
	return(max(detections$time) - min(detections$time))
}