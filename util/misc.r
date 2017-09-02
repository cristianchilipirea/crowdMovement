fixRowNames = function(toFix) {
	rownames(toFix) = 1:nrow(toFix)
	return(toFix)
}