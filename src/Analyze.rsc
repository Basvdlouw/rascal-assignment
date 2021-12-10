@doc{
	Facade module which uses submodules to compute Ranks
}
module Analyze

import configuration::data_types::Rank;
import analysis::m3::AST;
 
import analysis::Volume;
import analysis::Duplication;
import analysis::UnitSize;
import analysis::UnitComplexity;

@doc{
    Uses submodule analysis::Volume
    
    Compute project volume rating.

    Parameters:
    - int volume in LinesOfCode (loc)

    Returns:
    - str volume rating
}
public str computeProjectVolumeRating(int volume) {
    return convertRankToLiteral(computeVolumeRating(volume));
}

@doc {
    Uses submodule analysis::UnitComplexity
    
    Compute Cyclomatic Complexity rating of project

    Parameters: 
    - lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
    - int lines of code in project

    Returns: 
    - Rank rank
}
public str computeProjectCyclomaticComplexityRating(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return convertRankToLiteral(computeCyclomaticComplexity(complexityUnits, projectLinesOfCode));
}

@doc {
	Uses submodule analysis::UnitComplexity
	
	Calculate percentage of simple cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectSimpleCyclomaticComplexityPercentage(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return computeSimpleCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of moderate cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectModerateCyclomaticComplexityPercentage(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return computeModerateCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of high risk cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectHighRiskCyclomaticComplexityPercentage(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return computeHighRiskCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitComplexity

	Calculate percentage of very high risk cyclomatic complexity
	
	Parameters 
	- lrel[locl, int, int] List relation with location, loc (lines of code), coc (cyclomatic complexity)
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectVeryHighRiskCyclomaticComplexityPercentage(lrel[loc, int, int] complexityUnits, int projectLinesOfCode) {
	return computeVeryHighRiskCyclomaticComplexityPercentage(complexityUnits, projectLinesOfCode);
}

//---------------------------

@doc {
    Uses submodule analysis::UnitSize
    
    Compute Unit Size rating of project

    Parameters: 
    - map[Declaration, int] unitSizes units mapped to linesOfCode
    - int lines of code in project

    Returns: 
    - Rank rank
}
public str computeProjectUnitSizeRating(map[Declaration, int] unitSizes, int projectLinesOfCode) {
	return convertRankToLiteral(computeUnitSize(unitSizes, projectLinesOfCode));
}

@doc {
	Uses submodule analysis::UnitSize
	
	Calculate percentage of simple unit sizes
	
	Parameters 
    - map[Declarataion, int] unitSizes unit mapped to linesOfCode per unit
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectSimpleUnitSizePercentage(map[Declaration, int] unitSizes, int projectLinesOfCode) {
	return computeSimpleUnitSizePercentage(unitSizes, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitSize

	Calculate percentage of moderate unit sizes
	
	Parameters 
    - map[Declaration, int] unitSizes unit mapped to linesOfCode per unit
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectModerateUnitSizePercentage(map[Declaration, int] unitSizes, int projectLinesOfCode) {
	return computeModerateUnitSizePercentage(unitSizes, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitSize

	Calculate percentage of high risk unit sizes
	
	Parameters 
    - map[Declaration, int] unitSizes unit mapped to linesOfCode per unit
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectHighRiskUnitSizePercentage(map[Declaration, int] unitSizes, int projectLinesOfCode) {
	return computeHighRiskUnitSizePercentage(unitSizes, projectLinesOfCode);
}

@doc {
	Uses submodule analysis::UnitSize

	Calculate percentage of very high risk unit sizes
	
	Parameters 
    - map[Declaration, int] unitSizes unit mapped to linesOfCode per unit
	- int lines of code in project
	
	Returns:
	- real percentage
}
public real computeProjectVeryHighRiskUnitSizePercentage(map[Declaration, int] unitSizes, int projectLinesOfCode) {
	return computeVeryHighRiskUnitSizePercentage(unitSizes, projectLinesOfCode);
}