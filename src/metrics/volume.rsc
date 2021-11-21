module metrics::volume

import utils::string_utils;


@doc{
	Calculates volume based on a list of files. 
	Volume excludes whitespace and comments.
	
	Params:
	- map files: List of files
	
	Return: 
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
