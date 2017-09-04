source("Scripts/crowdMovement/algorithms/cbsmot.r")
source("Scripts/crowdMovement/algorithms/cbsmot_utils.r")
source("Scripts/crowdMovement/util/distance_GPS.r")

test.epsLinearNeighborhood = function() {
	elements = data.frame(latitude = c(0, 42.05, 42.05001, 45, 42.05), longitude = c(0, 5.02, 5.02001, 10, 5.02))
	checkEquals(epsLinearNeighborhood(2, elements, 100), c(F,T,T,F,F))

	elements = data.frame(latitude = c(0), longitude = c(0))
	checkEquals(epsLinearNeighborhood(1, elements, 100), c(T))

	elements = data.frame(latitude = c(0, 44.408196 , 44.408366 , 44.408571 , 44.4087, 44.40874  ), longitude = c(0, 26.068708, 26.068504, 26.068203, 26.06757, 26.066838))
	checkEquals(epsLinearNeighborhood(2, elements, 100), c(F,T,T,T,F,F))
	checkEquals(epsLinearNeighborhood(4, elements, 100), c(F,T,T,T,T,F))
}

test.isCore = function() {
	checkEquals(isCore(c(F,T,T,T,F,F),data.frame(time = c(1, 5, 6,9,10,11)),3), T)
	checkEquals(isCore(c(F,T,T,T,F,F),data.frame(time = c(1, 5, 6,9,10,11)),20), F)
}

test.cbsmot = function() {
	elements = data.frame(latitude = c(0, 44.408196 , 44.408366 , 44.408571 , 44.4087, 44.40874  ), longitude = c(0, 26.068708, 26.068504, 26.068203, 26.06757, 26.066838), time = c(1,2,3,4,5,6))
	checkEquals(cbsmot(elements, 100, 2), c(0,2,2,2,2,2))
}