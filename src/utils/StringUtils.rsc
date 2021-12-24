module utils::StringUtils

import String;
import util::Math;

public str SEPARATOR = "-----------------------";
public str NEW_LINE = "\n";

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