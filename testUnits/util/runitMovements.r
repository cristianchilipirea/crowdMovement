source("Scripts/crowdMovement/util/movements.r")

test.convertStaticClustersToMovementVector = function() {
	cluster = c(1,1,1,2,2,2,0,0,0,0,3,3,3)
	rez = c(F,F,F,T,F,F,T,T,T,T,T,F,F)
	checkEquals(convertStaticClustersToMovementVector(cluster), rez)

	cluster = c(1,2)
	rez = c(F,T)
	checkEquals(convertStaticClustersToMovementVector(cluster), rez)
}

test.extractMovements = function() {
	movementVector = c(F,F,F,T,F,F,T,T,T,T,T,F,F)
	times = c(1,2,3,4,5,6,7,8,9,10,11,12,13)
	rez = data.frame(startTime = c(3,6,7,8,9,10), endTime = c(4,7,8,9,10,11))
	checkEquals(extractMovements(movementVector, times), rez)
}

test.extractMovements = function() {
	movements = data.frame(startTime = c(3,6,7,8,9,10, 11), endTime = c(4,7,8,9,10,11, 50))
	checkEquals(filterLongMovements(movements, 55), movements)

	movementsEnd = data.frame(startTime = c(3,6,7,8,9,10), endTime = c(4,7,8,9,10,11))
	checkEquals(filterLongMovements(movements, 3), movementsEnd)

	movementsEnd = data.frame(startTime = numeric(), endTime = numeric())
	checkEquals(filterLongMovements(movements, 0), movementsEnd)
}

test.mergeMovements = function() {
	movements = data.frame(startTime = c(3,6,7,8,9,10, 13), endTime = c(4,7,8,9,10,11, 50))
	checkEquals(mergeMovements(movements, -1), movements)

	movementsEnd = data.frame(startTime = c(3,6,13), endTime = c(4,11,50))
	checkEquals(mergeMovements(movements, 0), movementsEnd)

	movementsEnd = data.frame(startTime = c(3), endTime = c(50))
	checkEquals(mergeMovements(movements, 100), movementsEnd)
}

test.limitMovementsToTimeInterval = function() {
	movements = data.frame(startTime = c(3,6,7,8,9,10, 13), endTime = c(4,7,8,9,10,11, 50))
	checkEquals(limitMovementsToTimeInterval(movements, 1, 55), movements)

	movementsEnd = data.frame(startTime = c(3,6,7,8,9,10), endTime = c(4,7,8,9,10,11))
	checkEquals(limitMovementsToTimeInterval(movements, 3, 12), movementsEnd)

	movementsEnd = data.frame(startTime = c(7,8,9,10,13), endTime = c(8,9,10,11,40))
	checkEquals(limitMovementsToTimeInterval(movements, 7, 40), movementsEnd)
}

test.getTimeInCommonMovementSets = function() {
	movementsA = data.frame(startTime = c(3,6,7,8,9,10, 13), endTime = c(4,7,8,9,10,11, 50))
	movementsB = data.frame(startTime = c(3, 14), endTime = c(7, 40))
	checkEquals(getTimeInCommonMovementSets(movementsA, movementsB), 28)
}

test.getTotalMovementDuration = function() {
	movements = data.frame(startTime = c(3,6,7,8,9,10, 13), endTime = c(4,7,8,9,10,11, 50))
	checkEquals(getTotalMovementDuration(movements), 43)
}

