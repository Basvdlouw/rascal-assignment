module utils::MathUtils

import configuration::constants::Project;
import util::Math;

@doc {
	Calculate Kloc based on loc metric
	
	Parameters:
	- int linesOfCode loc
	
	Returns:
	- int kloc
}
public int calculateKloc(int linesOfCode) {
	return linesOfCode / 1000;	
}

@doc {
	Calculate percentage, x relative to y
	
	Paramaters:
	- num x
	- num y
	
	Returns: 
	- real percentage
}
public real calculatePercentage(num x, num y) {
	return toReal(x / y * 100.0);
}

public num round(num number) {
	return round(number, DECIMAL_ROUNDING);
}