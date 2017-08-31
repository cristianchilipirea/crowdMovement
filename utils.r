sortDetections = function (detections) {
	detections = detections[order(detections$device, detections$time, detections$seq_nr, detections$scanner),]
	return(detections)
}

fixRowNames = function(toFix) {
	rownames(toFix) = 1:nrow(toFix)
	return(toFix)
}