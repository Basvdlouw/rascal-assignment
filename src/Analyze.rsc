@doc{
	Facade module which uses submodules to compute Ranks
}
module Analyze

import configuration::data_types::Rank;

import analysis::Volume;
import analysis::Duplication;
import analysis::UnitSize;
import analysis::UnitComplexity;

@doc{
    Uses submodule analysis::Volume to compute project volume rating.

    Parameters:
    - int volume in LinesOfCode (loc)

    Returns:
    - str volume rating
}
public str computeProjectVolumeRating(int volume) {
    return convertRankToLiteral(computeVolumeRating(volume));
}

@doc {
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