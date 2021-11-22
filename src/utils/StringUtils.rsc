module utils::StringUtils

import String;

@doc{
	Helper function to detect whitespace
	
	Parameters:
	- str line: The line
	
	Returns:
	- bool
}
public bool isBlank(str line) {
	return size(trim(line)) == 0;
}

@doc{
	Helper function to detect comments.
		
	Parameters:
	- str line: The line
	
	Returns:
	- bool
	
	TODO: replace this with matching RegEx expression (proper detection for JavaDoc comments, etc.)
}
public bool isComment(str line) {
	trimmed = trim(line);
	return startsWith(trimmed, "//") || startsWith(trimmed, "/*") || startsWith(trimmed, "*") || endsWith(trimmed, "*/");
}