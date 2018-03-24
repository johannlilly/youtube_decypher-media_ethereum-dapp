var halts = function(f) {
	// returns TRUE if f halts, returns FALSE if f is infinite => effectively impossible to write
}

// how does javascript evaluate parameters in a conditional expression?
var condition1 = function() {
	console.log("Condition 1 is being evaluated")
	return true
}

var condition2 = function() {
	console.log("Condition 2 is being evaluated")
	return true
}

if(condition1() && condition2()) {
	console.log("The statement is true")
}