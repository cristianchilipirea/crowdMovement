source("Scripts/crowdMovement/util/detections.r")
source("Scripts/crowdMovement/util/misc.r")

test.getTotalDuration = function() {
	detections = data.frame(time = c(1, 3, 7, 9, 20), garbage = c(rep(0,5)))
	checkEquals(getTotalDuration(detections), 19)
}

test.sortScannerWiFiDetections = function() {
	detections = data.frame(device = c(1, 2, 1, 2, 2, 2),
							time = c(20, 9, 7, 1, 1, 1),
							seq_nr = c(3, 5, 7, 2, 2, 1),
							scanner = c(1, 1, 1, 2, 1, 1),
							garbage = c(1, 2, 3, 4, 5, 6))
	detectionsOut = data.frame(device = c(1, 1, 2, 2, 2, 2),
							time = c(7, 20, 1, 1, 1, 9),
							seq_nr = c(7, 3, 1, 2, 2, 5),
							scanner = c(1, 1, 1, 1, 2, 1),
							garbage = c(3, 1, 6, 5,4, 2))

	checkEquals(sortScannerWiFiDetections(detections), detectionsOut)
}

test.sortGPSDetections = function() {
	detections = data.frame(device = c(1, 2, 1, 2),
							time = c(20, 9, 7, 1),
							garbage = c(1, 2, 3, 4))
	detectionsOut = data.frame(device = c(1, 1, 2, 2),
							time = c(7, 20, 1, 9),
							garbage = c(3, 1, 4, 2))

	checkEquals(sortGPSDetections(detections), detectionsOut)
}