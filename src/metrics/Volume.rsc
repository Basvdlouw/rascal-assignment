module metrics::Volume

import utils::StringUtils;


@doc{
	Calculates volume based on a list of files. 
	Volume excludes whitespace and comments.
	
	Parameters:
	- map files: List of files
	
	Returns: 
	- int calculatedVolume
}
public int calculateVolume(map[loc location, list[str] lines] files) {
	int volume = 0;
	for (lines <- files.lines) {
		for (line <- lines, !isBlank(line), !isComment(line)) {
			volume += 1;
		}
	}
	return volume;
}
