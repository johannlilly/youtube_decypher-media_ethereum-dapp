var halts = function(f) {
	// returns TRUE if f halts, returns FALSE if f is infinite => effectively impossible to write, but assume you can.
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

// Assume that halts(contradiction) returns true
// we would expect the next part of the && statement to get evaluated: the infiniteLoop
// but, if infiniteLoop gets called, then the contradiction() function will loop forever.
// this means that halts(contradiction) should in fact have returned FALSE

// what if we made the wrong assumption?
// Assume that halts(contradiction) returns false
// if halts(contradiction) returns FALSE,
//		then inifiniteLoop() is never going to get evaluated.
//		then the entire statement will return FALSE
//		so, contradiction did terminate
//		therefore, halts(contradiction) should in fact return TRUE 
//		but, it returned FALSE