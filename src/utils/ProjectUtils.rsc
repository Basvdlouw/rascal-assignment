module utils::ProjectUtils

import IO;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import utils::StringUtils;

@doc{
	Creates an M3 model of an Eclipse project.
	
	Parameters:
	- loc projectLocation: A location to an Eclipse project
	
	Returns: 
	- M3 model
}
public M3 createM3ModelFromProject(loc projectLocation) {
	return createM3FromEclipseProject(projectLocation);
}

@doc{
	Creates an M3 model of an Eclipse file.
	
	Parameters:
	- loc fileLocatio: A location to an Eclipse file
	
	Returns: 
	- M3 model
}
public M3 createM3ModelFromFile(loc fileLocation) {
	return createM3FromEclipseFile(fileLocation);
}

@doc{
	Get java files from M3 model.

	Parameters:
	- M3 model an M3 model
	
	Returns:
	- Map of files

	m3 schemes:
	https://github.com/usethesource/rascal/blob/master/src/org/rascalmpl/library/lang/java/m3/Core.rsc
}
public map[loc, list[str]] getJavaFiles(M3 model) {
	map[loc, list[str]] files = ();
	for (x <- model.containment, x[0].scheme == "java+compilationUnit") {
		files[x[0]] = readFileLines(x[0]);
	}
	return files;
}

@doc{
	Get list of ASTs from M3 model.

	Parameters:
	- M3 model an M3 model
	
	Returns:
	- list[Declaration] does not return list[AST] because createAstFromFile returns Declaration ...

	m3 schemes:
	https://github.com/usethesource/rascal/blob/master/src/org/rascalmpl/library/lang/java/m3/Core.rsc
}
public list[Declaration] getASTs(M3 model) {
	list[Declaration] asts = [];
	for (x <- model.containment, x[0].scheme == "java+compilationUnit") {
		asts += createAstFromFile(x[0], true);
	}
	return asts;
}

@doc{
	Get lines of a unit that are not blank or comments.

	Parameters:
	- loc unitLocation

	Returns:
	- list[str] list of lines from unit
}
public list[str] getUnitLines(loc unitLocation) {
	return [x | x <- readFileLines(unitLocation), !isBlank(x), !isComment(x)];
}