module visualization::Cache

import configuration::data_types::CountedList;
import Calculate;
import analysis::m3::AST; 
import utils::ProjectUtils;
import IO;

private map[loc, CountedList] cyclomaticComplexityCache = ();
private map[loc, map[Declaration, int]] unitSizesCache = ();
private map[loc, map[node, lrel[node, loc]]] duplicationCache = ();

public CountedList getCyclomaticComplexity(loc project) {
	if(project notin cyclomaticComplexityCache) {
		cyclomaticComplexityCache += (project:calculateProjectCyclomaticComplexityPerUnit(project));
	}
	return cyclomaticComplexityCache[project];
}

public map[Declaration, int] getUnitSizes(loc project) {
	if(project notin unitSizesCache) {
		unitSizesCache += (project:calculateProjectUnitSizePerUnit(project));
	}
	return unitSizesCache[project];
}

public map[node, lrel[node, loc]] getDuplicates(loc project) {
	if(project notin duplicationCache) {
		duplicationCache += (project:calculateClones(project));
	}
	return duplicationCache[project];
}

public void populateCache(list[loc] projects) {
	println("Calculating metrics before starting visualization...");
	for(project <- projects) {
		println("Calculating cyclomatic complexity for <project.authority>...");
		getCyclomaticComplexity(project);
		println("Calculating unit sizes for <project.authority>...");
		getUnitSizes(project);
		println("Calculating duplication for <project.authority>...");
		getDuplicates(project);
	}	
}