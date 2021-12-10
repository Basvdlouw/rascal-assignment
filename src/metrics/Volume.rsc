module metrics::Volume

import utils::StringUtils;

@doc{
	Calculates volume based on a list of files. 
	Volume excludes whitespace and comments.
	
	Parameters:
	- map[loc, list[str]] files file loc mapped to lines in file
	
	Returns: 
	- int calculated volume
}
public int calculateVolume(map[loc location, list[str] lines] files) {
	int volume = 0;
	for (lines <- files.lines) {
	 	volume += calculateVolume(lines);
	}
	return volume;
}

@doc{
	Calculate volume based on a list of lines
	Volume excludes whitespace and comments.

	Parameters: 
	- list[str] list of lines (for example one file)

	Returns:
	- int calculated volume
}
public int calculateVolume(list[str] lines) {
	int volume = 0;
	for (line <- lines, !isBlank(line), !isComment(line)) {
			volume += 1;
	}
	return volume;
}