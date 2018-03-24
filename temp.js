var halts = function(f) {
	// returns TRUE if f halts, returns FALSE if f is infinite => effectively impossible to write
}

var returnsTrue = function() {
	return true
}

var infiniteLoop = function() {
	while(true) {
		"..."
	}
}

// proof by contradiction
var contradiction = function() {
	// this assumes that we could, in fact, write the halts() function
	// call halts() on contradiction recursively and inifiniteLoop()
	return halts(contradiction) && infiniteLoop()
}