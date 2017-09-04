source("Scripts/crowdMovement/algorithms/dbscan.r")
source("Scripts/crowdMovement/algorithms/dbscan_utils.r")
source("Scripts/crowdMovement/util/distance_GPS.r")

test.epsLinearNeighborhood = function() {
	elements = data.frame(latitude = c(0, 42.05, 42.05001, 45), longitude = c(0, 5.02, 5.02001, 10))
	checkEquals(epsLinearNeighborhood(2, elements, 100), c(F,T,T,F))
	
	elements = data.frame(latitude = c(0), longitude = c(0))
	checkEquals(epsLinearNeighborhood(1, elements, 100), c(T))
}

test.isCore = function() {
	checkEquals(isCore(c(T,T,F,F,T,T),c(),3), T)
	checkEquals(isCore(c(T,T,F,F,T,T),c(),6), F)
}

test.dbscan = function() {
	elements = data.frame(latitude = c(0, 42.05, 42.05001, 45), longitude = c(0, 5.02, 5.02001, 10))
	checkEquals(dbscan(elements, 100, 2), c(0,2,2,0))
	checkEquals(dbscan(elements, 100, 1), c(1,2,2,4))
	checkEquals(dbscan(elements, 100, 5), c(0,0,0,0))
}