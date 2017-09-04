source("Scripts/crowdMovement/algorithms/createMovementVector.r")
source("Scripts/crowdMovement/util/distance_GPS.r")

test.createMovementVector = function() {
	elements = data.frame(latitude = c(0, 42.05, 42.05001, 45), longitude = c(0, 5.02, 5.02001, 10))
	checkEquals(createMovementVector(elements, 100), c(F,T,F,T))
}