module utils::StringUtils

import String;
import util::Math;

@doc{
	Helper function to detect whitespace
	
	Parameters:
	- str line: line to check for whitespace
	
	Returns:
	- bool
}
public bool isBlank(str line) {
	return size(trim(line)) == 0;
}

@doc{
	Helper function to detect comments.
		
	Parameters:
	- str line: line to check for comments
	
	Returns:
	- bool
	
	TODO: replace this with matching RegEx expression (proper detection for JavaDoc comments, etc.)
}
public bool isComment(str line) {
	trimmed = trim(line);
	return startsWith(trimmed, "//") || startsWith(trimmed, "/*") || startsWith(trimmed, "*") || endsWith(trimmed, "*/");
}

@doc{
	Shortens a real number to a specified length
	
	Paramaters 
	- real number to short
	- int to length to short to; length of 2 shortens to 2 decimals places i.e. 10.1234 becomes 10.12
	
	Returns 
	- real shortened number
}
public real toFixed(real number, int to) {
    list[str] splitString = split(".", toString(number)); 
    str ending = substring(splitString[1], 0, to);
    return toReal(splitString[0] + "." + ending);
}