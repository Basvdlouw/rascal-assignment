module utils::MathUtils

@doc {
	Calculate Kloc based on loc metric
	
	Parameters 
	- int linesOfCode loc
}
public int calculateKloc(int linesOfCode) {
	return linesOfCode / 1000;	
}