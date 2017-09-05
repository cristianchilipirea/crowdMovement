epsLinearNeighborhood = function(p, elements, Eps) {
	backwardRez = c()
	forwardRez = c()
	if(p>1)
		backwardRez = cumsum(consecDistances[(p-1):1])
	if(p<=length(consecDistances))
		forwardRez = cumsum(consecDistances[p:length(consecDistances)])
	neighbors = c(rev(backwardRez < Eps), T, forwardRez < Eps)

	return(neighbors)
}

isCore = function(neighbors, t, minTime) {
	neighbors = which(neighbors)
	duration = t$time[max(neighbors)] - t$time[min(neighbors)]
	return(duration >= minTime)
}