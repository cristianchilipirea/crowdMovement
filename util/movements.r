extractMovements = function(movementVector, times) {
	# extract movement times
	nextTimes = times[movementVector]
	prevTimes = times[c(movementVector[-1],F)]

	movements = data.frame(startTime = prevTimes, endTime = nextTimes)
	return(movements)
}

filterLongMovements = function(movements, maxMovementDuration) {
	selector = ((movements$endTime - movements$startTime) < maxMovementDuration)
	movements = movements[selector,]
	return(movements)
}

mergeMovements = function(movements, gapDuration) {
	if(nrow(movements) <= 1)
		return(movements)

	returnMovements = movements[1,]

	for(i in 2:nrow(movements)) {
		last = nrow(returnMovements)
		if(movements$startTime[i] - returnMovements$endTime[last] <= gapDuration) {
			aux = returnMovements$startTime[last]
			returnMovements = returnMovements[-last,]
			returnMovements[last,] = c(aux, movements$endTime[i])
		} else {
			returnMovements[last+1,] = c(movements$startTime[i], movements$endTime[i])
		}
	}
	return(returnMovements)
}

limitMovementsToTimeInterval = function(movements, minTime, maxTime) {
	movements = movements[movements$endTime > minTime, ]
	if(nrow(movements)<=0)
		return(movements)
	rownames(movements) = 1:nrow(movements)
	if(movements$startTime[1] < minTime)
		movements$startTime[1] = minTime
	movements = movements[movements$startTime < maxTime, ]
	if(nrow(movements)<=0)
		return(movements)
	rownames(movements) = 1:nrow(movements)
	if(movements$endTime[nrow(movements)] > maxTime)
		movements$endTime[nrow(movements)] = maxTime
	return(movements)
}

getTimeInCommonMovementSets = function(movementsA, movementsB) {
	sum = 0
	if(nrow(movementsA)<=0)
		return(0)
	if(nrow(movementsB)<=0)
		return(0)
	#TODO optimize this so that we just calculate the sum
	for(i in 1:nrow(movementsA))
		for(j in 1:nrow(movementsB))
			sum = sum+getTimeInCommon(movementsA[i,], movementsB[j,])
	return(sum)
}

getTimeInCommon = function(movementA, movementB) {
	if(movementB$endTime <= movementA$startTime)
		return(0)
	if(movementA$endTime <= movementB$startTime)
		return(0)
	startTime = max(movementA$startTime, movementB$startTime)
	endTime = min(movementA$endTime, movementB$endTime)
	return(endTime - startTime)
}

getTotalMovementDuration = function(movements) {
	return(sum(movements$endTime - movements$startTime))
}

convertStaticClustersToMovementVector = function(clusters) {
	withoutFirst = -1
	withoutLast = -length(clusters)
	movementVector = (clusters == 0) | c(F, clusters[withoutFirst] != clusters[withoutLast])
	movementVector[1] = F
	return(movementVector)
}

plotMovementSets = function(movementSetA, movementSetB) {
	plotStart = min(c(movementSetA$startTime, movementSetB$startTime))
	plotEnd = max(c(movementSetA$endTime, movementSetB$endTime))
	plot(c(movementSetA$startTime[1], movementSetA$endTime[1]), c(1,1), 
		xlim=c(plotStart, plotEnd), xlab="Time",
		ylim=c(0,3), ylab="Movement",
		type="l", lwd=3)
	for(i in 2:nrow(movementSetA)) {
		lines(c(movementSetA$startTime[i], movementSetA$endTime[i]), c(1,1), lwd=3)
	}
	
	for(i in 1:nrow(movementSetB)) {
		lines(c(movementSetB$startTime[i], movementSetB$endTime[i]), c(2,2), lwd=3, col="red")
	}
}

plotMovementsAndDetections = function(movementSetA, detections) {
	plotStart = min(c(movementSetA$startTime, detections$time))
	plotEnd = max(c(movementSetA$endTime, detections$time))
	plot(c(movementSetA$startTime[1], movementSetA$endTime[1]), c(1,1), 
		xlim=c(plotStart, plotEnd), xlab="Time",
		ylim=c(0,3), ylab="Movement",
		type="l", lwd=3)
	for(i in 2:nrow(movementSetA)) {
		lines(c(movementSetA$startTime[i], movementSetA$endTime[i]), c(1,1), lwd=3)
	}
	points(detections$time, rep(2, nrow(detections)), pch=20, col="red")
}