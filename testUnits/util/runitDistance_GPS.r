source("Scripts/crowdMovement/util/distance_GPS.r")

test.getDistance = function() {
	detectionA = data.frame(latitude = c(0, 42.05), longitude = c(0, 5.02))
	detectionsB = data.frame(latitude = c(0, 42.06), longitude = c(0, 5.05))
	checkEquals(getDistance(detectionA, detectionsB), c(0, 2720), tolerance=1)
}