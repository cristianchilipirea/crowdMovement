epsLinearNeighborhood = function(p, elements, Eps) {
	selector = seq(p-1, 1, length.out = max(p-1-1+1, 0))
	backwardRez = cumsum(consecDistances[selector])

	selector = seq(p, length(consecDistances), length.out = max(length(consecDistances) - p + 1, 0))
	forwardRez = cumsum(consecDistances[selector])

	neighbors = c(rev(backwardRez < Eps), T, forwardRez < Eps)

	return(neighbors)
}

isCore = function(neighbors, t, minTime) {
	neighbors = which(neighbors)
	duration = t$time[max(neighbors)] - t$time[min(neighbors)]
	return(duration >= minTime)
}