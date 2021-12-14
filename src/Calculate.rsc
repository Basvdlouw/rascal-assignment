@doc{
    Facade module which uses submodules to calculate all available metrics
}
module Calculate

import lang::java::m3::AST;
import lang::java::jdt::m3::Core;
import utils::ProjectUtils;

import metrics::Volume;
import metrics::Duplication;
import metrics::UnitComplexity;
import metrics::UnitSize;


private map[loc, list[str]] getJavaFilesFromProject(loc project) {
	return getJavaFiles(createM3ModelFromProject(project));
}

private map[loc, list[str]] getJavaFilesFromProject(M3 project) {
	return getJavaFiles(project);
}

private list[Declaration] getASTsFromProject(loc project) {
    return getASTs(createM3ModelFromProject(project));
}

private list[Declaration] getASTsFromProject(M3 project) {
    return getASTs(project);
}

@doc{
    Uses submodule metrics::Volume to calculate project volume. 
    
    Only counts Java files, excludes whitespace and comments.

    Parameters:
    - loc project

    Returns:
    - int volume
}
public int calculateProjectVolume(loc project) {
    return calculateVolume(getJavaFilesFromProject(project));
}

public int calculateProjectVolume(M3 project) {
	return calculateVolume(getJavaFilesFromProject(project));
}

@doc{
    Uses submodule metrics::UnitComplexity to calculate amount of units.
    
    Calculate cyclomatic complexity per unit

    Paramters:
    - list[Declaration] list of asts. 

    Returns: 
    - lrel[loc, int, int]:  List relation with location, loc (lines of code), coc (cyclomatic complexity)
}
public map[Declaration, int] calculateProjectCyclomaticComplexityPerUnit(loc project) {
    return calculateCyclomaticComplexityPerUnit(getASTsFromProject(project));
}

public map[Declaration, int] calculateProjectCyclomaticComplexityPerUnit(M3 project) {
    return calculateCyclomaticComplexityPerUnit(getASTsFromProject(project));
}


@doc{
    Uses submodule metrics::UnitSize to calculate amount of units. 
    
    Only counts units in Java files.

    Parameters:
    - loc project

    Returns:
    - int number of units
}
public int calculateProjectNumberOfUnits(loc project) {
    return calculateNumberOfUnits(getASTsFromProject(project));
}

public int calculateProjectNumberOfUnits(M3 project) {
    return calculateNumberOfUnits(getASTsFromProject(project));
}

@doc{
    Uses submodule metrics::UnitSize to calculate amount of units. 
    
	Calculates unit size of an AST, maps every unit in AST to a size (size in loc)

	Parameters:
	- list[Declaration] list of declartions, i.e. an AST 

	Returns:
	- map[Declaration, int] maps every unit to a unit size
}
public map[Declaration, int] calculateProjectUnitSizePerUnit(loc project) {
	return calculateUnitSizePerUnit(getASTsFromProject(project));
}

public map[Declaration, int] calculateProjectUnitSizePerUnit(M3 project) {
	return calculateUnitSizePerUnit(getASTsFromProject(project));
}