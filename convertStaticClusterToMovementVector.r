convertStaticClustersToMovementVector = function(clusters) {
	withoutFirst = -1
	withoutLast = -length(clusters)
	movementVector = (clusters == 0) | c(F, clusters[withoutFirst] != clusters[withoutLast])
	movementVector[1] = F
	return(movementVector)
}