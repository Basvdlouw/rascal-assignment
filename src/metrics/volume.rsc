module metrics::volume

import String;
@doc{
	Calculates volume based on a list of files. 
	Volume excludes whitespace and documentation.
	
	Params: 
}
int calculateVolume(map[loc locations, list[str] lines] files) {
	int volume = 0;
	for (lines <- files.lines) {
		for (line <- lines, !isBlank(line), !isComment(line)) {
			volume += 1;
		}
	}
	return volume;
}
