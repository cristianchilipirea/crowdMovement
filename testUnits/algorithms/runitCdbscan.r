source("Scripts/crowdMovement/algorithms/cdbscan.r")
source("Scripts/crowdMovement/util/distance_GPS.r")

test.cdbscan = function() {
	elements = data.frame(latitude = c(0, 42.05, 42.05001, 45, 42.05002), longitude = c(0, 5.02, 5.02001, 10, 5.02002))
	checkEquals(cdbscan(elements, 100, 2), c(0,2,2,0,0))
	checkEquals(cdbscan(elements, 100, 1), c(1,2,2,4,2))
	checkEquals(cdbscan(elements, 100, 5), c(0,0,0,0,0))
}